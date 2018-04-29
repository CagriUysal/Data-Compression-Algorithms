function [comp, compression_rate] = ternary_huffman(text_file)

fileContents = fileread(text_file); % convert txt file to char array

text_length = length(fileContents); % total number of characters in the text
distinct_chars = unique(fileContents); % find the unique chars in the text
num_of_dist_chars = length(distinct_chars); % number of unique character

% convert char array to cell array
% because huffmandict only accepts cell arrays !
C{1, num_of_dist_chars} = [];
for i = 1:num_of_dist_chars
   C{1, i} = distinct_chars(i);
end % end for

% convert text to cell arrays also,
% again huffmanenco only accepts cell arrays !
C_text{1, text_length} = [];
for i = 1:text_length
    C_text{1, i} = fileContents(i);
end

char_occurances = zeros(1, num_of_dist_chars);
for i = 1:num_of_dist_chars
    % find total occurance of each unique char in text
    char_occurances(i) = length(strfind(fileContents, distinct_chars(i)));
end % end for

char_prob = char_occurances / text_length; % determine probablities of each char to occur in text

[dict, avglen] = huffmandict(C, char_prob, 3); % find huffman dictionary

comp = huffmanenco(C_text, dict); % encode with binary huffman

raw_input = dec2bin(fileContents);
size_before_comp = numel(raw_input);

decoded = dec2bin(comp);
size_after_comp = numel(decoded);

compression_rate = size_after_comp / size_before_comp;

dict(:, 2) = cellfun(@num2str, dict(:, 2), 'UniformOutput', false);

%%%%%%%%%%%%%%%%% PRINT THE RESULT TO THE FILE %%%%%%%%%%%%%%%%%

fileID = fopen('./results/ternary_huffman_results.txt', 'w');

% (probability - 'char' - ternary_code) 
format_spec = ['%c' '%s' '%f' '%s' '%-15s\n'];
blank = '     ';
for i = 1:num_of_dist_chars
    fprintf(fileID, format_spec, C{i}, blank, char_prob(i), blank, dict{i, 2});
    
end

fprintf(fileID, '\n\n\n');
fprintf(fileID, ['%s' '%d\n'], "Average length(bits):  ", avglen);
fprintf(fileID, ['%s' '%d\n'], "Size of file before compression(bits):  ", size_before_comp);
fprintf(fileID, ['%s' '%d\n'], "Size of file after compression(bits):  ", size_after_comp);
fprintf(fileID, ['%s' '%f\n'], "Compression:  ", compression_rate);

fclose(fileID);

end % end function