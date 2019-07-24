close all
clear all
clc
%% assumes that working directory is SP_MusicMatrixProfile\matlab

symphonyFilename = '..\audioFiles\IMSLP298641-PMLP01586-LvBeethoven_Symphony_No.5_mvt1.ogg';


%%

[a,f] = audioread(symphonyFilename);

% two columns of a are left and right channels. For simplicity, work only
% with left channel a(:,1);

downSample = 100;
a_down = resample(a(:,1), downSample, f); % downsample from file rate to 10Hz
segLen = downSample*20; % 20 second segments


%%

[matrixProfile, profileIndex] = interactiveMatrixProfileVer3_website(a_down, segLen);

save('.\Beethoven_SegLen20.mat', 'matrixProfile', 'profileIndex');

%%

time = (0:length(a_down)-segLen)/downSample;
padding = zeros(length(time),1);
timeDur = duration(padding, padding, time');

profileInd_dur = duration(padding, padding, (profileIndex/downSample));

%%
close all

figure; subplot(2,1,1)
plot(timeDur, matrixProfile);
grid on; set(gca, 'FontWeight', 'Bold', 'FontSize', 12); hold on;
title({'Matrix Profile of Beethoven 5th Symphony'; 'Segment Length: 20s'});
% approximate start of development
plot([duration(0,2,39) duration(0,2,39)], [56 60], 'r'); 
% approximate start of recapitulation
plot([duration(0,3,57) duration(0,3,57)], [56 60], 'r'); 
% approximate start of coda
plot([duration(0,5,30) duration(0,5,30)], [56 60], 'r'); 

subplot(2,1,2);

plot(timeDur, profileInd_dur); hold on;
grid on; set(gca, 'FontWeight', 'Bold', 'FontSize', 12); hold on;
xlabel('Time'); title('Time of Most Similar Segment');

% approximate start of development
plot([duration(0,2,39) duration(0,2,39)], [duration(0,0,0) duration(0,8,0)], 'r'); 
% approximate start of recapitulation
plot([duration(0,3,57) duration(0,3,57)], [duration(0,0,0) duration(0,8,0)], 'r'); 
% approximate start of coda
plot([duration(0,5,30) duration(0,5,30)], [duration(0,0,0) duration(0,8,0)], 'r'); 
%%
segLen_5 = downSample*5; % 5 second segments

 [ matrixProfile, timeDur, profileInd_dur ] = musicProcessing( 'Beethoven 5th Symphony', a_down, downSample, segLen_5);
 
 %%
 close all

figure; subplot(2,1,1)
plot(timeDur, matrixProfile);
grid on; set(gca, 'FontWeight', 'Bold', 'FontSize', 12); hold on;
title({'Matrix Profile of Beethoven 5th Symphony'; 'Segment Length: 5s'});
% approximate start of development
plot([duration(0,2,39) duration(0,2,39)], [56 60], 'r'); 
% approximate start of recapitulation
plot([duration(0,3,57) duration(0,3,57)], [56 60], 'r'); 
% approximate start of coda
plot([duration(0,5,30) duration(0,5,30)], [56 60], 'r'); 

subplot(2,1,2);

plot(timeDur, profileInd_dur); hold on;
grid on; set(gca, 'FontWeight', 'Bold', 'FontSize', 12); hold on;
xlabel('Time'); title('Time of Most Similar Segment');

% approximate start of development
plot([duration(0,2,39) duration(0,2,39)], [duration(0,0,0) duration(0,8,0)], 'r'); 
% approximate start of recapitulation
plot([duration(0,3,57) duration(0,3,57)], [duration(0,0,0) duration(0,8,0)], 'r'); 
% approximate start of coda
plot([duration(0,5,30) duration(0,5,30)], [duration(0,0,0) duration(0,8,0)], 'r'); 

