% PUBLIC FUNCTION ne_mkda_setcondcol: set condition particle column
function varargout = ne_mkda_setcondcol(varargin)

% Version:  v0.9c
% Build:    11113013
% Date:     Nov-08 2011, 1:08 PM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/

% Copyright (c) 2011, Jochen Weber
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

% global variable
global ne_gcfg;
ch = ne_gcfg.h.MKDA.h;

% preset output
if nargout > 0
    varargout = cell(1, nargout);
end

% get content of PLP dropdown
plps = ch.PLPs;
plpud = plps.UserData;
plpid = plps.Value;
try
    plp = plpud{plpid, 3};
    if numel(plp) ~= 1 || ...
       ~isxff(plp, 'plp')
        error( ...
            'neuroelf:GUI:BadPLP', ...
            'Bad PLP object.' ...
        );
    end
catch ne_eo;
    ne_gcfg.c.lasterr = ne_eo;
    return;
end
rtv = plp.RunTimeVars;

% get column name
clname = ch.CndColumn.String{ch.CndColumn.Value};

% type of column
textcol = false;
if isfield(rtv, 'ColumnIsText') && ...
    isstruct(rtv.ColumnIsText) && ...
    numel(rtv.ColumnIsText) == 1 && ...
    isfield(rtv.ColumnIsText, clname)
    textcol = rtv.ColumnIsText.(clname);
end

% store that information
ch.CndColumn.UserData = textcol;

% for text columns
ulabv = unique(plp.(clname));
if textcol

    % get unique labels
    ulab = unique(plp.Labels(ulabv(~isnan(ulabv) & ~isinf(ulabv) & ulabv > 0)));

% for numeric column
else

    % disallow NaN values (not a numeric test!)
    hasnan = any(isnan(ulabv));
    ulabv(isnan(ulabv)) = [];

    % convert to strings
    ulab = cell(numel(ulabv), 1);
    for lc = 1:numel(ulab)
        ulab{lc} = sprintf('%.3g', ulabv(lc));
    end
    if hasnan
        ulab{end+1} = 'NaN';
    end
end

% set as default
ch.CndStaticOp.Value = 1;
ch.CndStaticOp.String = ulab;

% for text column
ch.CndOperator.Value = 1;
if textcol

    % change items for dropdown
    ch.CndOperator.String = ...
        {'is'; 'is not'; 'contains'; 'doesn''t contain'; ...
         'begins with'; 'doesn''t begin with'; 'ends in'; 'doesn''t end in'};

% for numeric column
else

    % change items for dropdown
    ch.CndOperator.String = ...
        {'equals'; 'doesn''t equal'; 'is less than'; 'is less or equal'; ...
         'is greater than'; 'is greater or equal'};
end

% set condition value
ne_mkda_setcondval;
