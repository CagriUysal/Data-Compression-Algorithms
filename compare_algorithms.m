% This file compares 4 different compression algorithms,
% namely binary huffman, ternary huffman, arithmetic and LZ coding.
% Compression algorithms tested on a sample text file.
% At the and compression rates are compared on a graph.

Entropy = text_entropy('chapter19.txt');

fprintf('Entropy of the file is %.2f', Entropy);

[com1, rate_binary] = binary_huffman('chapter19.txt');
[com2, rate_ternary] = ternary_huffman('chapter19.txt');
[com3, rate_arithmetic] = arithmetic('chapter19.txt');
[com4, rate_lz] = lz_wrapper('chapter19.txt');


rates = [rate_binary rate_ternary rate_arithmetic rate_lz];
%rates = [.3 .5 .6 .1];


c = categorical({'binary', 'ternary', 'arithmetic', 'lempel ziv'});

length(c)

% create bar graph
figure = bar(c, rates);

% Add title
title('Comparision of algorithms')
xlabel('Algorithms')
ylabel('Compression Rates')

saveas(figure, 'comp.jpeg');
