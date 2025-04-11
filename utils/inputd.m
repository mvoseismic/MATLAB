function value = inputd( prompt, type, default )
%
% Adds the default bvalue to input
%
% types:
%   s    string
%   l    logical
%   i    integer
%   r    real
%   f    real
%   d    datestring yyyymmdd
%
% Rod Stewart, 2008-12-29

switch type
    case 's'
        prompt = sprintf( '%s [%s]: ', prompt, default );
    case 'l'
        prompt = sprintf( '%s [%s]: ', prompt, default );
    case 'i'
        prompt = sprintf( '%s [%i]: ', prompt, default );
    case { 'r', 'f' }
        prompt = sprintf( '%s [%f]: ', prompt, default );
    case 'd'
        prompt = sprintf( '%s (yyyymmdd) [%s]: ', prompt, default );
end
   
switch type
    case { 's', 'l', 'd' }
        it = input(prompt, 's');
    otherwise
        it = input(prompt);
end

if isempty( it )
    it = default;
end

switch type
    case 's'
        value = it;
    case 'l'
        if strcmpi( it, 'Y' )
            value = true;
        else
            value = false;
        end
    case 'i'           
        value = int32( it );
    case 'r'           
        value = it;
    case 'd' 
        if strcmp( it, 'today' )
            value = floor( now+4/24 );
        elseif strcmp( it, 'now' );
            value = now+4/24;
        else
            value = datenum( it, 'yyyymmdd' );
        end
end

