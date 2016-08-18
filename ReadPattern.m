function [phrase, checksumMatched] = ReadPattern(barcodePattern)
%This function takes a barcode string of 1's and 0's that is coded in
%code128B and then returns a phrase from that barcode and a boolean value
%to state whether the checksum from the phrase matched the barcode
%checksum.
%Input: barcodePattern = 1D string of 1's and 0's that represents the
%                        entire barcode.
%Outputs: phrase = message that the barcode encoded.
%         checksumMatched = boolean value. Is true (1) if the checksum
%         read from barcode matched the checksum calculated
%         from the phrase. Returns false (0) otherwise.
%Author: Nitish Lobo

%Trimming the quiet zones from the barcode pattern. Need to trim quiet
%zones because their lengths can vary and the code that follows relies on
%them not varying.
[trimmedBarcode] = GetTrimmedQuietZonePattern(barcodePattern);

%element variable describes element accessed in the trimmed barcode. While
%loop keeps count of how many pixels wide the first black line of the
%start character is. This is used to find the scale factor of the trimmed
%barcode in comparison to the same barcode with its narrowest bar as 1
%pixel. Divide by 2 because in a barcode with 1 pixel as its narrowest bar,
%the first black line of the start character is 2 pixels wide.
element = 1;
while strcmp(trimmedBarcode(element), '1')
    element = element + 1;
end
scaleFactor = (element - 1)/2;

%Scaling down entire barcode so that narrowest bar will be 1 pixel and
%storing it in barcode1Pixel. If this is already the case then we want the
%barcode1Pixel to equal to the output of the previous function.
if (scaleFactor>1)
    [barcode1Pixel] = GetBarcodeOf1PixelSize(trimmedBarcode, scaleFactor);
else
    barcode1Pixel = trimmedBarcode;
end

%Finding length of the barcode string.
barcode1PixelLength = length(barcode1Pixel);

%The start character has a total of eleven 1's and 0's in the string.
%Similarly, checksum has 11 and stop has 13. Total is 11+11+13 = 35.
%Exclude these and get string with the phrase and checksum. Divide by 11
%to find out the no. of char in the phrase (ie: numOfPhraseChar).
numOfPhraseChar = (barcode1PixelLength - 35)/11;
for loopNumber = 1:numOfPhraseChar
    
    %Start of the phrase character is found by adding the length of the
    %weighted sum of the character to 1 (to find the first string digit of
    %that char). End of the phrase character is 10 longer than the start.
    %codePattern records the string of 1's and 0's for a single char.
    startOfPhraseChar = (loopNumber)*11 +1;
    codePattern = barcode1Pixel(startOfPhraseChar:(startOfPhraseChar+10));
    
    %Getting the char and concatenating it with the previous char.
    %phrase character is also used to get values for checksum stored in
    %array called code128BValues.
    [phrase(loopNumber)] = GetCharForPattern(codePattern);
    [code128BValues(loopNumber)] = GetValueForChar(phrase(loopNumber));
    
end

%Getting checksum string. startOfChksumStr is the element in the barcode
%pattern of where the checksum begins (found by adding 10 (end of the
%phrase string is 10 digits from the start) to 1 (checksum starts after one
%element from the end of the phrase string).
startOfChksumStr = startOfPhraseChar + 10 + 1;
checksumBarcodeStr = barcode1Pixel(startOfChksumStr:(startOfChksumStr+10));

%Calc at end of variables indicate that the checksum is not read directly
%from barcode (ie: is calculated). Getting checksum value and then pattern.
[checksumValueCalc] = Code128BChecksum(code128BValues);
[checksumPatternCalc] = GetPatternForValue(checksumValueCalc);

%Comparing calculated checksum with barcode checksum.
checksumMatched = strcmp(checksumBarcodeStr, checksumPatternCalc);
return