function masks = makeChartMask(inImg,colors,dim)

% ************************************************************************
%numel()= vrati pocet prvkov v matici(napr. matica 3x4=vrati 12)
%assert(cond)=throws an error if "cond" is false

s = size(colors);
assert(numel(size(inImg))==3,'The input image has to be a color image.')


%velkost selectovacich stvorcov, ak nebola udana v parametroch funkcie
%nargin - pocet argumentov, ktore boli funkci dodane
if nargin<3
    dim = 0.03*min(size(inImg,1),size(inImg,2));
end

space = 0.4*dim;
shiftVal = dim + space;
x_box = [1 2 2 1];
y_box = [1 1 2 2];
tempMask =cell(s(1),s(2));

figure('Name','Selects');
imshow(inImg)
for col = 1:s(2)
    for  row = 1:s(1)
        curColor = colors{row,col};
        pts(:,1) = shiftVal*col + dim*x_box;
        pts(:,2) = shiftVal*(row) + dim*y_box;
        masks.(curColor).pts = pts;
        tempMask{row,col} = impoly(gca,masks.(curColor).pts) ;
    end
end

title('Place squares over the reference colors, then double click first square','fontsize',20);

% wait for the user to double click to confirm location
curColor = colors{1,1};
curMask = tempMask{1,1};
position = wait(curMask);
masks.(curColor).mask = createMask(curMask);
delete(curMask)

for row = 1:s(1)
    for col = 1:s(2)
        curColor = colors{row,col};
        if ~strcmp(curColor,colors{1,1})
            curMask = tempMask{row,col};
            masks.(curColor).mask = createMask(curMask);
            delete(curMask)
        end
    end
end
close
end







