function [sts, import] = pspm_get_events(import)
% SCR_GET_EVENTS processes events for different event channel types
% FORMAT: [sts, data] = pspm_get_events(import)
%               import: import job structure with mandatory fields 
%                  .data
%                  .marker ('timestamps', 'continuous')
%                  .sr (timestamps: timeunits in seconds, continuous: sample rate in 1/seconds)
%                  and optional field
%                  .flank ('ascending', 'descending', 'both': optional field for
%                   continuous channels; default: both)
%           returns event timestamps in seconds in import.data
%__________________________________________________________________________
% PsPM 3.0
% (C) 2013-2015 Dominik R Bach & Tobias Moser (University of Zurich)
%
% $Id: pspm_get_events.m 452 2017-07-04 07:59:19Z tmoser $
% $Rev: 452 $

global settings;
if isempty(settings), pspm_init; end;

% initialise
% -------------------------------------------------------------------------
sts = -1;

% get data
% -------------------------------------------------------------------------
if ~isfield(import, 'marker')
    warning('ID:nonexistent_field', 'The field ''marker'' is missing'); return;
elseif strcmpi(import.marker, 'continuous')
    % determine relevant data points
    
    % filtering noise does not yet work! -> any kind of noise will be 
    % identified as maxima/minima
    
    % copy from findLocalMaxima / findpeaks / signal processing toolbox
    % with a small change not to loose data with diff()
    data = import.data;
       
    % ensure the incoming data is in the format we need it to be 
    % to process it accordingly (must be vertical)
    dim = size(data);
    if dim(1) == 1 
        data = data';
    end
    
    % add more data in order to prevent deleting values with diff
    data = [NaN; NaN; NaN; data; NaN; NaN; NaN;];
    % store information about finite and infinite in vector
    % used to reduce temp vector to relevant data
    finite = ~isnan(data);
    % initialize temp array and transpose to have a vertical vector
    temp = (1:numel(data)).';
    
    % just pick inequal neighbor values of which at least one has a valid
    % value
    iNeq = [1; 1+ find((data(1:end-1) ~= data(2:end)) ...
         & ((finite(1:end-1) | finite(2:end))))];
    temp = temp(iNeq);
    
    % we want to check for a difference within a trend
    % not for a difference between values -> usage of sign()
    % diff the whole dataset not to loose relevant data
    s = sign(diff(data));
    d = diff(s);

    % where are the sign changes of the corresponding differences
    % lo2hi should be minima
    % hi2lo should be maxima
    lo2hi = temp(1+find(d(temp(2:end-1)-2) > 0))-3;
    hi2lo = temp(1+find(d(temp(2:end-1)-2) < 0))-3;

    if isempty(lo2hi) && isempty(hi2lo)
        fprintf('\n');
        warning('No markers, or problem with TTL channel.');
        import.data = [];
    elseif isfield(import, 'flank') && strcmpi(import.flank, 'ascending')
        import.data = lo2hi./import.sr; 
        mPos = lo2hi+3; 
    elseif isfield(import, 'flank') && strcmpi(import.flank, 'descending')
        import.data = hi2lo./import.sr;
        mPos = hi2lo+2;
    elseif numel(lo2hi) == numel(hi2lo)
        % only use mean if amount of minima corresponds to amount of maxima
        % otherwise output a warning
        import.data = mean([lo2hi, hi2lo], 2)./import.sr;
        mPos = mean([lo2hi, hi2lo],2);
    else
        fprintf('\n');
        warning('Different number of hi2lo and lo2hi transitions in marker channel - please choose ascending or descending flank.');
        import.data = [];
        return;
    end;
    
    % check if markerinfo should be set and if there are any data points
    if ~isfield(import, 'markerinfo') && ~isempty(import.data)
        
        % determine baseline
        v = unique(data(~isnan(data)));
        for i=1:numel(v)
            v(i,2) = numel(find(data == v(i,1)));
        end
        
        % ascending sorting: most frequent value is at the end of this
        % vector
        v = sortrows(v, 2);
        baseline = v(end, 1);
        
        % we are interested in the delta -> remove "baseline offset"
        values = data(round(mPos)) - baseline;
        import.markerinfo.value = values;
        
        % prepare values to convert them into strings
        values = num2cell(values);
        import.markerinfo.name = cellfun(@num2str, values, 'UniformOutput', false);
        
        
        % add one second of tolerance because tails are added at the
        % beginning. and maybe sometimes values might not be exactly the
        % same
    elseif isfield(import, 'markerinfo') && ...
            (numel(data) - numel(import.markerinfo.value))/import.sr < 1
        % also translate marker info if necessary. this code was written
        % with and for import_eyelink function. there flank = 'ascending' 
        % has to be set to use import.data as index for the marker values.
        
        n_minfo = struct('value', {import.markerinfo.value(round(import.data*import.sr))}, ...
            'name', {import.markerinfo.name(round(import.data*import.sr))});
        
        import.markerinfo = n_minfo;
    end
    
elseif strcmpi(import.marker, 'timestamp') || strcmpi(import.marker, 'timestamps')
    import.data = import.data(:) .* import.sr;
else
    warning('ID:invalid_field_content', 'The value of ''marker'' must either be ''continious'' or ''timestamps'''); return;
end;

% set status
% -------------------------------------------------------------------------
sts = 1;