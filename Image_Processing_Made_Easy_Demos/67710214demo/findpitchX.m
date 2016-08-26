% ����������ڹ���ͼ����x�����ϵ���б�̶ȣ����������任�ľ���
% ����    e����Եͼ��
%         rect����Եͼ�������ֵİ�Χ��
%         paramY�� y�������б�̶ȣ���ax+by = 1 ��ֱ�߱�ʾ��paramY = [a b]
% A                                           B
% _____________________________________________
% |\_______________________                   |
% | \                      ___________________| j
% |  \                                        |
% |   \                                       |
% |____\______________________________________|
% C    E                                        D
% ͼ�У�AEֱ�߱�ʾy������б�̶ȣ�Ajֱ�߱�ʾx������б�̶�
function [aff param] = findpitchX(e, rect, paramY)
[h w]= size(e);
a = paramY(1);
b = paramY(2);
bestj = zeros(length(rect),1);
maxh = max([rect.y1] - [rect.y]);
maxw = max([rect.x1] - [rect.x]);                                           %�����Χ������ߴ�
mh = floor(maxh/2);
for i = 1:length(rect)
    idx = find(e(rect(i).y:rect(i).y1,rect(i).x:rect(i).x1));
    if (size(idx,1) > size(idx,2))
        idx = idx';
    end
    h = rect(i).y1 - rect(i).y + 1;                                         %���δ�С
    y = mod(idx, h);
    x = floor(idx / h) + 1;                                                 %x��y�����б�Ե�������
    xx = -(maxh)*b/a;                                                       %xx��E�������
    l = zeros(1,2*mh + 1);
    for j = -mh:mh                                                          %���Բ�ͬ��x������б�̶ȣ����� ��0��0�� �� ��w��j����ֱ����Ϊx��
        aff = [maxw 0;0 maxh]*inv([maxw xx;j maxh]);                        %�����ȥ��б�����Ӧ�ķ������
        x_ = round(aff(1,:)*[x;y]);                                         %�����Ե���ڸ���affУ���������
        y_ = round(aff(2,:)*[x;y]);
        it = find(y_ == min(y_));                                           %�ҳ�У�����Եͼ��������ߺ�������
        ib = find(y_ == max(y_));
        l(j + 1 + mh) = max(max(x_(it)) - min(x_(it)),max(x_(ib)) - min(x_(ib)));  %����У�����Եͼ��������ϣ��б�Ե�����ص������룬���������������˵��������߸պ��������������У������������ȷ�ķ���
    end
    [ml bj] = max(l);
    bestj(i) = bj - mh - 1;
end
aff = [maxw 0;0 maxh]*inv([maxw xx;mean(bestj) maxh]);                      %����������
param = [mean(bestj) -maxw];
param = param/(param*[rect(1).x;rect(1).y]);                                %����x������б��ֱ�߲�����