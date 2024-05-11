% This method has been referred from book B.P. Lathi; Pg - 314, Ch-6; 

function [s_output, sq_output, sqh_output, Delta, SQNR] = samp_and_quant(signal, L, td,ts)
    % L => no. of quantisation levels.
    % signal => input signal
    % td => original signal sampling period
    % ts => new sampling period
    % Outputs ; 
    % s_out => sampled output
    % sq_out => sampled and quantised output
    % sqh_out => sampled, quantised and hold output
    % SQNR => Actual Signal to Noise Ratio.
    if (rem(ts/td, 1) == 0)
        nfac = round(ts/td);
        p_zoh = ones(1, nfac);
        s_output = downsample(signal, nfac);
        [sq_output ,Delta, SQNR] = uniquan (s_output, L);
        s_output = upsample (s_output, nfac);
        sqh_output = kron(sq_output, p_zoh); 
        sq_output = upsample(sq_output, nfac);
    else
        warning ("Error!!! ts/td is not an integer.");
        s_output = []; sqh_output =[]; sq_output = []; Delta = []; SQNR = [];
    end
end 