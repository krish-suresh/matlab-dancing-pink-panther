clf
clc

% Constants
width = 320;
height = 240;
fps = 5;
bg_color = [0 0 0];
total_frames = 138;

axis([0 320 0 240]);
A = zeros(total_frames*2, 100);
start_frame = 176/2;
filename = 'arms.mat';
if isfile(filename)
     load(filename);
end

for frame = start_frame:total_frames
    disp(["Frame: ", frame]);
    frame_str = pad(string(frame), 3, 'left', '0');
    img = imread(strcat('img_seq/ezgif-frame-',frame_str, '.jpg'));
    image('CData',img,'XData',[0 320],'YData',[240 0]);
    axis([0 320 0 240]);
    [x, y] = ginputWhite;
    numPoints = size(x,1);
    A(frame*2-1, 1:numPoints) = x';
    A(frame*2, 1:numPoints) = y';
    if mod(frame, 3) == 0
        save(filename,'A');
    end
end
    
% for i = 1:total_frames
%     clf
%     disp(["Frame: ", i]);
%     frame_str = pad(string(i), 3, 'left', '0');
%     hold on
%     img = imread(strcat('img_seq/ezgif-frame-',frame_str, '.jpg'));
%      image('CData',img,'XData',[0 320],'YData',[240 0]);
%     drawPanther(i, P);
%     hold off;
%     pause(1/fps);
% end

% Functions
function drawPanther(frame, P)
    zeroIndex = find(P(frame*2-1, :) == 0);
    disp(P(frame*2-1:frame*2, :));
    fill(P(frame*2-1, 1:zeroIndex-1), P(frame*2, 1:zeroIndex-1), [0.7725,.4666,0.8078], 'LineStyle','none');
    axis([0 320 0 240]);
end


function res = translate(mat, x, y)
    T = eye(3);
    T(1, 3) = x;
    T(2, 3) = y;
    temp = T*[mat;ones(1, size(mat,2))];
    res = temp(1:2, :);
end
