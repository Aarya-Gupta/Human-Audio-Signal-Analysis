%% PCS Assignment3
% By Aarya Gupta (2022006) | Date : 29th April, 2024

%% Problem 1

%% Displaying Audio Wave Form, and its required charachterstics.
set(groot, 'defaultAxesColorOrder', [0, 0, 0.8; 0.8, 0, 0]); % Set default color to blue and red combination

function [audioData, time, f, audioData_fft, amplitude, phase, fm] = input_2022006(FilePath)
    % Importing the audioData
    [audioData, fm] = audioread(FilePath);
    
    % Above function returns the size of the audioData matrix along the first 
    % dimension, which corresponds to the number of rows;
    % Audio signal as a matrix implies that the each row represents a sample in
    % the audio signal, while each column represents a channel in the audio signal; 
    % hence we are accessing no. of channels in audio signal.
    % mono-audio => size(audioData, 2)=1
    % stereo => size(audioData, 2) = 2 
    
    % fm is the frequency at which the audioData has been sampled.
    
    % Verifying the audio by playing it; and checking if its imported correctly
    % or not.
    
    %sound(audioData, fm);
    
    % Displaying the signal in time domain.
    time = (0:size(audioData, 1)-1)/fm;
    
    subplot(2, 1, 1);
    plot(time, audioData);
    xlabel("Time (seconds)");
    ylabel("Amplitude");
    title("Audio Wavedform (for all sample points)");
    
    subplot(2, 1, 2);
    plot(time(57000:168000), audioData(57000:168000,:));
    % If don't want to display complex nos.
    % plot(time(57000:168000), audioData(57000:168000));
    xlabel("Time (seconds)");
    ylabel("Amplitude");
    title("Audio Wavedform (Zoomed)");  
    
    % It can be seen that the amplitude is less than 1; because while the data
    % is been recorded, in its processing, the audio is normalised; so that the
    % maximum value reached by the audio reaches a certain level; which is 1 in
    % this case.
    
    % Performing FFT
    audioData_fft = fft(audioData);
    f = linspace (-fm/2, fm/2, length(time));
    
    % Extracting amplitude and phase
    amplitude = fftshift(abs(audioData_fft));
    phase = angle(audioData_fft);
    
    % Plotting amplitude
    figure;
    subplot(2, 1, 1);
    plot(f(95000:115000), amplitude(95000:115000, :));
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Amplitude Plot');
    
    % Plotting phase
    subplot(2, 1, 2);
    %plot(f(100000:110000), phase(100000:110000, :));
    plot (f, phase);
    axis([-100, 100, -3.15, 3.15]);
    xlabel('Frequency (Hz)');
    ylabel('Phase (radians)');
    title('Phase Plot');
end

[audioData, time, f, audioData_fft, amplitude, phase, fm] = input_2022006('C:\Users\aarya\OneDrive\Desktop\_\SEM 4\PCS\2022006_Aarya_Gupta_PCS_Ass-2\PCS_Ass-2_Recording.m4a');

%% Displaying the maximum frequency component of the signal; 
N = length(audioData_fft); % Length of the FFT
[max_amplitude, max_index] = max(amplitude);
frequency_resolution = fm / N; % Frequency resolution
max_frequency = (max_index-1) * frequency_resolution; % Maximum frequency component
% In MATLAB, array indexing starts from 1, so the index of the first element in an array is 1. 
% However, when working with frequency components obtained from a Fourier transform, the frequency 
% index starts from 0.

disp(['Maximum frequency component : ', num2str(max_frequency), ' Hz']);
disp(['Maximum Amplitude : ', num2str(max_amplitude)]);
% 824.97824 => Real Component of Maximum Amplitude
% 1618.7126 => Complex Component of Maximum Amplitude
% Output : 
% Maximum frequency component : 23884.0402      23884.0402 Hz
% Maximum Amplitude : 824.97824      1618.7126


%% Sampling Using a Frequency less than and greater than the Nyquist rate

function [z, resultantSignalTimeDomain, resultantSignalFrequencyDomain] = source_2022006 (signal, fm, n)
    % fs = n*max_frequency;
    % Sending the signal through a 16 level uniform quantizer.
    % [s_out, sq_out, sqh_out, Delta, SQNR] = sampandquant(signal, 16, 1/max_frequency, 1/fs);
    z = zeros (1, length(signal));
    z (1:n:end) = 1;
    % Sets the value of every nth element starting from 1 to end as 1.
    resultantSignalTimeDomain = zeros(size(z));

    for i=1 : length(z)
        resultantSignalTimeDomain(i) = signal(i) .* z(i);
    end 
    resultantSignalFrequencyDomain = abs(fftshift(fft(resultantSignalTimeDomain)));

    figure;
    % Plotting sampled signal as stem; as told in class/tutorial by Varun
    % bhaiya. But stem is veryu untidy, hence made plot only.
    stem(1 : length(resultantSignalTimeDomain), resultantSignalFrequencyDomain);
    plot(1 : length(resultantSignalTimeDomain), resultantSignalFrequencyDomain);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    %  (Comomon axis and labels for all plots); so that one is not confused
    %  which plot belongs to which n; Go with the order of calling.
end


% CASE 1 : Sampling with a rate greater than or equal to Nyquist rate
[z_n1, resultantSignalTimeDomain_n1, resultantSignalFrequencyDomain_n1] = source_2022006(audioData,fm, 3);
title('Amplitude (Fs >= 2*Fm)');
% In this code; fs = (1/n) * fm.
% fs = 2*fm is going to be plotted 
% Since fs >= 2*fm; hence the original signal can be reconstructed from the
% sampled signal.

% CASE 2 : Sampling with a rate less Nyquist rate
[z_n2, resultantSignalTimeDomain_n2, resultantSignalFrequencyDomain_n2] = source_2022006(audioData, fm, 15);
title('Amplitude (Fs < Fm)');
% Since fs < 2*fm; hence the original signal can't be reconstructed from the
% sampled signal.

%% Quantisation & MSE v/s L Plot

function [mp, L, del_v, MSE] = quantize_2022006 (signal)
    mp = max(signal(:));
    % Adding a semi colon treats data across all the channels as samples only.
    
    L = [2, 4, 8, 16, 32];
    % Have taken lower L values, so that poor quantisation can take place,
    % resulting into higher quantisation error, which makes the plot more
    % readable. Higher values of L result in finer quantization (more levels), 
    % leading to potentially lower quantization error (MSE); hence haven't
    % included very high L values, because in that case the plot shrinks
    % horizontally, reducing the visible effect of change in MSE at lower
    % levels. To effectively see a stark change in MSE w.r.t increase in
    % levels, smaller values of L should be considered.
    %
    % If considered the below list of L, then a very biased plot will be
    % obatained, which visually shows a stark decrease in MSE right after
    % 0; which actually is not the case as seen in the above example of L.
    % Everything visual change in MSE is relative to the no. of values of L
    % and type of values in L.
    % L = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048];


    del_v = zeros(size(L));
    % Creating a vector of 2*mp; as (2*mp) .* L(i) is raising error : 
    % "Unable to perform assignment because the left and right sides have a different number of elements.".
    % The above error was raised, because mp is a 1x2 vector (stereo audio in 2 channels), not a scalar; 
    for i=1 : length(L)
        del_v(i) =  2*mp/L(i);
        % If max(signal) as mp, then assuming min(signal) as -mp. 
    end
    
    MSE = zeros(size(L));
    for i=1 : length(L)
        MSE(i) = (del_v(i).*del_v(i))/12;
    end
    
    figure;
    plot (L, MSE);
    xlabel('Levels');
    ylabel('MSE');
    title('MSE v/s L Plot');
end
[mp, L, del_v, MSE] = quantize_2022006 (audioData);

%% PCM Encoding 
% Encoding samples into bit stream.

function out = PCM_Encoding(signal, n2)
    L = 2^n2;
    [qoutput, Delta, SQNR] =uniquan(signal(57000:168000,:),L);
    % Selecting only that portion of the audioData, which is free from noise 
    % i.e. samples in the range 57000 - 168000
    quantisation=max(qoutput)/(2^n2-1);
    y=round(qoutput/quantisation);       
    y = abs(y);                                                                     
    encodedbit = strings(1,length(y));
    for i=1:length(y) % Since y is vector , so this for loop is run for whole vector and pass it to given function decimal to binary 
        encodedbit(i) = decimal2binary(y(i));%function for converting Decimal to binary 
    end
    
    for i=1:length(encodedbit) % This for loop repserent the correct encode bits 
        if strlength(encodedbit(i)) < n2 
            len = n2-strlength(encodedbit(i));
            for j=1:len
                encodedbit(i) = "0" + encodedbit(i);
            end
        end
    end
    out = encodedbit;
end
result_PCM_Encoding = PCM_Encoding(audioData, 5);
% Enter the no. of bits, in which the encoding is to be done. 
% No. of levels will be determined internally. 
disp(result_PCM_Encoding);