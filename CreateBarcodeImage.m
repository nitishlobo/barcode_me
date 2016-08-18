function [full2DBarCode] = CreateBarcodeImage(barcodePattern)
%This function takes a barcode pattern (string of 1's and 0's) and
%returns a 2D array of numbers representing a greyscale image.
%Input: barcodePattern =  barcode pattern (string of 1's and 0's) that
%encodes the phrase with quiet zones, start, checksum and stop character.
%Output: full2DBarcode = 2D array of numbers representing a greyscale
%image of the barcode inputted.
%Author: Nitish Lobo

%Finding length of the barcode string inputted.
lengthOfPattern = length(barcodePattern);

%Variable loopNumber also describes the element of the barcode string to
%be accessed and the element of the firstRowOfImage variable.
%firstRowOfImage variable is the first row of the 2D array containing
%the grey scale value.
for loopNumber = 1:lengthOfPattern
    if (strcmp(barcodePattern(loopNumber), '1'));
        %The value of the greyscale is opposite to the string value
        %(because pixel value intensity for white is 1 and 0 for black).
        firstRowOfImage(loopNumber) = 0;
    else
        firstRowOfImage(loopNumber) = 1;
    end
end

%Replicating firstRowOfImage to build a 2D array of greyscale values with
%a height of 60 pixels. Variable row describes the row of the image.
for row = 1:60
    full2DBarCode(row,:) = firstRowOfImage(1, :);
end
return