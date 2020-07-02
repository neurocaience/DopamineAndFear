% For an input folder, if there is a csv file in the folder, extract it: 
function [fileName_out, res] = extractCSV(folder)
    files = dir(folder);
    for f = 1:length(files)
        fileName = files(f).name;
        if strfind(fileName, '.csv') >= 0
            disp(fileName)
            ff = fullfile(folder, fileName);            
            res = xlsread(ff);
            disp([ 'CSV file: ' fileName ' ------------------------------' ] )
            disp(squeeze(res(1:5,:)))  % Display header
            fileName_out=fileName;
            
            %disp('extractCSV:')
            %disp(folder)
            %disp(fileName_out)
        end
    end
end