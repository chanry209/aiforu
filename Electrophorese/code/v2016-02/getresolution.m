function [xRes,yRes] =getresolution(file_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   The function finds the resolution of the picture
%   it can handle 'jpg' and 'tif' formats
%   the information of the resolution in the 'jpg' file
%   is stored in the 15-16th and in the 17-18th bytes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

info=imfinfo(file_name);
if strcmp(info.Format,'jpg')
    [xRes,yRes]=getjpegresolution(file_name);
	unit='inch';
else if strcmp(info.Format,'tif') || strcmp(info.Format,'png')
        [xRes,yRes,unit]=gettifresolution(info);
    end
end

if strcmp(unit,'meter')
	xRes=xRes/100;
	yRes=yRes/100;
elseif strcmp(unit,'inch')
	xRes=xRes*0.3937008;
	yRes=yRes*0.3937008;
end

function [xRes,yRes] = getjpegresolution(file)
fid=fopen(file);
header=fread(fid,50);
xRes=(header(15)*256)+header(16);
yRes=(header(17)*256)+header(18);
fclose(fid);

function [xRes,yRes,unit] = gettifresolution(info)
xRes=info.XResolution;
yRes=info.YResolution;
unit=info.ResolutionUnit;


