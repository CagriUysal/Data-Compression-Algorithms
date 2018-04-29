function [codice, code_bin, code_book] = lempel_ziv(alfabeto, stringa)

%Test with str='bcababbcabcbcbbccaabbababb' e alf=['a' 'b' 'c']

alf=alfabeto;   % It's the alphabet that contains the char used in the string
str=stringa;    % It's the string to codify
code_book=cell(length(alf),1);      % Initializes the code-book
for i=1:1:length(alf)               % Inserts in code-book the firsts elements
    code_book{i}=alf(i);
end

k=str(1);   % It's the first word to codify
codice=[];  % Initializes the variable used to save the decimal code
i=1;
index=1;
while i<=length(str)   
    trovato=0;
    for i=1:length(code_book)
        if(length(k)==length(code_book{i}))  % Checks if the word to codify is already contained in the code-book 
            if(strcmp(k,code_book{i})==1)
                z=i;    % It's the decimal code of the word to codify
                trovato=1;
            end
        end
    end
    if trovato==0   % If the word isn't contained in the code-book, updates the code-book
        code_book{length(code_book)+1}=k;
        codice(length(codice)+1)=z;     % Update the decimal code of the known word
        k=k(length(k));     % Takes the unknown part of the word
    end
    if trovato==1  % Else updates the decimal code, increments the index and checks the string's end      
        index=index+1;
        if index>length(str)    % If string terminates, it codifies the last word
            for i=1:length(code_book)
                if(length(k)==length(code_book{i}))
                    if(strcmp(k,code_book{i})==1)
                        z=i;
                    end
                end
            end
            codice(length(codice)+1)=z;
            break;
        end
        k=[k str(index)];   % Takes a new word
    end
end
code_bin=dec2bin(codice);   % Codifies with binary code the result