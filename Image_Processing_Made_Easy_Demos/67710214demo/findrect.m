function rect = findrect(e)
[h w] = size(e);                                                            %ͼ��Ĵ�С
v = find(e,1,'first');                                                      %�ҵ�ͼ���е�һ��Ϊ1�ĵ�
rect = [];
lw = 2;                                                                     %�趨���α�Ե�Ĵ�С
while (~isempty(v))
    j = floor(v/h) + 1;
    i = mod(v,h);
    x = j - 1;
    y = i - 1;
    x1 = j + 1;
    y1 = i + 1;                                                             %�趨���εĳ�ʼλ�úʹ�С
    while(x > 0 && y > 0 && x1 < w  && y1 < h && (sum(sum(e(max(y-lw,1):y,x:x1))) > 0 || sum(sum(e(y1:min(y1+lw,h),x:x1)))> 0 || sum(sum(e(y:y1,max(x-lw,1):x)))> 0 || sum(sum(e(y:y1,x1:min(x1+lw,w))))> 0) )
                                                                            %�����εı�Ե�ϻ������ص�ֵ����0��ʱ��
        while(y > lw && sum(sum(e(max(y-lw,1):y,x:x1)))> 0 )                %������������������ص�ֵ����0����������������ƶ�һ�����أ�֪�����������ϵ�����ֵ��Ϊ0
            y = y - 1;
        end
        while(y1 < h - lw && sum(sum(e(y1:min(y1+lw,h),x:x1)))> 0 )         %ͬ�ϣ�Ѱ�Ҿ��ε�����
            y1 = y1 + 1;
        end
        while(x > lw && sum(sum(e(y:y1,max(x-lw,1):x)))> 0)                 %ͬ�ϣ�Ѱ�Ҿ��ε�����
            x = x - 1;
        end
        while(x1 < w - lw && sum(sum(e(y:y1,x1:min(x1+lw,w))))> 0)          %ͬ�ϣ�Ѱ�Ҿ��ε�����
            x1 = x1 + 1;
        end
    end
    if (x1 - x > 5 && y1 - y > 5)                                           %������εĴ�С����5*5
        rect = [rect struct('x',x,'y',y,'x1',x1,'y1',y1)];                  %�����δ洢����
    end
    y = max(y,1);
    y1 = min(y1,h);
    x = max(x,1);
    x1 = min(x1,w);
    e(y:y1,x:x1) = 0;                                                       %��ͼ���Ͼ��θ��ǵ�������0������Ѱ����һ������
    v = find(e,1,'first');                                                  %Ѱ��ͼ���е�һ��ֵΪ1������
end


