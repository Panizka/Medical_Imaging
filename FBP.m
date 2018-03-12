function I=FBP(sinogram,theta)
    [proj,angles]=size(sinogram);
    n=2*floor(proj/(2*sqrt(2)));
    pad=2^(ceil(log2(proj))+1)-proj;
    step=2/(proj+pad);
    if pad>0
        sino=[sinogram ;zeros(pad,angles)];
    else
        sino=sinogram;
    end
    if min(size(theta))==1
        if angles==max(size(theta))
            I=zeros(n,n);
            % ramp filter
            filter=[0:step:1 1-step:-step:step]';
            % performing the FBP for each angle
            for angle=1:angles
                fsino=real(ifft(fft(sino(:,angle)).*filter));
                fsino2=fsino(1:proj);
                T=imrotate(fsino2*ones(1,2*n),theta(angle)+90,'bilinear');
                [tr,tc]=size(T);
                start_row=ceil((tr-n)/2)+1;
                start_col=ceil((tc-n)/2)+1;
                Temp=T(start_row:start_row+n-1,start_col:start_col+n-1);
                I=I+Temp;
            end
            I=I*pi/(2*angles);
        else
            I=[];
        end
    end
end