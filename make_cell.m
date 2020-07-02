function mycell = make_cell(data, word)
% This function makes a cell prefilled with the value 'word' 
% the cell is the same length and size as data

mycell = cell(length(data),1);
for k = 1:length(data)
    mycell{k} = word;
end

end