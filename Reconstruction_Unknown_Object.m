load('xrays');
theta = 1:15:180;

for i=1:12
    sinogram = [xray0(i,:) ; xray15(i,:); 
        xray30(i,:); xray45(i,:); xray60(i,:); 
        xray75(i,:); xray90(i,:); xray105(i,:); 
        xray120(i,:); xray135(i,:); xray150(i,:); 
        xray165(i,:);];
     I=FBP(sinogram',theta);
     figure
     imshow(I);
end