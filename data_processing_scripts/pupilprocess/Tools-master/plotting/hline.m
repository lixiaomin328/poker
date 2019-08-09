function hline(y, varargin)

% HLINE plot a horizontal line in the current graph

abc = axis;
y = [y y];
x = abc([1 2]);
if length(varargin) == 0,
    varargin = {'color', [0.5 0.5 0.5], 'linewidth', 0.5};
elseif length(varargin)==1
    varargin = {'color', varargin{1}, 'linewidth', 0.5};
elseif length(varargin)==2
    varargin = {'color', varargin{1}, 'linewidth', varargin{2}};
end
h = line(x, y);
set(h, varargin{:});

