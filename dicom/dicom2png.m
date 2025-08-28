foldername = '.';
outdir = '.';

dicomlist = dir(fullfile(foldername,'*.dcm'));
num_files = numel(dicomlist);
I = cell(num_files, 1);
for cnt = 1 : num_files
    thisfile = fullfile(foldername, dicomlist(cnt).name);
    [~, basename] = fileparts(thisfile);
    outfile = fullfile(outdir, basename + ".png");
    I{cnt} = dicomread(thisfile);
    imwrite(mat2gray(I{cnt}), outfile);
end