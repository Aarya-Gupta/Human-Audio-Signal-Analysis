%% Problem 2 
% Note : Generation of the eye diagram may take time depending upon the
% configuration of the system.
%% Line Code
clear;clf;
[audioData, fm] = audioread('sample_audio.m4a');
 
% data = audioData(57000:168000, 1);      % Audio Signal
Tau= 2048;                           % Define the symbol period
% dataup = upsample(data, Tau);     % Generate impulse train
% ynrz = conv (dataup(:, 1), pnrz (Tau));   % Non-return to zero polar (NRZ)
% ynrz = ynrz(1:end-Tau+1);

% % Plot the line code depicting the first 20 pulses
% % plot(ynrz(1:20 * Tau), 'LineWidth', 2);
% plot(ynrz(1:20), 'LineWidth', 2);
X = zeros(size(audioData));
for i=57000:57200
    % Plotting for first 200 samples (after clearing noise by collecting
    % only relevant sample space)
    
    if (audioData(i, 1) >= 0)
        % disp("Big");
        X(i, 1) = 1;
    else 
        % disp("Small");
        X(i, 1) = 0;
    end 
end
figure;
Y = X(:, 1)';
polar_nrz(Y(1, 57000:57200));
xlabel('Frequency');
ylabel('Amplitude');
title('Line Code with Polar NRZ Encoding (First 200 Pulses)');

%%  EYE Diagram

% Testing Data
[audioData, fm] = audioread('sample_audio.m4a');
data = audioData(57000:168000, 1);      % Audio Signal
% Took only those relevant portions of data removing noise.
modSig = pskmod(round(data),4,pi/4);
sps=4;
txfilter = comm.RaisedCosineTransmitFilter('OutputSamplesPerSymbol',sps);
txSig = txfilter(modSig);
% Using the inbuilt function of eyediagram to make the eyediagram.
eyediagram(txSig,2*sps);
