function [codePattern] = GetPatternForValue(valueFor128B)
%This function takes a code 128B value number that encodes for a particular
%character and returns the equivalent code 128B pattern as a string of
%1's and 0's.
%Input: valueFor128B = code 128B value number
%Output: codePattern = the string of 1's and 0's that encodes the character
%Author: Nitish Lobo

%Loading file containing the code 128B values onto the function's workspace
load('code128B.mat');

%The row of the code128B cell array that has the string is 1 more than the
%code128B value.
codePattern = code128B{(valueFor128B+1), 3};
return