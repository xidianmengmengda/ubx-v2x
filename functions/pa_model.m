function out = pa_model(in, enabled)
%PA_MODEL Apply power amplifier non-linearity
%
%   Author: Ioannis Sarris, u-blox
%   email: ioannis.sarris@u-blox.com
%   February 2019; Last revision: 19-February-2019

% Copyright (C) u-blox
%
% All rights reserved.
%
% Permission to use, copy, modify, and distribute this software for any
% purpose without fee is hereby granted, provided that this entire notice
% is included in all copies of any software which is or includes a copy
% or modification of this software and in all copies of the supporting
% documentation for such software.
%
% THIS SOFTWARE IS BEING PROVIDED "AS IS", WITHOUT ANY EXPRESS OR IMPLIED
% WARRANTY. IN PARTICULAR, NEITHER THE AUTHOR NOR U-BLOX MAKES ANY
% REPRESENTATION OR WARRANTY OF ANY KIND CONCERNING THE MERCHANTABILITY
% OF THIS SOFTWARE OR ITS FITNESS FOR ANY PARTICULAR PURPOSE.
%
% Project: ubx-v2x
% Purpose: V2X baseband simulation model

persistent pa_obj in_len

% Default output is equal to input
out = in;

% Create and configure a memoryless nonlinearity to model the amplifier
if enabled
    if isempty(pa_obj)
        % Length of vector
        in_len = length(in);
        
        % System object
        pa_obj = comm.MemorylessNonlinearity( ...
            'Method', 'Rapp model', ...
            'Smoothness', 3, ... % p parameter
            'LinearGain', -6 ... % dB
            );
    end
    
    % Check if object needs to be released in case of varying input length
    if (length(in) ~= in_len)
        in_len = length(in);
        release(pn_obj);
    end
    
    % Apply the model to the transmit waveform
    out = pa_obj(in);
end
