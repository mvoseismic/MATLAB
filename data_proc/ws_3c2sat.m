function wout = ws_3c2sat( win )
%
% Takes a waveform structure, assumed to have 3C sets
% and rotates it into SAT space
%
% Rod Stewart, 2010-04-05
%

nsta = length( win );

wout = win;

for ii = 1:3:nsta-2
    
    w3xyz = win(ii:ii+2);
    w3sat = [];
    
    % Find Z, N and E channels
    wz = [];
    wn = [];
    we = [];
    
    for jj = 1:3
        cha = get( w3xyz(jj), 'component' );
        if regexpi(cha, '[A-Z]+z')
            fprintf( 'cha: %s        Z: %d\n', cha, jj );
            wz = get( w3xyz(jj), 'data' );
        elseif regexpi(cha, '[A-Z]+n')
            fprintf( 'cha: %s        N: %d\n', cha, jj );
            wn = get( w3xyz(jj), 'data' );
        elseif regexpi(cha, '[A-Z]+e')
            fprintf( 'cha: %s        E: %d\n', cha, jj );
            we = get( w3xyz(jj), 'data' );
        end
    end
    
    ZNE = [wz',wn',we'];
    
    SAT = zne2sat( ZNE );
    ws = SAT(:,1);
    wa = SAT(:,2);
    wt = SAT(:,3);
    
    w3sat1 = w3xyz(1);
    w3sat1 = set( w3sat1, 'data', ws );
    w3sat = combine( [w3sat w3sat1] );
    w3sat1 = w3xyz(2);
    w3sat1 = set( w3sat1, 'data', wa );
    w3sat = combine( [w3sat w3sat1] );
    w3sat1 = w3xyz(3);
    w3sat1 = set( w3sat1, 'data', wt );
    w3sat = combine( [w3sat w3sat1] );
        
    wout(ii:ii+2) = w3sat;
    
end
    
return
