clear all; close all; clc;
load colors.mat;
load chart.mat;
k = size(colors);
imagePATH = inputdlg('Full path to image :', 'Image Path Input');
originalImage = imread(string(imagePATH));

zadaneFarby = zadanieFarieb();

masks = makeChartMask(originalImage,colors);
maskyZadanychFarieb = makeChartMask(originalImage,zadaneFarby);

HsvImage = rgb2hsv(originalImage);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=1;
for i = 1:k(1)
    for j = 1:k(2)
        rgbColorsBefore.(colors{i,j}) = strednaHodnotaVyberu(originalImage,masks.(colors{i,j}).mask);
    end
end
for q = 1:k(1)
    for w = 1:k(2)
        differenceBEFORE(n, 1) = round(chart.(colors{q,w}).rgb(1) - rgbColorsBefore.(colors{q,w})(1));
        differenceBEFORE(n, 2) = round(chart.(colors{q,w}).rgb(2) - rgbColorsBefore.(colors{q,w})(2));
        differenceBEFORE(n, 3) = round(chart.(colors{q,w}).rgb(3) - rgbColorsBefore.(colors{q,w})(3));                
        n = n+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%valueBEFORE - hodnota nasich farieb pred upravou
n=1;
e = size(zadaneFarby);
for i = 1:e(1)
    for j = 1:e(2)
        abcd.(zadaneFarby{i,j}) = strednaHodnotaVyberu(originalImage,maskyZadanychFarieb.(zadaneFarby{i,j}).mask);
    end
end
for q = 1:e(1)
    for w = 1:e(2)
        valueBEFORE(n, 1) = round(abcd.(zadaneFarby{q,w})(1));
        valueBEFORE(n, 2) = round(abcd.(zadaneFarby{q,w})(2));
        valueBEFORE(n, 3) = round(abcd.(zadaneFarby{q,w})(3));                
        n = n+1;
    end
end
clear i, j, q, w, n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%c
HsvImagePosunuty = posunPoIntervaloch(HsvImage, masks, chart, colors);
%hsv2rgb - prekonvertuje hsv obrazok do double hodnot, nie do uint8 !!!
AfterImage = hsv2rgb(HsvImagePosunuty);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%differenceAFTER - rozdiely referencnych farieb po uprave
for i = 1:k(1)
    for j = 1:k(2)
      d  rgbColorsAfter.(colors{i,j}) = 255*strednaHodnotaVyberu(AfterImage,masks.(colors{i,j}).mask);
    end
end

n=1;
for q = 1:k(1)
    for w = 1:k(2)
        differenceAFTER(n, 1) = round(chart.(colors{q,w}).rgb(1) - rgbColorsAfter.(colors{q,w})(1));
        differenceAFTER(n, 2) = round(chart.(colors{q,w}).rgb(2) - rgbColorsAfter.(colors{q,w})(2));
        differenceAFTER(n, 3) = round(chart.(colors{q,w}).rgb(3) - rgbColorsAfter.(colors{q,w})(3));                
        n = n+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%valueAFTER - hodnota nasich farieb po uprave
for i = 1:e(1)
    for j = 1:e(2)
        asdf.(zadaneFarby{i,j}) = 255*strednaHodnotaVyberu(AfterImage,maskyZadanychFarieb.(zadaneFarby{i,j}).mask);
    end
end
n=1;
for q = 1:e(1)
    for w = 1:e(2)
        valueAFTER(n, 1) = round(asdf.(zadaneFarby{q,w})(1));
        valueAFTER(n, 2) = round(asdf.(zadaneFarby{q,w})(2));
        valueAFTER(n, 3) = round(asdf.(zadaneFarby{q,w})(3));                
        n = n+1;
    end
end
subplot(1,2,1)
imshow(originalImage);
subplot(1,2,2)
imshow(AfterImage);

imwrite(AfterImage, 'afterImage.png');

a = numel(zadaneFarby);
zadaneFarby = string(zadaneFarby);
for i = 1:a
    string = sprintf('%s = R: %d, G: %d, B: %d',zadaneFarby(i),valueAFTER(i, 1),valueAFTER(i, 2),valueAFTER(i, 3));
    vysledky(i) = {string};
end
vysledky(i+1) = {'Image was saved as "afterImage"'};

f = msgbox(vysledky);
