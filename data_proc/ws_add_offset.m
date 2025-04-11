function wout = ws_add_offset( win, offsets )
%
% Takes a waveform structure and adds offsets to each channel
% Rod Stewart, 2009-06-13
%

nsta = length( win );

if isempty(offsets)
    for ii = 1:nsta
        offsets(ii) = -2.0 * (ii-1);
    end
elseif length(offsets) == 1
    offset = offsets;
    for ii = 1:nsta
        offsets(ii) = offset;
    end
end

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    data = data + offsets(ii);
    wout(ii) = set( wout(ii), 'data', data );
    %p_message = sprintf( 'ista: %d', ii );
    %m_progress( 'ws_add_offset', 'D', p_message );
end

return
