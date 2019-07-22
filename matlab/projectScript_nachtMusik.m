close all
clear all
clc
%% assumes that working directory is SP_MusicMatrixProfile\matlab

nachtMusikFilename = '..\audioFiles\Advent_Chamber_Orchestra_-_04_-_Mozart_-_Eine_Kleine_Nachtmusik_allegro.mp3';


%%

[a,f] = audioread(nachtMusikFilename);

% two columns of a are left and right channels. For simplicity, work only
% with left channel a(:,1);

downSample = 100;
a_down = resample(a(:,1), downSample, f); % downsample from file rate to 10Hz
segLen = downSample*20; % 20 second segments


%%

[matrixProfile, profileIndex] = interactiveMatrixProfileVer3_website(a_down, segLen);

save('.\NachtMusik_SegLen20.mat', 'matrixProfile', 'profileIndex');

%%

time = (0:length(a_down)-segLen)/downSample;
padding = zeros(length(time),1);
timeDur = duration(padding, padding, time');

profileInd_dur = duration(padding, padding, (profileIndex/downSample));


figure; subplot(2,1,1)
plot(timeDur, matrixProfile);
grid on; set(gca, 'FontWeight', 'Bold', 'FontSize', 12); hold on;
title({'Matrix Profile of Eine Kleine Nachtmusik'; 'Segment Length: 20s'});
% approximate start of development
plot([duration(0,3,7) duration(0,3,7)], [57 60], 'r'); 
% approximate start of recapitulation
plot([duration(0,3,50) duration(0,3,50)], [57 60], 'r'); 
% approximate start of coda
plot([duration(0,5,25) duration(0,5,25)], [57 60], 'r'); 

subplot(2,1,2);

plot(timeDur, profileInd_dur); hold on;
grid on; set(gca, 'FontWeight', 'Bold', 'FontSize', 12); hold on;
xlabel('Time'); title('Time of Most Similar Segment');

% approximate start of development
plot([duration(0,3,7) duration(0,3,7)], [duration(0,0,0) duration(0,6,0)], 'r'); 
% approximate start of recapitulation
plot([duration(0,3,50) duration(0,3,50)], [duration(0,0,0) duration(0,6,0)], 'r'); 
% approximate start of coda
plot([duration(0,5,25) duration(0,5,25)], [duration(0,0,0) duration(0,6,0)], 'r'); 
%%



