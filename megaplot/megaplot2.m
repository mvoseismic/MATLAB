function megaplot2( mode, standard, time_period )
% megaplot2
%
% Second version of MVO Megaplot program.
% Argument:
%   none             Runs interactively
%   'interactive'    Runs interactively
%   'gui'            Calls a GUI to set plot parameters
%   'batch'          Runs as a batch file, using file mp2.mat
%   file name        Runs as a batch file, using file name in argument
%
% R.C. Stewart, MVO, 23-Jan-2020

% Initialise global variables in setup structure
setup = setupGlobals();
setup.Tstart = tic;


% Check for argument, run interactively if none
if nargin == 0
    mode = 'interactive';
end

if strcmp( mode, 'list' )
    mode = '';
    setup = setPeriod( setup, 'list' );
    plotStandard( setup, 'list' );
else
    reFetch( setup );
end

% Setup all plot parameters depending on mode 

switch mode
    
    case {'interactive','inter'}
        
        setup.Log2File = false;
        setup.Plot2File = false;
        
        setup = setInteractive( setup );

    
    case 'gui'
        
        setup.Log2Screen = false;
        setup.Plot2File = false;

        setup = setGui( setup );
        
        
    % batch mode, using file for input (default mp2.mat)
    otherwise
        
        if strcmp( mode, 'batch' )
            setup.FileInput = 'mp2.mat';
        else
            setup.FileInput = mode;  
            mode = 'batch';
        end
        
        setup.Log2Screen = false;
        setup.Plot2Screen = false;
        
        %load( setup.FileInput );
    
        
end

% Set some things properly
setup.Mode = mode;
if nargin == 2
    setup.Standard = standard;
end


% standard plots
%
if nargin == 3  
    setup = setPeriod( setup, time_period );
else  
    setup = setPeriod( setup, 'Eruption' );
end

% Write run info to file and screen
writeSetup( setup );


if nargin >= 2
    
    plotStandard( setup, standard );
    
end
    
% Write finish info to file and screen
writeFinish( setup );