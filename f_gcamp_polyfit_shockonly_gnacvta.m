function [gcamp_output] = f_gcamp_polyfit_shockonly_gnacvta(mID,days,d,ttlchannel,ttlsign)
%% This function filters gcamp data 
% Inputs:
% For filename recognition: 
% dir           % Directory where file is located (string)
% mID           % mouse ID (string)
% days          % day of experiment (string)
%
% Outputs: 
% saveas(PDF)   % saves plots as PDF for sanity check
% gcamp         % outputs matrix. column 1: Tone  (1 = tone, 0 = nothing)
%                                 column 2: Shock (1 = shock, 0 = nothing)
%                                 column 3: GCamp SD (in Standard dev)
%               % Around length 213820


% parameters
Fs = 100;               % GCamp sampling rate

fn = ['gcamp_' mID '_' days '.csv'];
disp(fn)

gcamp = xlsread(fn);

%% Plot all data, no filter
x1 = linspace(1,length(gcamp)/Fs, length(gcamp));

figure, goodfig, hold on;

subplot(4,1,2), hold on, 
plot(x1, gcamp(:,5))
xlim([380 480])
xlim([380 480])
xlabel('Time (s)')
ylabel('Raw Signal')
title('Random Zoomed-In Snipet')

%% Polyfit

x2 = 1:length(gcamp(:,5));      % create x vector
y1 = gcamp(:,5);                % assign y vector

validdata = ~isnan(gcamp(:,5)); % When Y (Gcamp signal) is NaN, make X also NaN
x1_valid = x2(validdata);
y1_valid = y1(validdata);

p = polyfit(x1_valid, y1_valid',2); 
y1_polyval = polyval(p,x2);

new = gcamp(:,5) - y1_polyval'; 
xmean = nanmean(new);           % before 6/29/2017: xmean = nanmean(gcamp(:,5));
A = new - xmean;
gcamp(:,6) = A/nanstd(new);

% Plot polyfit and raw data
subplot(4,1,1)
hAx = plotyy([x1', x1'], [gcamp(:,5), y1_polyval'],[x1' , x1'] ,[gcamp(:,4),gcamp(:,3)]);
ylabel(hAx(2), 'TTL Tone+Shock (V)') 
ylabel(hAx(1), 'Raw Signal')
title([mID '_' days], 'interpreter', 'none')

% Extract Stim File

thresh_tone = -2; 
stim_tone = zeros(1,length(gcamp));     % create new tone TTL
stim_shock = zeros(1,length(gcamp));    % create new shock TTL
s_value = 1;                            % set new TTL value

if ttlchannel == 1      % If the shock is in channel 1, and tone is in channel 2, and TTL sign is negative
    for k=1:length(gcamp)-1
        if gcamp(k,3) <=thresh_tone    % TTL in tone and shock directly reflects them, all is good
            stim_shock(k) = s_value;
        end
        
        if gcamp(k,4) <=thresh_tone    % TTL in tone and shock directly reflects them, all is good
            stim_tone(k) = s_value;
        end
    end
    disp('ttlch=1')
else                   % If shock/tone is in channel 1, and tone channel doesn't work
    if ttlsign == 1     % If TTL sign is NEGATIVE
        if d == 1    % If it's FC day
            for k=1:length(gcamp)-1
                if gcamp(k,3) <=thresh_tone    % (1) assign shock values - all tones will have a 'shock' at end
                    stim_shock(k) = s_value;
                end
            end
            for k=1:length(gcamp)-1            % (2) from the 'shocks', derive the tones
                if stim_shock(k)==1 && stim_shock(k+1)==0
                    stim_tone(k-1999:k)=1;
                end
            end
            
%             j=0;
%             for k=1:length(gcamp)-1            % (3) get rid of the first 10 'shocks' because they are not shocks
%                 if j<10 && stim_shock(k)==1 && stim_shock(k+1)==0
%                     stim_shock(k-2050:k)=0;
%                     j=j+1;
%                 end
%             end
            disp('ttlch=2,ttlsign=1, fc')
        else            % If it's Ext day,
            for k=1:length(gcamp)-1
                if gcamp(k,3) <= thresh_tone   % change the column to channel 1 as tone
                    stim_tone(k) = s_value;
                end
            end
            disp('ttlch=2,ttlsign=1, ext')
        end
    else                % If TTL sign is POSITIVE
        thresh_tone = 2;  % change the tone threshhold
        if d == 1    % If it's FC day
            for k=1:length(gcamp)-1
                if gcamp(k,3) >=thresh_tone    % (1) assign shock values
                    stim_shock(k) = s_value;
                end
            end
            for k=1:length(gcamp)-1            % (2) from the 'shocks', derive the tones
                if stim_shock(k)==1 && stim_shock(k+1)==0
                    stim_tone(k-1999:k)=1;
                end
            end
%             j=0;
%             for k=1:length(gcamp)-1            % (3) get rid of the first 10 'shocks' because they are not shocks
%                 if j<10 && stim_shock(k)==1 && stim_shock(k+1)==0
%                     stim_shock(k-2050:k)=0;
%                     j=j+1;
%                 end
%             end
%             disp('ttlch=2,ttlsign=2, fc')
        else            % If it's Ext day
            for k=1:length(gcamp)-1
                if gcamp(k,3) >= thresh_tone   % change the column to channel 1 as tone, change sign to >=
                    stim_tone(k) = s_value;
                end
            end
            disp('ttlch=2,ttlsign=2, ext')
        end
        
    end
end

% plot polynomial fit
subplot(4,1,3)
hAx = plotyy(x1, gcamp(:,5), [x1', x1', x1'], [gcamp(:,6), -stim_shock', stim_tone']);
ylabel(hAx(2), 'Polyfit Signal, z-scored (SD)') 
ylabel(hAx(1), 'Raw Signal')
title(['Polyfit ' mID '_' days], 'interpreter', 'none')

subplot(4,1,4)
hAx = plotyy(x1, gcamp(:,5), x1', gcamp(:,6));
ylabel(hAx(2), 'Polyfit Signal, z-scored (SD)') 
ylabel(hAx(1), 'Raw Signal')
xlim(hAx(1),[380 390])
xlim(hAx(2),[380 390])
title(['Polyfit' mID '_' days 'Zoomed in'], 'interpreter', 'none')


%% Create output matrix and assign values
gcamp_output = nan(length(gcamp),3);
gcamp_output(:,1) = stim_shock; 
gcamp_output(:,2) = stim_tone;
gcamp_output(:,3) = gcamp(:,6);                 % Column 3 is signal. (New filtered signal is stored in col 6)

% % Save image of PDF
% cd(dir2_picsave);   % save image in other folder
% file = [mID '_' days];
% saveas(gcf, file,'png')
% cd(dir);            % return to current folder