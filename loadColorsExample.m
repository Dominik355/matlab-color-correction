%% Example Title

%% Section 1 Title

colors{1,1} = 'red';
colors{1,2} = 'yellow';
colors{1,3} = 'green';
colors{1,4} = 'black';
colors{2,1} = 'aqua';
colors{2,2} = 'blue';
colors{2,3} = 'pink';
colors{2,4} = 'white';

save colors.mat colors;
%% Section 2 Title


chart.red.rgb = [221 28 28];
chart.yellow.rgb = [229 229 34];
chart.green.rgb = [43 216 43];
chart.black.rgb = [16  33 33];
chart.aqua.rgb = [43 216 216];
chart.blue.rgb = [43 43 216];
chart.pink.rgb = [203 40 204];
chart.white.rgb = [227 232 232];

chart.red.hsv = [0 0.87 0.87];
chart.yellow.hsv = [0.1667 0.85 0.9];
chart.green.hsv = [0.3333 0.8 0.85];
chart.black.hsv = [0.5 0.5 0.13];
chart.aqua.hsv = [0.5 0.8 0.85];
chart.blue.hsv = [0.6667 0.8 0.85];
chart.pink.hsv = [0.8333 0.8 0.8];
chart.white.hsv = [0.5 0.02 0.91];

save chart.mat chart;