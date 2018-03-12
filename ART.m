function [x]=ART(sinogram, theta, x0, iterations, lambda)
    n=length(x0);
    rows=floor(sqrt(n));
    cols=rows;
    midrow=rows/2;
    midcol=cols/2;
    [projs,angles]=size(sinogram);
    midproj=projs/2;
    theta=theta.*(pi/180);
    x=zeros(n,iterations+1);
    x_next=x0;
    x(:,1)=x0;
    thresh = 0.5;
    step = 11;
    for iter=1:iterations
        for index=0:angles-1
            angle = mod(index*step,angles) + 1;
            for proj=1:projs
                A_row=zeros(rows,cols);
                for row=1:rows
                    for col=1:cols
                        if( abs((col-midcol)*cos(theta(angle))+...
                            (rows+1-row-midrow)*sin(theta(angle))+...
                                midproj-proj) < thresh )
                            A_row(row,col)=1;
                        end
                    end
                end
                a_i=reshape(A_row,1,n);
                norm_ai=norm(a_i)^2;
                x_current = x_next;
                if (norm_ai > 0)
                    res=sinogram(proj,angle)-a_i*x_current;
                    x_next=x_current+lambda*(res*a_i')/norm_ai;
                end
            end
        end
        x(:,iter+1)=x_next;
    end
end