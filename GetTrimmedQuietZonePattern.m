function [trimmedBarcode] = GetTrimmedQuietZonePattern(barcodePattern)
%Takes a barcode pattern and returns the same barcode pattern but without
%any quiet zones.
%Input: barcodePattern = barcode pattern (in the form of a string of 1's
%                        and 0's) with or without the quiet zones.
%Output: trimmedBarcode = same barcode pattern as the input but without
%                         the quiet zones.
%Author: Nitish Lobo

%Finding length of the barcode string inputted.
barcodeLength = length(barcodePattern);

%If inputted barcode doesn't have any quiet zones, the output should be the
%same. This is purposely done before checking the presence of quiet zones.
trimmedBarcode = barcodePattern;

%Checking whether there is a quiet zone present at the start of barcode.
if strcmp(barcodePattern(1), '0');
    
    %Finding out the length of the Quiet zone at the Start of the barcode.
    startQuietLength = 1;
    while strcmp(trimmedBarcode(startQuietLength), '0');
        startQuietLength = startQuietLength + 1;
    end
    
    %Creating a barcode without the start quiet zone. Trimmed barcode is
    %shorter in length.
    trimmedBarcode = barcodePattern(startQuietLength:barcodeLength);
    barcodeLength = barcodeLength - startQuietLength + 1;
end

%Checking whether there is a quiet zone present at the end of the barcode.
if strcmp(trimmedBarcode(barcodeLength), '0');
    
    %Finding out the length of the Quiet zone at the End of the barcode.
    endQuietLength = 0;
    while strcmp(trimmedBarcode(barcodeLength - endQuietLength), '0');
        endQuietLength = endQuietLength + 1;
    end
    
    %Creating a barcode without the end quiet zone.
    trimmedBarcode = trimmedBarcode(1:(barcodeLength-endQuietLength));
end
return