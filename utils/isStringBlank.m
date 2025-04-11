function isblank = isStringBlank( instring )
%
% Tests is a srreing is blank
%
% R.C. Stewart, 7-Jan-2019

blstring = blanks( length( instring ) );

isblank = strcmp( instring, blstring );

