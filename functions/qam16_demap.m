function llr_out = qam16_demap(sym_in)
%QAM16_DEMAP Performs demapping of QAM-16 modulation
%
%   Author: Ioannis Sarris, u-blox
%   email: ioannis.sarris@u-blox.com
%   August 2018; Last revision: 30-August-2018

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

% Initialize output LLR vector
llr_out = zeros(2, size(sym_in, 2));

% Find regions of input symbols
idx_1 = (abs(sym_in) > 2);
idx_2 = (abs(sym_in) <= 2);

% Calculate LLRs (1st soft-bit) using a different equation for each region
llr_out(1, idx_1) = 8*sym_in(idx_1) - sign(sym_in(idx_1))*8;
llr_out(1, idx_2) = 4*sym_in(idx_2);

% Calculate LLRs (2nd soft-bit)
llr_out(2, :) = -4*abs(sym_in) + 8;

end
