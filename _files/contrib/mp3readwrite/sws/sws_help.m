function sws_help

overview = {
'SWS - SineWave Synthesis'
''
'(c) 2000, Haskins Laboratories, New Haven, CT, USA'
'Authors: Philip Rubin, Steve Frost, and DAn Ellis'
''
' v2.10, September 22, 2002 Steve Frost'
''
''
'Feedback to Steve Frost <frosts@haskins.yale.edu>'
'If you would like a copy of MATLAB SWS,'
'contact Philip Rubin <rubin@haskins.yale.edu>'
''
'-----------------------------------------------------'
''
'SWS is a MATLAB package for manipulating, displaying, and'
'synthesizing tone analogs of natural utterances, and other'
'similar acoustic signals.'
''
'For additional information on sinewave synthesis, see:'
' http://ww.haskins.yale.edu/haskins/MISC/SWS/SWS.html'
''
'-----------------------------------------------------'
''
};

notes= {
'NOTES:'
''
'Input PARAMETER files.'
'SWS now handles two types of SWS input files (now called PARAMETER files).'
'	SWI: the original SWS ASCII input files with the format:'
'    Number of oscillators'
'      Time0'
'         frq,mag   for 1st oscillator'
'         frq,mag   for 2nd oscillator'
'         .. for as many oscillators as specified'
'      Time1'
'         frq,mag  ... etc.'
''
'	SWX: Excel tab-delimited ASCII files with the following format:'
'    Number of oscillators'
'      Time0	oscillator1freq   oscillator1mag...oscillatorNfreq	oscillatorNmag'
'      Time1	oscillator1freq   oscillator1mag...oscillatorNfreq	oscillatorNmag'
'         for as many Time values specified'
'Times for both format are in msec, frq in Hz, mag in linear units'
''
'SWS will automatically open either SWI or SWX files. Output format'
'can be specified under PREFERENCES using PARAMETER FORMAT so that'
'you can, for example, OPEN an SWI file, change the PARAMETER FORMAT'
'to SWX, and then output an SWX format file.'
''
'For the benefit of speed, SWS parameter files are no longer automatically'
'listed when they are OPENed. You can control automatic listing (and display)'
'using then ON OPEN option under PREFERENCES.'
''
'The window that lists the SWS parameter values can no longer be used for'
'editing. There are some limited editing commands that can be found in the'
'EDIT menu. More extensive editing should be done using Excel.'
''
'If you modify the SWS parameter data using any of the edit or other'
'commands, you will need to redisplay or relist to updata the parameter'
'display and listing windows.'
''
};


stkfiles= {
'STK files are parameter files for a commercial software speech'
'synthesizer called SynthWorksª from Scicon Research and Development'
'(www.sciconrd.com).'
''
'To convert STK files into SWS Excel parameter files (.SWX),'
'go to the MATLAB Command Window (outside of the SWS GUI)'
'and at the command line (">>") type:'
'    stk2swx    (followed by a return).'
'The conversion routine will put up a standard file dialog box to'
'let you find and open the desired STK file. It will then process the file'
'(note: this can take a long time -- please be patient).'
'Once the conversion has been completed, the routine will again put up'
'a standard file dialog box so that you can save the output SWX file'
'in the desired location.'
''
'Please note that stk2swx is an experimental routine. At present, it only'
'converts the formant values from STK files. Until Scicon provides an'
'adequate approach for saving individual formant amplitudes, all amplitudes'
'are replaced with the value 1. Note also that stk2swx grabs all 5 formant'
'values. If you are only interested in, for example, the lowest three,'
'use the EDIT DATA: DELETE SINEWAVE command from the SWS GUI to delete'
'formants 4 and 5 by clicking in the dialog box, typing 4:5, and then'
'pressing the OK button. Remember to re-list and re-display if desired.'
''
};


extractparameters = {
'This option allows the user to generate sine wave speech signals'
'by performing an LPC analysis of a speech signal and returns Frequency'
'and Magnitude parameter estimatesthat can be edited and played in Matlab SWS.'
''
'Users can choose the number of formants, the windows size in msec,'
'and the overlap in msec. For best results, users should choose a number of'
'formants that is the number of desired formants + 2 and then delete the extra'
'2 formants after the analysis.'
''
'The window size and overlap for the LPC analysis are given in msec instead of'
'samples to match with the format for the SWI and SWX input files where Times'
'are given in msec. To convert msecs to samples use the formula:'
''
'samples=floor(msecs*samplingrate/1000);'
''
'The analysis routines were provided by Dan Ellis. Full details are available at:'
'http:/www.ee.columbia.edu/~dpwe/resources/matlab/sws'
};


s={
'Overview' overview ;
'Notes' notes;
'Extracting Parameters' extractparameters;
'STK files' stkfiles};

helpwin(s,'Overview','SWS Help');
