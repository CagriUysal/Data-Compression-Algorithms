function H = text_entropy(text_file)
    fileContents = fileread(text_file); % convert txt file to char array

    text_length = length(fileContents); % total number of characters in the text
    distinct_chars = unique(fileContents); % find the unique chars in the tex
    num_of_dist_chars = length(distinct_chars); % number of unique characters
        
    char_occurances = zeros(1, num_of_dist_chars);
    for i = 1:num_of_dist_chars
         % find total occurance of each unique char in text
         char_occurances(i) = length(strfind(fileContents, distinct_chars(i)));
    end % end for
        
    char_prob = char_occurances / text_length; % determine probablities of each char to occur in text
        
    H = 0;
    for i = 1:num_of_dist_chars
        H = H + (-char_prob(i)*log2(char_prob(i))); % calculate entropy using mathematical definition
    end % end for
    
end % end function