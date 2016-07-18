function squareError = errorMeasure(lambda,x,y)
A =  [exp(-(x-lambda(1)).^2/lambda(2)) exp(-(x-lambda(3)).^2/lambda(4))];
a = pinv(A)*y;
y2 = a(1)*exp(-(x-lambda(1)).^2/lambda(2))+ a(2)*exp(-(x-lambda(3)).^2/lambda(4));
squareError = sum((y-y2).^2);