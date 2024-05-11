function [q_output, Delta, SQNR] = uniquan (signal, L)
    % q_output => Quantised Output
    % Delta => Quantisation Interval
    % SQNR =>  Actual Signal to Noise Ratio.
    signal_Max =  max(signal(:)); % Positive Peak
    signal_Min =  min(signal(:)); % Negative Peak
    Delta = (signal_Max - signal_Min)/L;       % Quantisation Interval
    q_level = signal_Min + Delta/2 : Delta : signal_Max - Delta/2; % Defining Q levels.
    sigp = (signal - signal_Min)/Delta + 1/2; % Converting 1/2 to L + 1/2
    qindex = round (sigp);        % Rounding off to the nearest level i.e. 1, 2, 3, .., L
    qindex = min(qindex, L);      % El iminate L+1 as a rare possibility.
    q_output = q_level (qindex);  % Using index vector to generate output.
    SQNR = 20*log10(norm(signal)/norm(signal - q_output));     % Actual SQNR value.
end