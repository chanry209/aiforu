% �������ֻҪ������ȡͼ���HOG����
% ��νHOG����������Histogram of gradient
% ����ͼ�����ݶȵ�ֱ��ͼ
% ��������ͳ��ͼ�����ݶȷ�ֵ����һ����ֵ���ݶȷ���
% ����ͼ���������ϵ��ݶȷ���Ҳ�ȼ��ڱ�Ե�ķ���

function HOG = getHOG(rgb)

hsv = rgb2hsv(rgb);
v = hsv(:,:,3);                                                             %��ȡͼ���V������hsvɫ�ʿռ䣩
N = numel(v);
fx = fspecial('sobel');                                                     %���ɼ����ݶȵ�ģ��
fy = fx';
dx = imfilter(v,fx,'replicate');                            
dy = imfilter(v,fy,'replicate');                                            %�ֱ����ͼ����x��y�����ϵĵ���
dx(dy<0) = dx(dy<0)*-1;                                                     %����ݶȴ��ڵ�3��4������ȡ�������ݶȷ���������0~pi֮�䣩
d = sqrt(dx.*dx + dy.*dy);                                                  %�����ݶȵķ�ֵ
angle = acos(dx./d);                                                        %�����ݶȵļн�
[h w] = size(d);
d = d > (max(max(d)) / 10);                                                 
angle = angle(d);                                                           %ѡȡ�ݶȷ�ֵ������ֵ������
HOG = hist(reshape(angle,[1 numel(angle)]),18)./N;                          %ͳ����Щ�������ݶȵ�ֱ��ͼ