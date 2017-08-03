% FUNCTION ne_progress: update progress bar and return status
function varargout = ne_progress(varargin)

% Version:  v1.0
% Build:    16010821
% Date:     Jan-08 2016, 9:29 PM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/

% Copyright (c) 2015, 2016, Jochen Weber
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

% global access to configuration/handles
global ne_gcfg;
cc = ne_gcfg.c;
ch = ne_gcfg.h;

% prepare output
varargout = cell(1, nargout);

% fill output
if nargout > 0
    varargout{1} = cc.progress;
end

% progress update
if nargin > 2
    if iscell(varargin{3}) && ...
        numel(varargin{3}) == 3 && ...
        islogical(varargin{3}{1}) && ...
        numel(varargin{3}{1}) == 1 && ...
        isa(varargin{3}{2}, 'double') && ...
        numel(varargin{3}{2}) == 1 && ...
        ischar(varargin{3}{3})
        ne_gcfg.c.progress = varargin{3};
    elseif ischar(varargin{3})
        ne_gcfg.c.progress{3} = varargin{3}(:)';
    elseif islogical(varargin{3}) && ...
        numel(varargin{3}) == 1
        ne_gcfg.c.progress{1} = varargin{3};
    elseif isa(varargin{3}, 'double') && ...
        numel(varargin{3}) == 1
        ne_gcfg.c.progress{2} = varargin{3};
    end
    if nargin > 3
        if ischar(varargin{4})
            ne_gcfg.c.progress{3} = varargin{4}(:)';
        elseif isa(varargin{4}, 'double') && ...
            numel(varargin{4}) == 1
            ne_gcfg.c.progress{2} = varargin{4};
        end
        if nargin > 4 && ...
            ischar(varargin{5})
            ne_gcfg.c.progress{3} = varargin{5}(:)';
        end
    end
    cc = ne_gcfg.c;
end

% update bar
if nargin < 3 || ...
   ~isempty(varargin{3})
    ch.Progress.Progress(cc.progress{2}, cc.progress{3});
end
if cc.progress{1}
    ch.Progress.Visible = 'on';
else
    ch.Progress.Visible = 'off';
end

% update name
ne_updatename;
