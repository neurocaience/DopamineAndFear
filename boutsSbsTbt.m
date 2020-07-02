%% boutsSbsTbt() This function get bouts, second-by-second, and trial-by-trial data
% Lili X. Cai 3/6/2020

function [master_frz_bouts, cnn_sbs, cnn_sbs_bouts, cnn_tbt, cnn_tbt_bouts] = boutsSbsTbt(frz, bouts_option)

    if nargin < 2
        bouts_option = 0;  % Do not output bouts
        master_frz_bouts = [];
        cnn_sbs_bouts = [];
        cnn_tbt_bouts = [];
    end
    
    if bouts_option == 1
    % Run bout analysis on freezing files
    master_frz_bouts = bouts(11,frz);  
    % Extract sbs freezing: 
    cnn_sbs_bouts = format1s(master_frz_bouts);
    % Multiply by 100 o get freezing %:
    cnn_sbs_bouts = cnn_sbs_bouts*100; 
    % Extract trial-by-trial freezing: 
    cnn_tbt_bouts = frz_eval(cnn_sbs_bouts,0,19,tones, num_cs);   % B= bouts, S = 1s 
    end
    
    tones = load('tones.mat');
    tones = tones.tones;


    % Extract sec-by-sec freezing
    cnn_sbs = format1s(frz);
    

    % Multiply by 100 to get % freezing
    cnn_sbs = cnn_sbs*100;
   

    % Extract trial-by-trial freezing 
    num_cs = 21;
    cnn_tbt = frz_eval(cnn_sbs,0,19,tones, num_cs);       
    
    % Output files: 
    % master_frz_bouts = bout version of original frz file
    % cnn_sbs          = second-by-second file without bouts
    % cnn_sbs_bouts    = second-by-second file with bouts
    % cnn_tbt          = trial-by-trial without bouts
    % cnn_tbt_bouts    = trial-by-trial with bouts

end