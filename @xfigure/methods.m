function names = methods(xo)
%XFIGURE::METHODS  Set the global xfigures methods array.
%
%   This function should not be called by a user.

% Version:  v1.1
% Build:    16042312
% Date:     Apr-23 2016, 12:44 PM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/
%
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

% stored in persistent array
global xfiguremeth;
if isempty(xfiguremeth)
    xfiguremeth = struct('m', struct(...
        'addbarbutton',     {{@addbarbutton,    1, 'AddBarButton', '^struct$'}}, ...
        'addbarplot',       {{@addbarplot,      1, 'AddBarPlot', '^struct$'}}, ...
        'addstring',        {{@addstring,       1, 'AddString', '^(cell|char)$', '[^double$'}}, ...
        'adduicontextmenu', {{@adduicontextmenu, 1,'AddUIContextMenu', '^struct$'}}, ...
        'adduicontrol',     {{@adduicontrol,    1, 'AddUIControl', '^struct$'}}, ...
        'adduimenu',        {{@adduimenu,       1, 'AddUIMenu', '^struct$'}}, ...
        ...
        'bringtofront',     {{@bringtofront,    0, 'BringToFront'}}, ...
        'childpositions',   {{@childpositions,  1, 'ChildPositions'}}, ...
        'createfigure',     {{@createfigure,    1, 'CreateFigure', '^struct$'}}, ...
        'createfigurefromfile', {{@createfigurefromfile, 1, 'CreateFigureFromFile', '^char$'}}, ...
        'deleteallfigures', {{@deleteallfigures, 0,'DeleteAllFigures'}}, ...
        'delete',           {{@delete,          0, 'Delete', '[^(xfigure|double)$'}}, ...
        'docallback',       {{@docallback,      0, 'DoCallback', '[^(xfigure|double)$'}}, ...
        ...
        'get',              {{@getprop,         1, 'Get', '^char$'}}, ...
        'getcontext',       {{@getcontext,      1, 'GetContext'}}, ...
        'isactive',         {{@isactive,        1, 'IsActive'}}, ...
        'isenabled',        {{@isenabled,       1, 'IsEnabled'}}, ...
        'isvisible',        {{@isvisible,       1, 'IsVisible'}}, ...
        'loadfields',       {{@loadfields,      0, 'LoadFields', '[^(cell|char)$'}}, ...
        'loadprops',        {{@loadprops,       1, 'LoadProps'}}, ...
        ...
        'mlhandle',         {{@mlhandle,        1, 'MLHandle'}}, ...
        'mdelete',          {{@mdelete,         1, 'MDelete', '^double$'}}, ...
        'mmove',            {{@mmove,           1, 'MMove', '^double$', '[^double$'}}, ...
        'msize',            {{@msize,           1, 'MSize'}}, ...
        'mstring',          {{@mstring,         1, 'MString', '[^double$', '[^(cell|char)$', '[^(double|logical)$'}}, ...
        'parentobj',        {{@parentobject,    1, 'ParentObj'}}, ...
        'progress',         {{@progress,        1, 'Progress', '[^double$', '[^char$'}}, ...
        ...
        'radiogroups',      {{@radiogroups,     1, 'RadioGroups'}}, ...
        'radiogroupsetone', {{@radiogroupsetone, 0,'RadioGroupSetOne', '[^(xfigure|double)$'}}, ...
        'redraw',           {{@redraw,          0, 'Redraw'}}, ...
        'redrawfig',        {{@redrawfig,       0, 'RedrawFig'}}, ...
        'resize',           {{@resize,          0, 'Resize'}}, ...
        'savefields',       {{@savefields,      0, 'SaveFields', '[^(cell|char)$'}}, ...
        'set',              {{@setprop,         1, 'Set', '^char$', '^[a-z][a-z0-9]+$'}}, ...
        ...
        'setbarydata',      {{@setbarydata,     0, 'SetBarYData', '^double$'}}, ...
        'setcontext',       {{@setcontext,      0, 'SetContext', '[^(xfigure|double)$'}}, ...
        'setgroupenabled',  {{@setgroupenabled, 0, 'SetGroupEnabled', '^char$'}}, ...
        'setgroupvisible',  {{@setgroupvisible, 0, 'SetGroupVisible', '^char$'}}, ...
        'showpage',         {{@showpage,        1, 'ShowPage', '[^(char|double)$'}}, ...
        'slidegroupxy',     {{@slidegroupxy,    0, 'SlideGroupXY', '^char$', '^double$', '[^double$'}}, ...
        ...
        'tagstruct',        {{@tagstruct,       1, 'TagStruct'}}, ...
        'updatefield',      {{@updatefield,     0, 'UpdateField'}}, ...
        'updatefields',     {{@updatefields,    0, 'UpdateFields', '[^char$'}}, ...
        'value',            {{@value,           1, 'Value'}}, ...
        'xclick',           {{@xclick,          0, 'XClick'}}), ...
    't', {{ ...
        logical([0 0 1 0 0 0  1 0 0 0 0 1 1  1 1 1 1 1 0 1  1 0 0 0 0 1 0  0 0 1 1 0 0 1  1 1 1 1 1 1  0 0 0 1 1]), ...
        logical([0 0 0 0 0 0  0 0 1 1 1 1 0  1 1 0 0 0 0 1  1 0 0 0 0 0 0  0 0 0 0 0 0 1  0 1 0 0 0 0  0 0 0 0 0]), ...
        logical([0 0 0 1 1 1  1 1 0 0 0 1 1  1 1 0 0 1 1 1  1 0 0 0 0 1 0  1 1 1 1 1 1 1  0 1 1 1 1 1  1 0 1 0 0]), ...
        logical([1 1 1 0 0 0  1 0 0 0 0 1 1  1 1 1 1 1 1 1  1 1 1 1 1 1 1  0 1 1 1 0 0 1  0 1 1 1 1 1  0 1 1 1 1]), ...
        logical([0 0 0 0 0 0  1 0 0 0 0 1 1  1 0 1 1 1 0 1  1 0 0 0 0 1 0  0 0 1 1 0 0 1  0 0 1 1 0 0  0 0 0 0 0]), ...
        logical([0 0 0 0 0 0  0 0 0 0 0 1 1  1 0 1 1 1 0 1  1 0 0 0 0 1 0  0 0 0 0 0 0 1  0 0 0 0 0 0  0 0 0 0 0])}});
end

% only accept single object
if numel(xo) ~= 1
    names = {};
    return;
end

% retrieve method names
try
    Mall = fieldnames(xfiguremeth.m);
    names = Mall(xfiguremeth.t{xo.T + 2});
catch xfigerror
    error('neuroelf:xfigure:lookupError', ...
        'Error looking up methods: %s.', xfigerror.message);
end
