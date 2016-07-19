function [traindata] = traindata(Base)

for i = 1:10
traindatas(i).mono = Base(i).mono(1:20000,:);
end
traindata = traindatas;

