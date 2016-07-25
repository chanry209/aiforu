%% tableWrtieInExcel
%    Write the Table in Excel
%    str = tableWrtieInExcel(x)
%    str is a string, likes 'A1:C4'
%    x is a table

function [str,columnFinal,rawFinal] = tableWrtieInExcel(x,columnLet,rawNum)
[n,m] = size(x);
rawFinal = str2double(rawNum) + n - 1;
rawFinal = num2str(rawFinal);
span = double(columnLet)+m-1;
columnFinal = char(span);

while span > 90
    num = 65;
    span = span - 26;
    if span<=90
        columnFinal  = strcat(char(num),char(span));
    else
        num = num+1;
    end
end

str = strcat(columnLet,rawNum,':',columnFinal,rawFinal);


