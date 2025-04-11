function ret = headless()
%
% Returns True if running headless
%
% Rod Stewart, 2023-08-02

if usejava('desktop')
    ret = false;
else
    ret = true;
end
