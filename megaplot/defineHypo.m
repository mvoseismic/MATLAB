function Hypo = defineHypo()
%
% Defines and initialises a Hypo structure
%
% R.C. Stewart, 26-Feb-2020

Hypo.datim = NaN;           % Date/time of file or event

Hypo.located = 0;           % 1 if located

Hypo.otime = NaN;           % Date/time of event
Hypo.lat = NaN;             % Latitude
Hypo.lon = NaN;             % Longitude
Hypo.dep = NaN;             % Depth
Hypo.depRef = ' ';          % Depth reference: s = sea level, v='SHV ref';
Hypo.locAgency = '   ';     % Location agency

Hypo.mag = NaN;             % Magnitude
Hypo.magType = '  ';        % Magnitude type
Hypo.magAgency = '   ';     % Magnitude agency
Hypo.moment = NaN;          % Seismic moment

Hypo.rms = NaN;             % RMS error
Hypo.gap = NaN;             % Largest angular gap between station azimuths
Hypo.errOtime = NaN;        % Error in origin time
Hypo.errLat = NaN;          % Error in latitude
Hypo.errLon = NaN;          % Error in longitude
Hypo.errDep = NaN;          % Error in depth
Hypo.covXY = NaN;
Hypo.covXZ = NaN;
Hypo.covYZ = NaN;
Hypo.nph = NaN;             % Number of phases in location
Hypo.nphP = NaN;            % Number of P phases in location
Hypo.nphS = NaN;            % Number of S phases in location
Hypo.nstaLoc = NaN;         % Number of stations in location
Hypo.nstaMag = NaN;         % Number of stations in magnitude

Hypo.type = ' ';            % Earthquake type (V, L,R,D)
Hypo.volctype = ' ';        % Volcanic earthquake type (MVO defs)

Hypo.isInString = 0;        % 1 if member of a string

Hypo.felt = '';             % Felt information

Hypo.comment = '';          % Comments