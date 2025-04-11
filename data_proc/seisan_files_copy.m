function seisan_files_copy( start, stop, dir_seisan, dir_local )
%
% Returns a structure with file names of seisan files for a certain
% time period. Also copies all these files to a local.
% Version 2 works at both SRC and MVO and uses environment variables
%
% Rod Stewart, 2009-12-09

files_seisan = seisan_files_find( start, stop, dir_seisan );

nfiles = length( files_seisan );

for ii = 1:nfiles
    fname = files_seisan(ii).name;
    fname = fullfile( dir_seisan, fname );
    copyfile( fname, dir_local );
end
  
progress = [ num2str(nfiles) ' copied to ' dir_local ];

m_progress( mfilename, 'I', progress );    

return;

