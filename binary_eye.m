%% Referred From B.P. Lathi
clear;clf;
[audioData, fm] = audioread('C:\Users\aarya\OneDrive\Desktop\_\SEM 4\PCS\2022006_Aarya_Gupta_PCS_Ass-2\PCS_Ass-2_Recording.m4a');

data = audioData(57000:168000, 1);      % Audio Signal
Tau= 2048;                           % Define the symbol period
dataup = upsample(data, Tau);     % Generate impulse train
%yrz = conv (dataup, prz (Tau));   % Return to zero polar signal
%yrz = yrz(1:end-Tau+1);
ynrz = conv (dataup(:, 1), pnrz (Tau));   % Non-return to zero polar (NRZ)
ynrz = ynrz(1:end-Tau+1);
%ysine = conv (dataup, psine (Tau)); % half sinusoid polar
%ysine = ysine (1:end-Tau+1);
%Td=4;                               % truncating raised cosine to 4 periods
%yrcos = conv (dataup,prcos (0.5, Td, Tau)); % rolloff factor = 0.5
%yrcos = yrcos (2*Td*Tau: end-2*Td*Tau+1); % generating RC pulse train

% Plot the line code depicting the first 20 pulses
figure;
plot(ynrz(1:20 * Tau), 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Line Code with Polar NRZ Encoding (First 20 Pulses)');

%eyel=eyediagram (yrz,2*Tau, Tau, Tau/2);title('RZ eye-diagram');
eye2=eyediagram (ynrz, 2*Tau, Tau, Tau/2); title('NRZ eye-diagram');
%eye3=eyediagram (ysine, 2*Tau, Tau, Tau/2); title('Half-sine eye-diagram');
%eye4=eyediagram (yrcos, 2*Tau, Tau); title('Raised-cosine eye-diagram');
%eye2=eyediagram (audioData, 64);  title('Trial 1');




