function RGB = strednaHodnotaVyberu(I,mask)
RedLayer = I(:,:,1);
GreenLayer = I(:,:,2);
BlueLayer = I(:,:,3);

assert(size(RedLayer,1)==size(mask,1),'maska ma inu velkost ako obrazok')
assert(size(RedLayer,2)==size(mask,2),'maska ma inu velkost ako obrazok')

R = mean(RedLayer(mask));
G = mean(GreenLayer(mask));
B = mean(BlueLayer(mask));

RGB = [R G B];
