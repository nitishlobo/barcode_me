% This script prompts the user to enter a phrase
% and then generates a code128B barcode that encodes that phrase

phrase = input('please enter a phrase to encode: ','s');

% Create a 1D string of 1s and 0s representing the barcode pattern
p = CreateBarcodePattern(phrase);

% Convert the 1D pattern string into a 2D image of the barcode
B = CreateBarcodeImage(p);

% Write the barcode to a png file
imwrite(B,'barcode.png');

% To display a greyscale image you would typically use the imshow command:
% figure(1)
% imshow(B)

% Note that imshow is part of the Matlab image processing toolbox so you
% can only use it if your version of Matlab includes the image processing
% toolbox.
% If you don't have the image processing toolbox you can still display a
% greyscale image using the image command, but it is a little more complicated
% as you need to set up an appropriate colour map.  I have used the more
% complicated approach so that everyone can view the image, regardless
% of whether or not they have the image processing toolbox.

% set up a colour map for displaying our binary image (i.e. a greyscale image 
% which only contains the colours black and white)
% the first row specifies black, the second row specifies white
figure(2)
map = [0 0 0; 1 1 1];
colormap(map)

% Use the image command to display our image (we offset pixel values by 1 
% so that the image contains 1s and 2s)
% The specified colormap will then results in 1s being displayed as black
% (row 1 of the colour map encodes black) and 2s being displayed as white
% (row 2 of the colour map encodes white).
image(B+1)
axis image
axis off




