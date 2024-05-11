# Human-Audio-Signal-Analysis

## Overview
This repository contains MATLAB code for designing a sampling and quantization module, an essential component of a communication system. The module aims to analyze various characteristics of an input analog signal, perform sampling, quantization, and PCM encoding, and study the effects of noise on the transmitted waveform. Generating eye diagrams to provide a comprehensive visualization of the signal characteristics

## Instructions
Follow the steps below to execute the MATLAB functions and analyze the signal:

1. **Input Signal Analysis**
   - A sample audio signal is used for the project.
   - Import the audio signal into MATLAB.
   - Use the `input_2022006` function to display the characteristics of the signal in the time domain and frequency domain.
   - Identify the maximum frequency component of the signal.

2. **Sampling**
   - Use the `source_2022006` function to sample the signal with frequencies less than and greater than the Nyquist rate.
   - Observe and compare the spectrum of the sampled signal for both cases.

3. **Quantization**
   - Choose a reasonable number of levels for quantizing the sampled outputs.
   - Calculate the Mean Squared Error (MSE) of the quantization noise.
   - Plot the MSE vs number of quantization levels graph using the `quantize_2022006` function.

4. **PCM Encoding**
   - Encode the quantized samples into bit streams using PCM encoding.
   - Determine the total bits used in the encoding process.

5. **Line Code and Eye Diagram**
   - Utilize polar NRZ encoding with rectangular pulses to plot the line code.
   - Depict the first 20 pulses in the line code.
   - Generate and analyze the eye diagram using the `eyediagram` command.

6. **Transmit Waveform with Raised Cosine Pulses**
   - Generate a transmit waveform incorporating raised cosine pulses instead of rectangular pulses.
   - Plot the eye diagram for the transmit waveform.

7. **Effect of Noise on the Channel**
   - Generate the output waveform when the transmit waveform is passed through an AWGN channel.
   - Plot the waveform for different noise variance values.
   - Analyze the variations in the waveform with varying noise variance.
   - Plot the eye diagram for the noisy waveform and explain the impact of increased noise variance on the eye diagram.


## File Description
Q1.M - Sampling, Quantization and PCM Encoding
Q1.M - NRZ Encoding and Eye Diagram
Q4.M - Effect of noise on the channel

## Contributors
- Aarya Gupta

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
