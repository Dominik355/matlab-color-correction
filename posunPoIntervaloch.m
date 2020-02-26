function posunuty = posunPoIntervaloch(Img, masks, chart, colors)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k= size(colors);

for i = 1:k(1)
    for j = 1:k(2)
        HsvColors.(colors{i,j}) = strednaHodnotaVyberu(Img,masks.(colors{i,j}).mask);
    end
end

for q = 1:k(1)
    for w = 1:k(2)
        rozdielHSV.(colors{q,w})(1) = chart.(colors{q,w}).hsv(1) - HsvColors.(colors{q,w})(1);
        rozdielHSV.(colors{q,w})(2) = chart.(colors{q,w}).hsv(2) - HsvColors.(colors{q,w})(2);
        rozdielHSV.(colors{q,w})(3) = chart.(colors{q,w}).hsv(3) - HsvColors.(colors{q,w})(3);                
    end
end

        if rozdielHSV.red(1) > 0.7
            rozdielHSV.red(1) = 1-rozdielHSV.red(1);
        elseif rozdielHSV.red(1) < -0.7
            rozdielHSV.red(1) = 1+rozdielHSV.red(1);
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Hlayer = Img(:,:,1);
Slayer = Img(:,:,2);
Vlayer = Img(:,:,3);

s = size(Img);
gray = 0;
black = 0;

for i = 1:s(1)
    for j = 1:s(2)
        u = 2;
        if Vlayer(i,j) <= 0.2
            black = 1;
            u = 3;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.black(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.black(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.black(3))/u);
        elseif Slayer(i,j) < 0.15 && Vlayer(i,j) <0.86
            gray = 1;
            u = 4;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.white(1)+rozdielHSV.black(1))/5);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.white(2)+rozdielHSV.black(2))/5);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.white(3)+rozdielHSV.black(3))/5);
            
        else u = 2;
            
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if Vlayer(i,j) >= 0.86 && Slayer(i,j) <  0.051
            Hlayer(i,j) = Hlayer(i,j) +(rozdielHSV.white(1));
            Slayer(i,j) = Slayer(i,j) +(rozdielHSV.white(2));
            Vlayer(i,j) = Vlayer(i,j) +(rozdielHSV.white(3));
        
        elseif Hlayer(i,j) > 0 && Hlayer(i,j) < 0.1667
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.red(1)+rozdielHSV.yellow(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.red(2)+rozdielHSV.yellow(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.red(3)+rozdielHSV.yellow(3))/u);
          
        elseif Hlayer(i,j) > 0.1667 && Hlayer(i,j) < 0.3333
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.yellow(1)+rozdielHSV.green(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.yellow(2)+rozdielHSV.green(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.yellow(3)+rozdielHSV.green(3))/u);
            
        elseif Hlayer(i,j) > 0.3333 && Hlayer(i,j) < 0.5
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.green(1)+rozdielHSV.aqua(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.green(2)+rozdielHSV.aqua(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.green(3)+rozdielHSV.aqua(3))/u);
            
        elseif Hlayer(i,j) > 0.5 && Hlayer(i,j) < 0.6667
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.aqua(1)+rozdielHSV.blue(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.aqua(2)+rozdielHSV.blue(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.aqua(3)+rozdielHSV.blue(3))/u);
            
        elseif Hlayer(i,j) > 0.6667 && Hlayer(i,j) < 0.8333
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.blue(1)+rozdielHSV.pink(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.blue(2)+rozdielHSV.pink(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.blue(3)+rozdielHSV.pink(3))/u);
            
        elseif Hlayer(i,j) > 0.8333 && Hlayer(i,j) <= 1
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.pink(1)+rozdielHSV.red(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.pink(2)+rozdielHSV.red(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.pink(3)+rozdielHSV.red(3))/u);
            
        elseif Hlayer(i,j) == 0 || Hlayer(i,j) == 1
            if black = 1
                u = 2;
            elseif gray = 1
                u = 3;
            else u = 1;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.red(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.red(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.red(3))/u);
        elseif Hlayer(i,j) == 0.1667
            if black = 1
                u = 2;
            elseif gray = 1
                u = 3;
            else u = 1;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.yellow(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.yellow(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.yellow(3))/u);
        elseif Hlayer(i,j) == 0.3333
            if black = 1
                u = 2;
            elseif gray = 1
                u = 3;
            else u = 1;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.green(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.green(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.green(3))/u);
        elseif Hlayer(i,j) == 0.5
            if black = 1
                u = 2;
            elseif gray = 1
                u = 3;
            else u = 1;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.aqua(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.aqua(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.aqua(3))/u);
        elseif Hlayer(i,j) == 0.6667
            if black = 1
                u = 2;
            elseif gray = 1
                u = 3;
            else u = 1;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.blue(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.blue(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.blue(3))/u);
        elseif Hlayer(i,j) == 0.8333
            if black = 1
                u = 2;
            elseif gray = 1
                u = 3;
            else u = 1;
            Hlayer(i,j) = Hlayer(i,j) +((rozdielHSV.pink(1))/u);
            Slayer(i,j) = Slayer(i,j) +((rozdielHSV.pink(2))/u);
            Vlayer(i,j) = Vlayer(i,j) +((rozdielHSV.pink(3))/u);

        end
        
        if Hlayer(i, j)>1
            Hlayer(i, j) = Hlayer(i, j)-1;
        elseif Hlayer(i, j)<0
            Hlayer(i, j) = 1+Hlayer(i, j);
        end
        
        gray = 0;
        black = 0;
    end
end

Slayer(Slayer>1)=1;
Vlayer(Vlayer>1)=1;
Slayer(Slayer<0)=0;
Vlayer(Vlayer<0)=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

posunuty(:,:,1) = Hlayer;
posunuty(:,:,2) = Slayer;
posunuty(:,:,3) = Vlayer;

end

