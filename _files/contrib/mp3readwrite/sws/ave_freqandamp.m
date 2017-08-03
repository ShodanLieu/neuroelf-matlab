function ave_freqandamp(F,M,timeslice);

if isempty(timeslice); return; end;

done=[];
Noscs=size(F,1);

tmp_start=num2str(timeslice(1));
tmp_end=num2str(timeslice(size(timeslice,1)));


ave_dialog=dialog('units', 'normalized',...
	'position', [.30 .40 .20 .45],...
	'Color',[0.8 0.8 0.8], ...
	'MenuBar','none', ...
	'Name','Calculate Average', ...
	'NumberTitle','off', ...
	'ButtonDownFcn', '', ...
	'userdata',0,...
	'closerequestfcn', 'uiresume');

%start
uicontrol(ave_dialog,...
	'style','text',...
	'units','normalized',...
	'horizontalalignment','left',...
	'string','Enter start time (in msec):',...
	'position',[.1 .86 .75 .1]);

start_box=uicontrol(ave_dialog,...
	'units', 'normalized',...
	'horizontalalignment','left',...
	'style', 'edit',...
	'backgroundcolor',[1 1 1],...
	'position', [.1 .85 .75 .07],...
	'string', tmp_start);
%end
uicontrol(ave_dialog,...
	'style','text',...
	'units','normalized',...
	'horizontalalignment','left',...
	'string','Enter end time (in msec):',...
	'position',[.1 .71 .75 .1]);

end_box=uicontrol(ave_dialog,...
	'units', 'normalized',...
	'style', 'edit',...
	'horizontalalignment','left',...
	'backgroundcolor',[1 1 1],...
	'position', [.1 .70 .75 .07],...
	'string', tmp_end);

%calculations window
report_window=uicontrol(ave_dialog,...
	'units', 'normalized',...
	'style', 'edit',...
	'fontname','courier',...
	'horizontalalignment','left',...
	'max',2,...
	'backgroundcolor',[1 1 1],...
	'position', [.1 .25 .75 .35]);

%OK, Done buttons
uicontrol(ave_dialog, ...
	'units', 'normalized',...
	'Position',[.6 .01 .31 .1], ...
	'String','Calculate', ...
	'Callback','set(gcbf,''UserData'',1);uiresume');
uicontrol(ave_dialog, ...
	'units', 'normalized',...
	'Position',[.1 .01 .31 .1], ...
	'String','Done', ...
	'Callback','set(gcbf,''userdata'',2);uiresume;');
	
	
% wait for input
while get(ave_dialog,'userdata')~=2;
	uiwait(ave_dialog);
	if get(ave_dialog, 'userdata'),
		start_val = str2num(get(start_box, 'string'));
		end_val = str2num(get(end_box, 'string'));
		
		%get index of times for calculations
		i=find(timeslice>=start_val & timeslice<=end_val);
		
		freq_mag=[];
		
		for a=1:Noscs
			ave_freq=mean(F(a,i));
			ave_mag=mean(M(a,i));
			freqandmag=[ave_freq ave_mag];
			freq_mag=[freq_mag; freqandmag];
		end
		
		freq_mag=sprintf('%8.2f   %7.6f\n',freq_mag');	%format for display
		set(report_window,'string',freq_mag);
	end;	
end
delete(ave_dialog);

