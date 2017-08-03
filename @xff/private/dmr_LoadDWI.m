function xo = dmr_LoadDWI(xo)
% DMR::LoadDWI  - load linked DWI data of a DMR into memory
%
% FORMAT:       [dmr] = dmr.LoadDWI;
%
% No input / output fields.

% Version:  v1.1
% Build:    16021412
% Date:     Feb-14 2016, 12:55 PM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/
%
% Copyright (c) 2010, 2011, 2014, 2016, Jochen Weber
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of Columbia University nor the
%       names of its contributors may be used to endorse or promote products
%       derived from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% argument check
if numel(xo) ~= 1 || ~xffisobject(xo, true, 'dmr')
    error('neuroelf:xff:badArgument', 'Invalid call to %s.', mfilename);
end

% try loading the DWI
bc = xo.C;
if istransio(bc.DWIData)
    try
        bc.DWIData = bc.DWIData(:, :, :, :);
    catch xfferror
        error('neuroelf:xff:transioError', 'Error resolving transio access: %s.', xfferror.message);
    end
    xo.C = bc;
end
