function [valueFor128B] = GetValueForChar(character)
%This function takes one character in the form of a string and returns the
%code 128B value number for that character.
%Input: character = this is the character entered (eg: 'J')
%Output: valueFor128B = code 128B value number for the inputted character.
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
    if (strcmp(code128B{row,2}, character))
        match = 1;
    else
        %Moving on to next row in the cell array
        row = row + 1;
    end
end
%First row of the cell array contains the value 0, so subtract 1.
valueFor128B = row - 1;
return