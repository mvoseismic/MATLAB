function Vlines = vlinesPhases( labels )
%
% Sets Vline structure for phases of eruption
%
% R.C. Stewart, 9-Jan-2020

iline = 0;

for iphase = 1:10
    
    switch iphase
        case 1
            wanted = 'begPhase1';
            label = 'Phase 1';
        case 2
            wanted = 'begPause1';
            label = '';
        case 3
            wanted = 'begPhase2';
            label = 'Phase 2';
        case 4
            wanted = 'begPause2';
            label = '';
        case 5
            wanted = 'begPhase3';
            label = 'Phase 3';
        case 6
            wanted = 'begPause3';
            label = '';
        case 7
            wanted = 'begPhase4';
            label = 'Phase 4';
        case 8
            wanted = 'begPause4';
            label = '';
        case 9
            wanted = 'begPhase5';
            label = 'Phase 5';
        case 10
            wanted = 'begPause5';
            label = '';
    end
    
    Vlines(iphase).datim = dateCommon( wanted );
    Vlines(iphase).style = 'k-';
    Vlines(iphase).width = 1.0;
    Vlines(iphase).labelloc = 80;
    
    if labels && length( label )
        Vlines(iphase).label = label;
        Vlines(iphase).labeloff = 0.5;
        Vlines(iphase).labelsize = 10;
        Vlines(iphase).box = 1;
    end
    
end