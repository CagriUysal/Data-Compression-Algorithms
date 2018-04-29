% lzw comprassion function wrapper
% It calls lempel_ziv function which is taken below
% https://www.mathworks.com/matlabcentral/fileexchange/29772-example-of-lempel-ziv-coding

function [code, compression_rate] =  lz_wrapper(text_file)

    fileContents = fileread(text_file); % convert txt file to char array
    alphabet = unique(fileContents); % find the unique chars in the text (alphabet of the array)
    
    [code ,binary_code, code_book ] = lempel_ziv(alphabet, fileContents);
    
    raw_input = dec2bin(fileContents);
    size_before_comp = numel(raw_input);
    size_after_comp = numel(binary_code);
    
    compression_rate = size_after_comp / size_before_comp;
    
    %%%%%%%%%%%%%%%%% PRINT THE RESULT TO THE FILE %%%%%%%%%%%%%%%%%

    fileID = fopen('./results/lempelziv_results.txt', 'w');

    fprintf(fileID, ['%s' '%d\n'], "Size of file before compression(bits):  ", size_before_comp);
    fprintf(fileID, ['%s' '%d\n'], "Size of file after compression(bits):  ", size_after_comp);
    fprintf(fileID, ['%s' '%f\n'], "Compression:  ", compression_rate);

    fclose(fileID);
end