close all
clear all

%% assumes that working directory is SP_MusicMatrixProfile\matlab

rondoFilename = '..\audioFiles\IMSLP111573-PMLP01846-Música_Clásica_-_Rondo_Alla_Turca._Wolfgang_Amadeus_Mozart.mp3';


%%

% Mozart Piano Sonata No. 11 (Movt 3)
% From https://imslp.org/wiki/Piano_Sonata_No.11_in_A_major,_K.331/300i_(Mozart,_Wolfgang_Amadeus)
[a,f] = audioread(rondoFilename);

% two columns of a are left and right channels. For simplicity, work only
% with left channel a(:,1);


%%
% shorten data for intial analysis
startInd = find(a(:,1),1); % find first non-zero index

downSample = 10;

startDat = a(startInd:downSample:floor(length(a)/4),1);


segLen = 5*f/downSample; % 5 seconds

time = (startInd:downSample:(10+floor(length(a)/4))-segLen*downSample)/(f);

%%
[matrixProfile, profileIndex, motifIdxs, discordIdx] = interactiveMatrixProfileVer3_website(startDat, segLen);

%%
close all
figure;
plot(time, matrixProfile); grid on;
title({'Matrix Profile'; 'Mozart Piano Sonata No. 11 in A Maj'; '(First 50 seconds)'});

figure; plot(time, time(profileIndex))
title({'Profile Index'; 'Mozart Piano Sonata No. 11 in A Maj'; '(First 50 seconds)'}); grid on;
xlabel('Time of Section'); ylabel('Time of Most Similar Section')
