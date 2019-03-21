%% Behavioral Data

% Actual Trials Data
for k=2
    load(['subj_' num2str(k) '.mat']);
    
    t_p = array2table(p);
    t_p.Properties.VariableNames = {'subj_id'};
    
    t_gender = array2table(convertCharsToStrings(gender));
    t_gender.Properties.VariableNames = {'gender'};
    
    t_age = array2table(age);
    t_age.Properties.VariableNames = {'age'};
    
    %t_risk_aversion = array2table(risk_aversion);
    %t_risk_aversion.Properties.VariableNames = {'risk_aversion'};
    
    t_badcalib = array2table(badcalib);
    t_badcalib.Properties.VariableNames = {'number_of_bad_calibrations'};
    
    t_expstart = array2table(expstart);
    t_expstart.Properties.VariableNames = {'experiment_start_time'};
    
    t_incentivegamble = array2table(incentivegamble);
    t_incentivegamble.Properties.VariableNames = {'trial_chosen_for_payment'};
    
    t_incentiveoutome = array2table(incentiveoutome);
    t_incentiveoutome.Properties.VariableNames = {'trial_outcome_for_payment'};
    
    t_totalnumberofattempts = array2table(sum(numberofattempts));
    t_totalnumberofattempts.Properties.VariableNames = {'total_number_of_quiz_attempts'};
       
    t_com = [t_p t_gender t_age t_badcalib t_expstart t_incentivegamble t_incentiveoutome t_totalnumberofattempts];
    clearvars -except t_com k;
    
    load(['subj_' num2str(k) '.mat']);
    
    tr_p = zeros(length(response),1) + p;
    t_p = array2table(tr_p);
    t_p.Properties.VariableNames = {'subj_id'};
    
    t_trialno = array2table(transpose([1:84]));
    t_trialno.Properties.VariableNames = {'trial'};
    
    t_cbstims = array2table(cbstims);
    t_cbstims.Properties.VariableNames = {'outcome_1' 'outcome_2' 'outcome_3' 'outcome_4' 'outcome_5' 'outcome_6'};
    
    t_response = array2table(transpose(response));
    t_response.Properties.VariableNames = {'response'};
    
    t_trialcond = array2table(transpose(trialcond));
    t_trialcond.Properties.VariableNames = {'trial_condition'};
    
    t_trialstart = array2table(transpose(trialstart));
    t_trialstart.Properties.VariableNames = {'trial_start_time'};
    
    t_trialrt = array2table(transpose(trialrt));
    t_trialrt.Properties.VariableNames = {'trial_reaction_time'};
    
    t_com1 = [t_p t_trialno t_cbstims t_response t_trialcond t_trialstart t_trialrt]; 
    t_com2 = outerjoin(t_com1,t_com,'MergeKeys',true);    
    clearvars -except t_com2 k;
    
    writetable(t_com2,['subj_' num2str(k) '_actual_trials_data.csv'],'Delimiter',',','QuoteStrings',true)
end

% Practice Trials Data
for k=2
    load(['subj_' num2str(k) '.mat']);
    
    t_p = array2table(p);
    t_p.Properties.VariableNames = {'subj_id'};
    
    t_gender = array2table(convertCharsToStrings(gender));
    t_gender.Properties.VariableNames = {'gender'};
    
    t_age = array2table(age);
    t_age.Properties.VariableNames = {'age'};
    
    %t_risk_aversion = array2table(risk_aversion);
    %t_risk_aversion.Properties.VariableNames = {'risk_aversion'};
    
    t_badcalib = array2table(badcalib);
    t_badcalib.Properties.VariableNames = {'number_of_bad_calibrations'};
    
    t_expstart = array2table(expstart);
    t_expstart.Properties.VariableNames = {'experiment_start_time'};
    
    t_incentivegamble = array2table(incentivegamble);
    t_incentivegamble.Properties.VariableNames = {'trial_chosen_for_payment'};
    
    t_incentiveoutome = array2table(incentiveoutome);
    t_incentiveoutome.Properties.VariableNames = {'trial_outcome_for_payment'};
    
    t_totalnumberofattempts = array2table(sum(numberofattempts));
    t_totalnumberofattempts.Properties.VariableNames = {'total_number_of_quiz_attempts'};
       
    t_com = [t_p t_gender t_age t_badcalib t_expstart t_incentivegamble t_incentiveoutome t_totalnumberofattempts];
    clearvars -except t_com k;
    
    load(['subj_' num2str(k) '.mat']);
    
    tr_p = zeros(length(practrialrt),1) + p;
    t_p = array2table(tr_p);
    t_p.Properties.VariableNames = {'subj_id'};
    
    t_practicestims = array2table(practicestims);
    t_practicestims.Properties.VariableNames = {'practice_trial_outcome_1' 'practice_trial_outcome_2' 'practice_trial_outcome_3' 'practice_trial_outcome_4' 'practice_trial_outcome_5' 'practice_trial_outcome_6'};
    
    t_pracresponse = array2table(transpose(pracresponse));
    t_pracresponse.Properties.VariableNames = {'practice_trial_response'};
    
    t_practrialstart = array2table(transpose(practrialstart));
    t_practrialstart.Properties.VariableNames = {'practice_trial_start_time'};
    
    t_practrialrt = array2table(transpose(practrialrt));
    t_practrialrt.Properties.VariableNames = {'practice_trial_reaction_time'};
    
    t_com3 = [t_p t_practicestims t_pracresponse t_practrialstart t_practrialrt]; 
    t_com4 = outerjoin(t_com3,t_com,'MergeKeys',true);
    clearvars -except t_com4 k;

    writetable(t_com4,['subj_' num2str(k) '_practice_trials_data.csv'],'Delimiter',',','QuoteStrings',true)
end

% Quiz Data
for k=2
    load(['subj_' num2str(k) '.mat']);
    
    t_p = array2table(p);
    t_p.Properties.VariableNames = {'subj_id'};
    
    t_gender = array2table(convertCharsToStrings(gender));
    t_gender.Properties.VariableNames = {'gender'};
    
    t_age = array2table(age);
    t_age.Properties.VariableNames = {'age'};
    
    %t_risk_aversion = array2table(risk_aversion);
    %t_risk_aversion.Properties.VariableNames = {'risk_aversion'};
    
    t_badcalib = array2table(badcalib);
    t_badcalib.Properties.VariableNames = {'number_of_bad_calibrations'};
    
    t_expstart = array2table(expstart);
    t_expstart.Properties.VariableNames = {'experiment_start_time'};
    
    t_incentivegamble = array2table(incentivegamble);
    t_incentivegamble.Properties.VariableNames = {'trial_chosen_for_payment'};
    
    t_incentiveoutome = array2table(incentiveoutome);
    t_incentiveoutome.Properties.VariableNames = {'trial_outcome_for_payment'};
    
    t_totalnumberofattempts = array2table(sum(numberofattempts));
    t_totalnumberofattempts.Properties.VariableNames = {'total_number_of_quiz_attempts'};
       
    t_com = [t_p t_gender t_age t_badcalib t_expstart t_incentivegamble t_incentiveoutome t_totalnumberofattempts];
    clearvars -except t_com k;
    
    load(['subj_' num2str(k) '.mat']);
    
    tr_p = zeros(length(quizquestions),1) + p;
    t_p = array2table(tr_p);
    t_p.Properties.VariableNames = {'subj_id'};
    
    t_quizquestions = array2table(transpose(quizquestions));
    t_quizquestions.Properties.VariableNames = {'quiz_question_number'};
    
    t_quizquestionstart = array2table(transpose(quizquestionstart));
    t_quizquestionstart.Properties.VariableNames = {'quiz_question_start_time'};
    
    t_quizquestionrt = array2table(transpose(quizquestionrt));
    t_quizquestionrt.Properties.VariableNames = {'quiz_question_reaction_time'};
    
    t_numberofattempts = array2table(transpose(numberofattempts));
    t_numberofattempts.Properties.VariableNames = {'number_of_attempts'};
    
    t_com5 = [t_p t_quizquestions t_quizquestionstart t_quizquestionrt t_numberofattempts]; 
    t_com6 = outerjoin(t_com5,t_com,'MergeKeys',true);
    clearvars -except t_com6 k;

    writetable(t_com6,['subj_' num2str(k) '_quiz_questions_data.csv'],'Delimiter',',','QuoteStrings',true)
end


%% Eye tracking Data

% Get Events and Samples data
for k=2
    tab_nam = strcat('subj_',num2str(k),'.edf');
    edf = Edf2Mat(tab_nam);
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
    fix = array2table(fixd);
    fix.Properties.VariableNames = {'time','FixStart','FixEnd','FixDuration','FixPosX','FixPosY'};
       
    saccd = [edf.Events.Esacc.start' edf.Events.Esacc.start' edf.Events.Esacc.end' edf.Events.Esacc.duration' edf.Events.Esacc.posX' edf.Events.Esacc.posY' edf.Events.Esacc.posXend' edf.Events.Esacc.posYend'];
    sacc = array2table(saccd);
    sacc.Properties.VariableNames = {'time','SaccStart','SaccEnd','SaccDuration','SaccPosX','SaccPosY','SaccPosXEnd','SaccPosYEnd'};

    t_com2 = outerjoin(t_com,blink,'MergeKeys',true);
    t_com3 = outerjoin(t_com2,fix,'MergeKeys',true);
    t_com4 = outerjoin(t_com3,sacc,'MergeKeys',true);
    data_et = outerjoin(t_com4,t,'MergeKeys',true);
    clearvars -except data_et k;
    
    save(['subj_' num2str(k) '_edf.mat']);    
    %writetable(data_full,['edf' num2str(k)]);
    writetable(data_et,['subj_' num2str(k) '_eye_tracking_data.csv'],'Delimiter',',','QuoteStrings',true)
    clear
end