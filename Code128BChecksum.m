function [checksumValue] = Code128BChecksum(code128BValues)
%This function takes an array of code 128B values that encode for
%particular characters and returns a checksum value.
%Input: code128BValues = an array of code 128B values.
%Output: checksumValue = the checksum value for the inputted values.
%Author: Nitish Lobo

%The loop number also describes the element of the array inputted and also
%the element of the array that the weighted no. is going to be stored in.
%Calculating a set of weighted values.
for loopNumber = 1:(length(code128BValues))
    weightSequence(loopNumber) = (code128BValues(loopNumber))*(loopNumber);
end

%Finding checksum value. Using rem command to find remainder of division of
%the total sum (add 104) of the weighted values with the start code A value
%(103).
totalWeight = sum(weightSequence) + 104;
checksumValue = rem(totalWeight, 103);
return