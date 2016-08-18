function [barcodePattern] = CreateBarcodePattern(phrase)
%This function takes a phrase (a string of characters, eg: 'Hello') and
%returns a barcode pattern (string of 1's and 0's) that encodes the
%phrase inputted.
%Input: phrase = message inputted by user (string of characters).
%Output: barcodePattern = barcode pattern (string of 1's and 0's) that
%encodes the phrase with quiet zones, start, checksum and stop character.
%Author: Nitish Lobo

%Finding length of the string inputted.
phraseLength = length(phrase);

%Feeding code 128B patterns for the respective barcode characters.
quietZone = '0000000000';
startChar = '11010010000';
stopChar = '1100011101011';

%barcodePattern at this stage is not the complete barcode pattern.
barcodePattern = [quietZone, startChar];
for loopNumber = 1:phraseLength
    
    %Finding the code128B values and pattern for each character of phrase
    %and then storing the values into array for checksum calculation later.
    %valueFor128B = code128B value for character in the phrase.
    %characterPattern = barcode string that encodes for that character.
    [valueFor128B] = GetValueForChar(phrase(loopNumber));
    [characterPattern] = GetPatternForValue(valueFor128B);
    barcodePattern = [barcodePattern, characterPattern];
    code128BValues(loopNumber) = valueFor128B;
end

%Calculating checksum value, then converting it into a barcode pattern
%(string of 1's and 0's)called checkPattern.
[checksumValue] = Code128BChecksum(code128BValues);
[checkPattern] = GetPatternForValue(checksumValue);

%Attaching checksum, stop and quiet zone patterns to the bar code.
barcodePattern = [barcodePattern, checkPattern, stopChar, quietZone];
return