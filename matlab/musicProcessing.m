function [ matrixProfile, timeDur, profileInd_dur ] = musicProcessing( pieceName, a_down, downSample, segLen)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[matrixProfile, profileIndex] = interactiveMatrixProfileVer3_website(a_down, segLen);

save(['.\' pieceName '_SegLen20.mat'], 'matrixProfile', 'profileIndex');

%%

time = (0:length(a_down)-segLen)/downSample;
padding = zeros(length(time),1);
timeDur = duration(padding, padding, time');

profileInd_dur = duration(padding, padding, (profileIndex/downSample));

end

