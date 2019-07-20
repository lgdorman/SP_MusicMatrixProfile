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

downSample = 100;



%%
% shorten data for intial analysis
startInd = find(a(:,1),1); % find first non-zero index


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

%%
% look at entire audio with very large seg length

downA = a(1:downSample:end,1);
longSegLen = floor(length(downA)/20);

[matrixProfile, profileIndex, motifIdxs, discordIdx] = interactiveMatrixProfileVer3_website(downA, longSegLen);

figure; plot(profileIndex)

%%
a_10Hz = resample(a(:,1), 10, f); % downsample from file rate to 10Hz
segLen_10Hz = 200; % 20 second segments

[matrixProfile_10Hz, profileIndex_10Hz, motifIdxs_10Hz, discordIdx_10Hz] = interactiveMatrixProfileVer3_website(a_10Hz, segLen_10Hz);

save('.\MozartSonata_10Hz_SegLen200.mat', 'matrixProfile_10Hz', 'profileIndex_10Hz');

%%

time = (0:length(a_10Hz)-segLen_10Hz)/10;
figure; plot(time, profileIndex_10Hz/10);
xlim([time(1) time(end)])


time = (0:length(a_10Hz)-segLen_10Hz)/10;
figure; plot(time, matrixProfile_10Hz);
xlim([time(1) time(end)])

%%



