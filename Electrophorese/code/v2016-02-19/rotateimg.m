function B=rotateimg(A,angle,resizemode)
    if(resizemode==0)
        B=zeros(size(A));
    end
    
    syA=size(A,1);syB=size(B,1);
    cB=size(B)/2;cB=cB([2 1]);
    cA=size(A)/2;cB=cB([2 1]);
    for i=1:size(B,1)
        for j=1:size(B,2)
            pB=[j-cB(1) syA+1-i-cB(2)];
            ar=atan(pB(2)/pB(1));
            if(pB(1)<0)
                ar=ar+pi;
            end
            ar=ar+angle;
            pA=norm(pB)*[cos(ar) sin(ar)];
            
            I=round(syA+1-pA(2)-cA(2));
            J=round(pA(1)+cA(1));
            
            if(I<=size(A,1) && J<=size(B,1) && I>0 && J>0)
                B(i,j,:)=A(I,J,:);
            end
        end
    end

end