function [character] = GetCharForPattern(codePattern)
%This function takes a code 128B pattern (in the form of a string of 1's
%and 0's) for a single character and returns the encoded character.
%Input: codePattern = string of 1's and 0's that encodes the character.
%Output: character = character encoded (eg: 'H'). Returned as a string.
%Author: Nitish Lobo

%Loading file containing the code 128B values onto the function's workspace
load('code128B.mat');

%Row variable describes the row to be accessed from the code128B cell array
%match variable is 1 when the string entered is the same as the string
%found from the file. Otherwise match equals 0.
row = 1;
match = 0;
while (~match)
    %Comparing character inputted with each row in the cell array until a
    %match is made.
    if (strcmp(code128B{row, 3}, codePattern));
        match = 1;
    else
        %Moving on to next row in the file
        row = row + 1;
    end
end

%Getting the character associated to the original string input.
character = code128B{row, 2};
return