function [comp, compression_rate] = arithmetic(text_file)

fileContents = fileread(text_file); % convert txt file to char array

text_length = length(fileContents); % total number of characters in the text
distinct_chars = unique(fileContents); % find the unique chars in the text
num_of_dist_chars = length(distinct_chars); % number of unique character


% fill the sequence with integers,
% according to proper char mapping
% The reason is matlab's built in funtion arithenco only 
% works with integer sequences
sequence = zeros(1, text_length);
for i = 1:text_length
    index = find(distinct_chars == fileContents(i)); % find the mapping of char to integer
    sequence(i) = index; % fill the integer sequence
end
    
char_occurances = zeros(1, num_of_dist_chars);
for i = 1:num_of_dist_chars
    % find total occurance of each unique char in text
    char_occurances(i) = length(strfind(fileContents, distinct_chars(i)));
end % end for

comp = arithenco(sequence, char_occurances);

raw_input = dec2bin(fileContents);
size_before_comp = numel(raw_input);

decoded = dec2bin(comp);
size_after_comp = numel(decoded);

compression_rate = size_after_comp / size_before_comp;

%%%%%%%%%%%%%%%%% PRINT THE RESULT TO THE FILE %%%%%%%%%%%%%%%%%

fileID = fopen('./results/arithmetic_results.txt', 'w');

fprintf(fileID, ['%s' '%d\n'], "Size of file before compression(bits):  ", size_before_comp);
fprintf(fileID, ['%s' '%d\n'], "Size of file after compression(bits):  ", size_after_comp);
fprintf(fileID, ['%s' '%f\n'], "Compression:  ", compression_rate);

fclose(fileID);

end % end function