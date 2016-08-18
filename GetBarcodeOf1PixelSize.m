function [barcode1Pixel] = GetBarcodeOf1PixelSize(trimmedBarcode, scaleFactor)
%Takes a barcode pattern which has the narrowest bar width as more than 1
%pixel and returns a scaled down barcode which has it's narrowest bar as
%exactly 1 pixel.
%Inputs: trimmedBarcode = barcode pattern without any quiet zones.
%        scaleFactor = ratio of the width of the first black line in the
%start character in the trimmedbarcode with any barcode that has it's
%narrowest bar as 1 pixel wide.
%Output: barcode1Pixel = barcode pattern with it's narrowest bar being 1
%        pixel and without any quiet zones.
%Author: Nitish Lobo

%Finding length of the barcode string inputted.
trimmedBarcodeLength = length(trimmedBarcode);

%Blank array to store the new barcode going to be developed.
%Variable element describes element of the barcode array inputted.
barcode1Pixel = [];
element = 1;
while element <= trimmedBarcodeLength
    
    %Count1 counts no. of consecutive 1's (count resets to zero after every
    %cycle). While loop continues to count until a 0 is met. break command
    %breaks out of while loop so that an element that does not exist is
    %not accessed.
    count1 = 0;
    while strcmp(trimmedBarcode(element), '1');
        element = element + 1;
        count1 = count1 + 1;
        if element > trimmedBarcodeLength
            break
        end
    end
    
    %Rewrites the consecutive 1's in barcode pattern according to the
    %scale factor so that the narrowest bar is 1 pixel.
    for loopNumber = 1:(count1/scaleFactor)
        barcode1Pixel = [barcode1Pixel, '1'];
    end
    
    
    %Count0 counts no. of consecutive 0's (count resets to zero after every
    %cycle). While loop continues to count until a 0 is met. If statement
    %stops while loop accessing an element that does not exist.
    count0 = 0;
    if element < trimmedBarcodeLength
        while strcmp(trimmedBarcode(element), '0');
            element = element + 1;
            count0 = count0 + 1;
        end
        
        %Rewrites the consecutive 0's in barcode pattern according to the
        %scale factor so that the narrowest bar is 1 pixel.
        for loopNumber = 1:(count0/scaleFactor)
            barcode1Pixel = [barcode1Pixel, '0'];
        end
    end
end