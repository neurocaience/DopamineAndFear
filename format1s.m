%% format1s() This function takes a variable length freezing matrix
% Input: freezing matrix 
%        2D: (1) Experiment/Mouse     (2) Samples
%        3D: (1) # Mice, (2) Ext day, (3) Samples
% Output: bins by sampling rate (Default Fs=11.23)

function out_1s = format1s(out, args)
    if nargin <= 1
        args.Fs = 11.23;
        args.totSeconds = 2250;
    end
    
    % disp('2...')
    d = size(out);   % dimensions of input matrix
    dim = size(d,2);   % # of dimensions of input matrix
    
    % Create out matrix, based on dimensions of input dimensions
    if dim == 2
        out_1s = nan(d(1), args.totSeconds);
        for m = 1:d(1)
            for s = 1:(args.totSeconds+20)
                % ts = time_start (index)
                % te = time_end (index)
                if s == 1
                    ts = 1;                     % If s ('second') is 1, it's 1
                else
                    ts = ceil(s*args.Fs - args.Fs);    % If it's another second, round by sampling rate
                end
                te = floor((s+1)*args.Fs - args.Fs);
                
                try
                    % Take the mean between index time_start and time_end
                    out_1s(m,s) = nanmean(out(m,ts:te));
                catch
                    % If it doesn't work, it means it's the end of file.
                    % Print catch statement:
                    disp(['m' num2str(m) ', End of file s=' num2str(s) ', ts=' num2str(ts) ', te=' num2str(te)])
                    break;
                end
            end
        end
    end
    
    if dim == 3
        out_1s = nan(d(1), d(2), args.totSeconds);
        for m = 1:d(1)
            for expd = 1:d(2)
                for s = 1:(args.totSeconds+20)
                    % ts = time_start (index)
                    % te = time_end (index)
                    if s == 1
                        ts = 1;                     % If s ('second') is 1, it's 1
                    else
                        ts = ceil(s*args.Fs - args.Fs);    % If it's another second, round by sampling rate
                    end
                    te = floor((s+1)*args.Fs - args.Fs);
                    
                    try
                        % Take the mean between index time_start and time_end
                        out_1s(m,expd,s) = nanmean(out(m,expd,ts:te));
                    catch
                        % If it doesn't work, it means it's the end of file.
                        % Print catch statement:
                        disp(['m' num2str(m) ', expd' num2str(expd) ', End of file s=' num2str(s) ', ts=' num2str(ts) ', te=' num2str(te)])
                        break;
                    end
                end
            end
        end
    end
end
