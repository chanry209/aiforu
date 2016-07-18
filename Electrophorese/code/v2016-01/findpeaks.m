function p=findpeaks(curve,res,seuild2)
    p=find(curve(2:end-1)<=curve(3:end) & curve(2:end-1)<curve(1:end-2) )+1;
    try
        dt=round(res/40);
        d2=(curve(p-dt)+curve(p+dt)-2*curve(p))*40*40;
        p=p(d2>seuild2);
        disp(d2);
    catch
    end
end