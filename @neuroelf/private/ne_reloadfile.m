% FUNCTION ne_reloadfile: reload a file from disk
function ne_reloadfile(varargin)

% Version:  v1.1
% Build:    16042315
% Date:     Apr-23 2016, 3:24 PM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/

% Copyright (c) 2010, 2011, 2016, Jochen Weber
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
cc = ne_gcfg.fcfg;

% valid all
if nargin < 3 || ~ischar(varargin{3}) || ~any(strcmpi(varargin{3}(:)', {'ana', 'stats'}))
    return;
end

% for anatomical files
if strcmpi(varargin{3}(:)', 'ana')

    % what page
    if cc.page < 3
        rlvar = cc.SliceVar;
    else
        rlvar = cc.SurfVar;
    end
else

    % what page
    if cc.page < 3
        rlvar = cc.StatsVar;
    else
        rlvar = cc.SurfStatsVar;
    end
end

% check and reload
if numel(rlvar) ~= 1 || ...
   ~isxff(rlvar, true) || ...
    isempty(rlvar.FilenameOnDisk(2))
    return;
end
try
    rlvar.ReloadFromDisk;
    if ~strcmpi(varargin{3}(:)', 'ana')
        rlvar.SetColors([], 'xauto');
    end
catch ne_eo;
    rethrow(ne_eo);
end

% echo
if ne_gcfg.c.echo
    ne_echo(rlvar.FileType, 'ReloadFromDisk');
end

% update correct thing
if strcmpi(varargin{3}(:)', 'ana')
    if cc.page < 3
        ne_setcvar;
    else
        ne_setcsrf;
        ne_setsurfpos;
    end
else
    if cc.page < 3
        ne_setcstats;
    else
        ne_setcsrfstats;
        ne_setsurfpos;
    end
end
