% FUNCTION ne_physio_browse: browse for physio file
function ne_physio_browse(varargin)

% Version:  v0.9b
% Build:    11050712
% Date:     Apr-10 2011, 4:52 PM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/

% Copyright (c) 2010, 2011, Jochen Weber
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
cc = ne_gcfg.c.physio;

% try to get handle
try
    fPhysio = xfigure(get(varargin{1}, 'Parent'));
catch ne_eo;
    neuroelf_lasterr(ne_eo);
    return;
end
ud = fPhysio.UserData;
ud.hTag.BT_physio_sf_load.Enable = 'off';

% bring up dialog
[pfile, pfolder, findex] = uigetfile(cc.filter, ...
     'Please select a file containing physiological data.', ...
     'MultiSelect', 'off');

% check selection
if isequal(pfile, 0) || ...
    isequal(pfolder, 0) || ...
    isempty(pfile)
    return;
end
if isempty(pfolder)
    pfolder = pwd;
end
pfolder = strrep(pfolder, '\', '/');
if pfolder(end) == '/'
    pfolder(end) = [];
end

% re-sort filters?
if findex > 1 && ...
    findex <= size(cc.filter, 1)
    ne_gcfg.c.physio.filter = ...
        cc.filter([findex, setdiff(1:size(cc.filter, 1), findex)], :);
end

% set in selection
ud.hTag.ED_physio_sf.String = [pfolder '/' pfile];
ud.hTag.BT_physio_sf_load.Enable = 'on';
