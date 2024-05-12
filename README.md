# Human-Audio-Signal-Analysis

## Overview
This repository contains MATLAB code for designing a sampling and quantization module, an essential component of a communication system. The module aims to analyze various characteristics of an input analog signal, perform sampling, quantization, and PCM encoding, and study the effects of noise on the transmitted waveform. Generating eye diagrams to provide a comprehensive visualization of the signal characteristics

## Instructions
Follow the steps below to execute the MATLAB functions and analyze the signal:

1. **Input Signal Analysis**
   - A sample audio signal is used for the project.
   - Import the audio signal into MATLAB and replace it with the sample audio signal `sample_audio.m4a`.
   - Use the `input_2022006` function to display the characteristics of the signal in the time domain and frequency domain.
   - The maximum frequency component of the signal can be observed.

2. **Sampling**
   - Use the `source_2022006` function to sample the signal with frequencies less than and greater than the Nyquist rate.
   - The spectrum of the sampled signal for both cases can be compared.

3. **Quantization**
   - Choose a reasonable number of levels for quantizing the sampled outputs.
   - The quantisation noise's Mean Squared Error (MSE) is calculated.
   - Plotted the MSE vs number of quantization levels graph using the `quantize_2022006` function.

4. **PCM Encoding**
   - Encoded the quantized samples into bit streams using PCM encoding.
   - Determined the total bits used in the encoding process.

5. **Line Code and Eye Diagram**
   - Utilized polar NRZ encoding with rectangular pulses to plot the line code.
   - Depicted the first 200 pulses in the line code.
   - Generated and analyze the eye diagram using the `eyediagram` routine in Matlab.

6. **Transmit Waveform with Raised Cosine Pulses**
   - Generated a transmit waveform incorporating raised cosine pulses instead of rectangular pulses.
   - Plotted the eye diagram for the transmitted waveform.

7. **Effect of Noise on the Channel**
   - Generated the output waveform when the transmit waveform is passed through an AWGN channel.
   - Plotted the waveform for different noise variance values.
   - Analyzed the variations in the waveform with varying noise variance.
   - Plotted the eye diagram for the noisy waveform and explain the impact of increased noise variance on the eye diagram.


## File Description
- Q1.M - Sampling, Quantization and PCM Encoding
- Q2.M - NRZ Encoding and Eye Diagram
- Q4.M - Effect of noise on the channel

## Contributors
- Aarya Gupta

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
