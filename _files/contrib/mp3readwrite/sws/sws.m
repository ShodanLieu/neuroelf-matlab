function SWS(command_str)

% To run the SWS GUI, type SWS at the MATLAB command prompt.
% The SWS GUI has its own menu structure: use the commands
% from these menus. Additional help is available from the ABOUT
% menu selection from within the GUI.



%	initialize constants and variables to default values

state=struct('SWS_FIG',[],...
	'FREQ',[],...
	'MAG',[],...
	'TIMESLICES',[],...
	'NUM_OSCS',[],...
	'INPUT_FORMAT', [],...				%.au,.wav,.syn
	'OUTPUT_FORMAT',[],...			%.au,.wav
	'SRATE',22050,...
	'PARAMETER_FORMAT','.swi',...		%.swi,.swx
	'DATAWINDOW',[],...				%datawindow handle
	'MENUS',[],...
	'SOUND_OUT',[],...					%data for PLAY
	'FILENAME',[],...					
	'WAVEFORM_FIG',[],...
	'COPY',[],...						%copy for UNDO
	'ALLDATA',[],...					%data for display in DATAWINDOW
	'SLIDER',[],...						%slider handle
	'LIST',[],...						%handle to list uicontrol				
	'FILEDISPLAY',[],...				%handle for display of filename
	'OPENSETTINGS',[0 1]);				%defaults for list(no) and display(yes) on open		
	
if nargin==0
	command_str='initialize';
end

SWS_size=get(0,'screensize');
dl=SWS_size(1);
db=SWS_size(2);
dw=SWS_size(3);
dh=SWS_size(4);

if strcmp(command_str, 'initialize')                             
	SWS_FIG = figure('Color',[0.8 0.8 0.8], ...
		'MenuBar','none', ...
		'Name','SineWaveSynthesis', ...
		'renderer','zbuffer',...
		'backingstore','off',...
		'NumberTitle','off', ...
		'position',[((dl+db)/2) ((db+dh)/8) dw.*.75 dh.*.75],...
		'Tag','SineWaveSynthesis');
	file_menu = uimenu('Parent',SWS_FIG, ...
		'Label','File', ...
		'Tag','File');
	file_about=uimenu('parent',file_menu,...
		'Label','About',...
		'callback','SWS_help');
	file_extract=uimenu('parent',file_menu,...
		'Label','Extract Parameters',...
		'accelerator','E',...
		'Tag','Extract',...
		'separator','on',...
		'callback','SWS_gui EXTRACT');
	file_open = uimenu('Parent',file_menu, ...
		'Callback','SWS_gui OPEN', ...
		'Label','Open Parameter', ...
		'accelerator','O',...
		'separator','on',...
		'Tag','FileOpen');
	file_save = uimenu('Parent',file_menu, ...
		'Callback','SWS_gui SAVE', ...
		'Label','Save Parameter', ...
		'accelerator','S',....
		'Tag','FileSave');
	file_openwave = uimenu('Parent',file_menu, ...
		'Callback','SWS_gui WAVEOPEN', ...
		'Label','Open Audio', ...
		'Separator','on', ...
		'Tag','OpenWave');
	file_savewave = uimenu('Parent',file_menu, ...
		'Label','Save Audio', ...
		'callback', 'SWS_gui AUDIOSAVE',...
		'Tag','SaveAudio');
	file_preferences = uimenu('Parent',file_menu, ...
		'Label','Preferences', ...
		'Separator','on', ...
		'Tag','Preferences');
	pref_opensettings=uimenu('parent',file_preferences,...
		'label','On Open...',...
		'callback','SWS_gui OPENSETTINGS');
	pref_parameters = uimenu('Parent', file_preferences,...
		'Label', 'Parameter Output',...
		'separator','on',...
		'Tag', 'ParameterFormat');	
	swi_format=uimenu('parent',pref_parameters,...
		'label','.SWI Format',...
		'Checked','on',...
		'userdata',1,...
		'callback', 'SWS_gui PARAMETERFORMAT');
	swx_format=uimenu('parent',pref_parameters,...
		'label','.SWX Format',...
		'Checked','off',...
		'userdata',2,...
		'callback', 'SWS_gui PARAMETERFORMAT');		
	pref_audioform = uimenu('Parent', file_preferences,...
		'Label', 'Audio Output',...
		'separator','on',...
		'Tag', 'AudFormat');
	wv_format =uimenu('Parent', pref_audioform,...
		'Label', '.WAV Format',...
		'Checked', 'on',...
		'userdata', 1,...
		'callback', 'SWS_gui AUDIOFORMAT');
	au_format = uimenu('Parent', pref_audioform,...
		'Label', '.AU Format',...
		'userdata', 2,...
		'Checked', 'off',...
		'callback', 'SWS_gui AUDIOFORMAT');
	pref_samplingrate = uimenu('Parent',file_preferences, ...
		'Label','Output Sampling Rate', ...
		'separator', 'on',...
		'Tag','SamplingRate');
	sr_8000=uimenu('Parent', pref_samplingrate,...
		'Label', '8000 Hz',...
		'userdata', 1,...
		'checked', 'off',...
		'callback', 'SWS_gui SAMPLERATE');
	sr_10000=uimenu('Parent', pref_samplingrate,...
		'Label', '10000 Hz',...
		'userdata', 2,...
		'checked', 'off',...
		'callback', 'SWS_gui SAMPLERATE');
	sr_11025=uimenu('Parent', pref_samplingrate,...
		'Label', '11025 Hz',...
		'userdata', 3,...
		'checked', 'off',...
		'callback', 'SWS_gui SAMPLERATE');
	sr_20000=uimenu('Parent', pref_samplingrate,...
		'Label', '20000 Hz',...
		'userdata', 4,...
		'checked', 'off',...
		'callback', 'SWS_gui SAMPLERATE');
	sr_22050=uimenu('Parent', pref_samplingrate,...
		'Label', '22050 Hz',...
		'userdata', 5,...
		'checked', 'on',...
		'callback', 'SWS_gui SAMPLERATE');
	sr_44100=uimenu('Parent', pref_samplingrate,...
		'Label', '44100 Hz',...
		'userdata', 6,...
		'checked', 'off',...
		'callback', 'SWS_gui SAMPLERATE');
	pref_waveformscaling=uimenu('parent',file_preferences,...
		'label', 'Waveform Amplitude',...
		'separator','on');
	minmaxscale_amp=uimenu('parent',pref_waveformscaling,...
		'label','Scale Min to Max',...
		'userdata',1,...
		'checked','off',...
		'callback','SWS_gui WAVEFORMSCALE');
	fullscale_amp=uimenu('parent',pref_waveformscaling,...
		'label','Fullscale (-1 to +1)',...
		'userdata',2,...
		'checked','on',...
		'callback','SWS_gui WAVEFORMSCALE');
	file_quit = uimenu('Parent',file_menu, ...
		'Accelerator','W', ...
		'Callback','SWS_gui BYEBYE', ...
		'Label','Close SWS', ...
		'Separator','on', ...
		'Tag','Quit');
	data_menu = uimenu('Parent',SWS_FIG, ...
		'Label','Data', ...
		'Tag','DataMenu');
% 	data_input = uimenu('Parent',data_menu, ...
% 		'Accelerator','I', ...
% 		'Callback', 'SWS_gui INPUTDATA',...
% 		'Label','Input', ...
% 		'Tag','Input');
	state.LIST=uimenu('parent',data_menu,...
		'Accelerator','L',...
		'Label','List',...
		'callback','SWS_gui LISTPARAMETERS');
	data_display = uimenu('Parent',data_menu, ...
		'Accelerator','D', ...
		'Label','Display', ...
		'Separator','oN', ...
		'callback', 'SWS_gui DISPLAYDAT',...
		'Tag','Display');
	data_zoom=uimenu('parent', data_menu,...
		'Accelerator', 'Z',...
		'Label', 'Zoom',...
		'userdata',0,...
		'callback', 'SWS_gui ZOOMVIEW');
	data_wave = uimenu('Parent',data_menu, ...
		'Label','Waveform', ...
		'callback', 'SWS_gui WAVEFORM',...
		'Tag','Wave');
	data_play = uimenu('Parent',data_menu, ...
		'Accelerator','Y', ...
		'Callback','SWS_gui PLAY', ...
		'Label','Play All', ...
		'Separator','on', ...
		'Tag','Play');
	data_playdisplay = uimenu('Parent',data_menu, ...
		'Accelerator','T', ...
		'Callback','SWS_gui PLAYDISPLAY', ...
		'Label','Play Displayed', ...
		'Tag','PlayDisplay');
	input_axis = axes('Parent',SWS_FIG, ...
		'Box','on', ...
		'Color',[1 1 1], ...
		'Position',[0.0943464 0.531887 0.797386 0.414528], ...
		'XTick', [],...
		'YTick', [],...
		'Tag','WaveformDisplay');
	state.DATAWINDOW = uicontrol ('Parent', SWS_FIG,...
		'Units','normalized', ...
		'BackgroundColor',[1 1 1], ...
		'FontName','Courier', ...
		'FontSize',12, ...
		'Position',[0.0943464 0.05 0.797386 0.414528], ...
		'HorizontalAlignment', 'left',...
		'max',2,...
		'Style','edit', ...
		'Tag','DataWindow');
	state.SLIDER=uicontrol('parent',SWS_FIG,...
		'style','slider',...
		'units','normalized',...
		'min',-1,...
		'max',1,...
		'value',1,...
		'enable','off',...
		'sliderstep',[0.005 0.05],...
		'position',[0.9 .045 .025 .425],...
		'callback','SWS_gui MOVETHRULIST');
	ed_data=uimenu('Parent',SWS_FIG,...
		'Label', 'Edit Data');
	undo_change=uimenu('parent',ed_data,...
		'label','Undo',...
		'accelerator','Z',...
		'enable','off',...
		'tag','undo',...
		'callback','SWS_gui UNDOLAST');
	del_sinewave=uimenu('parent',ed_data,...
		'label', 'Delete Sinewave',...
		'separator','on',...
		'accelerator', 'K',...
		'callback', 'SWS_gui SINEWAVEDELETE');	
	add_data=uimenu('parent', ed_data,...
		'label', 'Add',...
		'separator','on',...
		'callback', 'SWS_gui ADDDATA');
	mult_data=uimenu('Parent', ed_data,...
		'Label', 'Multiply',...
		'callback', 'SWS_gui MULTDATA');	
	setfreq_data=uimenu('parent',ed_data,...
		'Label','Set Frequency',...
		'separator','on',...
		'callback','SWS_gui SETFREQ');
	setamp_data=uimenu('parent',ed_data,...
		'label','Set Amplitude',...
		'callback','SWS_gui SETAMP');
	harmonic_data=uimenu('parent',ed_data,...
		'label','Create Harmonic',...
		'separator','on',...
		'callback','SWS_gui HARMONIC');
	aver_data=uimenu('parent',ed_data,...
		'label','Calculate Average',...
		'separator','on',...
		'callback','SWS_gui AVERAGE');
	state.FILEDISPLAY = uicontrol(SWS_FIG, ...
		'Style', 'text', ...
		'fontsize', 12,...
		'units', 'normalized',...
		'HorizontalAlignment', 'center', ...
		'Position', [.32 .47 .35 .03]);
end


state.SWS_FIG=SWS_FIG;

%---- save handles to checked menu items ----		
menus = [swi_format swx_format wv_format au_format sr_8000 sr_10000 sr_11025 sr_20000 sr_22050 sr_44100 minmaxscale_amp fullscale_amp];

state.MENUS = menus;

set(SWS_FIG, 'UserData', state);
