clf
clc
clear

% Constants
width = 320;
height = 240;
fps = 5;
bg_color = [0 0 0];
total_frames = 138;
load('head.mat')
load('body.mat')
load('arms.mat')
load('legR.mat')
load('legL.mat')
load('tail.mat')

draw_bg = false;

% if draw_frame
%     i = 26;
%     disp(["Frame: ", i]);
%     frame_str = pad(string(i), 3, 'left', '0');
%     hold on
%     img = imread(strcat('img_seq/ezgif-frame-',frame_str, '.jpg'));
%     image('CData',img,'XData',[0 320],'YData',[240 0]);
%     drawPanther(i, H, B, A, LR, T);
% else

if true
    [y, Fs] = audioread('panther.mp3');
    sound(y, Fs, 16);
end

for i = 1:total_frames
    clf
    disp(["Frame: ", i]);
    frame_str = pad(string(i), 3, 'left', '0');
    hold on
    if draw_bg
%         img = imread(strcat('img_seq/ezgif-frame-',frame_str, '.jpg'));
%         image('CData',img,'XData',[0 320],'YData',[240 0]);
    else
        img = imread(strcat('img_seq/ezgif-frame-009.jpg'));
        image('CData',img,'XData',[0 320],'YData',[240 0]);
    end
    drawPanther(i, H, B, A, LR, LL, T);
    hold off;
    pause(1/fps);
end
% end
clear sound;
% Functions
function drawPanther(frame, H, B, A, LR, LL, T)
    drawBodyPart(frame, H);
    drawBodyPart(frame, B);
    drawBodyPart(frame, A);
    drawLeg(frame, LR);
    drawLeg(frame, LL);
    drawTail(frame, T);
end

function drawBodyPart(frame, P)
    zeroIndex = find(P(frame*2-1, :) == 0);
    disp(P(frame*2-1:frame*2, :));
    fill(P(frame*2-1, 1:zeroIndex-1), P(frame*2, 1:zeroIndex-1), [0.7725,.4666,0.8078], 'LineStyle','none');
    axis([0 320 0 240]);
end
function drawLeg(frame, P)
    plot(P(frame*2-1, 1:3), P(frame*2, 1:3), 'LineWidth',8, 'Color', [0.7725,.4666,0.8078])
    plot(P(frame*2-1, 3:4), P(frame*2, 3:4), 'LineWidth',12, 'Color', [0.7725,.4666,0.8078])
    axis([0 320 0 240]);
end
function drawTail(frame, P)
    plot(P(frame*2-1, 1:3), P(frame*2, 1:3), 'LineWidth',4, 'Color', [0.7725,.4666,0.8078])
    axis([0 320 0 240]);
end
function res = translate(mat, x, y)
    T = eye(3);
    T(1, 3) = x;
    T(2, 3) = y;
    temp = T*[mat;ones(1, size(mat,2))];
    res = temp(1:2, :);
end
