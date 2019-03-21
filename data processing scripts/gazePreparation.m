function gazePreparation(saveDir,filename,dataPath)
    addpath('/Users/lixiaomin/Documents/GitHub/poker/edf-converter')
    edf = Edf2Mat([dataPath,filename]);
    t = struct2table(edf.Samples);
    t2 = struct2table(edf.Events.Messages);
    t_mod = t2.time';
    t_mod2 = t2.info';
    t_mod3 = array2table(t_mod);
    t_mod4 = cell2table(t_mod2);
    t_com = [t_mod3 t_mod4];
    t_com.Properties.VariableNames = {'time' 'message'};

    blinkd = [edf.Events.Eblink.start' edf.Events.Eblink.start' edf.Events.Eblink.end'];
    blink = array2table(blinkd);
    blink.Properties.VariableNames = {'time','BlinkStart','BlinkEnd'};
    
    fixd = [edf.Events.Efix.start' edf.Events.Efix.start' edf.Events.Efix.end' edf.Events.Efix.duration' edf.Events.Efix.posX' edf.Events.Efix.posY'];
    if isempty(fixd)
        return
    end
    fix = array2table(fixd);
    fix.Properties.VariableNames = {'time','FixStart','FixEnd','FixDuration','FixPosX','FixPosY'};
       
    saccd = [edf.Events.Esacc.start' edf.Events.Esacc.start' edf.Events.Esacc.end' edf.Events.Esacc.duration' edf.Events.Esacc.posX' edf.Events.Esacc.posY' edf.Events.Esacc.posXend' edf.Events.Esacc.posYend'];
    sacc = array2table(saccd);
    sacc.Properties.VariableNames = {'time','SaccStart','SaccEnd','SaccDuration','SaccPosX','SaccPosY','SaccPosXEnd','SaccPosYEnd'};

    t_com2 = outerjoin(t_com,blink,'MergeKeys',true);
    t_com3 = outerjoin(t_com2,fix,'MergeKeys',true);
    t_com4 = outerjoin(t_com3,sacc,'MergeKeys',true);
    data_et = outerjoin(t_com4,t,'MergeKeys',true);
    save([saveDir filename(1:4) '_edf.mat'],'data_et');    
    %writetable(data_full,['edf' num2str(k)]);
    %writetable(data_et,[filename(1:2) '_eye_tracking_data.csv'],'Delimiter',',','QuoteStrings',true)
end
