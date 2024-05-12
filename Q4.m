%% Line Code (from Problem 2)
clear;clf;
[audioData, fm] = audioread('sample_audio.m4a');
X = zeros(size(audioData));
for i=57000:57200
    % Plotting for first 200 samples (after clearing noise by collecting)
    % only relevant sample space)
    if (audioData(i, 1) >= 0)
        X(i, 1) = 1;
    else 
        X(i, 1) = 0;
    end 
end
figure;
Y = X(:, 1)';
polar_nrz(Y(1, 57000:57200));
xlabel('Time');
ylabel('Amplitude');
title('Line Code with Polar NRZ Encoding (First 200 Pulses)');

% Parameters
Fs = 10000;          % Sampling frequency (arbitrary)
T = 1/Fs;           % Sampling period
t = -10:T:10;     % Time vector


% Plot raised cosine waveforms for different roll-off factors
r1 = 0.75;
%raised_cosine_pulse_r1 = (sinc(t) .* cos(pi * r1 * t)) ./ (1 - (2 * r1 * t).^2);
raised_cosine_pulse_r1 = rcosdesign(0.75, 10, Fs, "normal");
figure;
plot((0: length(raised_cosine_pulse_r1)-1)*T, raised_cosine_pulse_r1, 'r', 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Raised Cosine (r=0.75)');
grid on;
% for i=1:200001
%     % Since the size of raised cosine is not same as that of Y.
%     % Considering 2Lakh data points from audio data out of 2.08Lakh points.
%     % 8831 are redundant data points, as they contain noise. 
%     % No. of data points considered can be changed by changing the defination of t.
%     if (Y(i) == 1)
%         s_t(i) = raised_cosine_pulse_r1(i);
%     else
%         s_t(i) = -raised_cosine_pulse_r1(i);
%     end
% end

s_t = conv(Y, raised_cosine_pulse_r1);

t = (0: length(s_t)-1)*T;
figure;
plot(t, s_t, 'g', 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('S(t)');

%% Plotting the eye diagram for the same.

% Testing Data => s_t
% Took only those relevant portions of data removing noise.
modSig = pskmod(round(s_t'),4,pi/4);
sps=4;
txfilter = comm.RaisedCosineTransmitFilter('OutputSamplesPerSymbol',sps);
txSig = txfilter(modSig);
% Using the inbuilt function of eyediagram to make the eyediagram.
% eyediagram(txSig,2*sps);


%% AWGN

% Define the noise variance values
sigma1_sq = 0.5;
sigma2_sq = 2;

% Generate the noisy waveform r(t) for the first noise variance value
r1_t = awgn(s_t, 10*log10(sigma1_sq), 'measured');

% Generate the noisy waveform r(t) for the second noise variance value
r2_t = awgn(s_t, 10*log10(sigma2_sq), 'measured');

% Plot the noisy waveforms r(t)
figure;
subplot(2, 1, 1);
plot(t, r1_t);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Noisy Waveform r(t) (Noise Variance \sigma^2 = ', num2str(sigma1_sq), ')']);

subplot(2, 1, 2);
plot(t, r2_t);
xlabel('Time (s)');
ylabel('Amplitude');
title(['Noisy Waveform r(t) (Noise Variance \sigma^2 = ', num2str(sigma2_sq), ')']);

%% Eye Diagram of r(t) [r1(t), r2(t)]

% Testing Data => r1_t
% Took only those relevant portions of data removing noise.
r1_reknew = zeros(size(r1_t));
for i=1:size(r1_t)
    if (r1_t(i) >= 0)
        r1_reknew(i) = r1_t(i);
    end
end
modSig1 = pskmod(round(r1_reknew'),4,pi/4);
sps=4;
txfilter = comm.RaisedCosineTransmitFilter('OutputSamplesPerSymbol',sps);
txSig1 = txfilter(modSig1);
% Using the inbuilt function of eyediagram to make the eyediagram.
% eyediagram(txSig1,2*sps);

% Testing Data => r2_t
% Took only those relevant portions of data removing noise.
r2_reknew = zeros(size(r2_t));
for i=1:size(r2_t)
    if (r2_t(i) >= 0)
        r2_reknew(i) = r2_t(i);
    end
end

modSig2 = pskmod(round(r2_reknew'),4,pi/4);
sps=4;
txfilter = comm.RaisedCosineTransmitFilter('OutputSamplesPerSymbol',sps);
txSig2 = txfilter(modSig2);
% Using the inbuilt function of eyediagram to make the eyediagram.
% eyediagram(txSig2,2*sps);

%% Explanation for the above observation :

% 1. When the amount of random fluctuations or deviations (noise variance) in the signal is minimal, the eye diagram, which is a visualization tool used to assess the quality of digital signals, exhibits clearly defined and distinct regions resembling "eyes" with minimal distortion. The transitions between different signal levels are sharp and well-defined, indicating good signal integrity and quality.
% 2. As the level of noise variance or random fluctuations in the signal increases, the eye diagram becomes more constricted or "closed," and the eye-shaped regions become narrower. This narrowing of the eye openings is an indication of increased intersymbol interference (ISI), which is the distortion or overlapping of adjacent signal pulses caused by higher levels of noise. Consequently, it becomes more challenging to distinguish between different signal levels, potentially leading to errors in signal detection and decoding.
% 3. In summary, an increase in noise variance results in a degraded or deteriorated eye diagram, characterized by narrower eye openings. This narrowing indicates a reduction in signal quality and an increased susceptibility to transmission errors, as it becomes more difficult to accurately interpret the signal levels due to higher levels of interference and distortion

