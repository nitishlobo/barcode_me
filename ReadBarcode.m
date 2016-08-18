% This script opens a file containing a code128B barcode image and then
% reads the encoded message contained in the barcode.

% Read in an image from a user specified file, into a uint8 array, A
% The array will contain values between 0 and 255
filename = input('Please enter the filename of an image file containing a code128B barcode: ','s');
A = imread(filename);
[rows,cols,colours]=size(A);

% Translate image array into sequence of 1s and 0s (1= black, 0=white)
% Note when reading an RGB colour image each pixel is encoded with three numbers
% (e.g. white has R=255 ,G=255,B=255).
% By contrast, if reading in a greyscale image each pixel will be encoded
% using a single intensity value between 0 and 255 (white is 255)

% Choose the middle row to scan
r = round(rows/2);

% We build up the pattern by scanning each pixel in the row, determining if
% the pixel is white or black based on the pixel intensity

barcodePattern = [];
for j=1:cols
    % determine pixel intensity based on image type
    if colours == 1
        % greyscale image, one intensity value
        pixelIntensity = A(r,j);
    else
        % colour image, calculate intensity using R, G, B values
        % pixel intensity is calculated using the formula 0.3r+0.59g+0.11b
        pixelIntensity = 0.3* A(r,j,1) + 0.59 * A(r,j,2) + 0.11 * A(r,j,3);
    end
    if pixelIntensity > 128
        % treat anything in the bright half of the spectrum as white
        barcodePattern = [barcodePattern '0'];
    else
        barcodePattern = [barcodePattern '1'];
    end
end

% Read the pattern
[phrase, checksumMatched] = ReadPattern(barcodePattern);

% display appropriate message based on whether checksum matched or not
if checksumMatched
    disp(['The encoded phrase is: ' phrase]);
else
    disp(['The checksum did not match for the encoded phrase: ' phrase]);
end

