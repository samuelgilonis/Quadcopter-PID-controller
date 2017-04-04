global A
% imshow('AUS.jpg')
A.aus = imread('AUS.jpg');
axis equal
% [x,y,z] = sphere(50);
A.t1=-250:1:249;
A.c1=-250:1:249;
A.x1=[];
A.y1=[];
A.z1=zeros(500,500);
A.b=0;
while A.b<500;
A.x1=[A.x1;A.c1];
A.y1=[A.y1;A.t1];
A.b = A.b+1;
end
A.y1=A.y1';
A.props.AmbientStrength = 0.1;
A.props.DiffuseStrength = 1;
A.props.SpecularColorReflectance = .5;
A.props.SpecularExponent = 20;
A.props.SpecularStrength = 1;
A.props.FaceColor= 'texture';
A.props.EdgeColor = 'none';
A.props.FaceLighting = 'phong';
A.props.Cdata = A.aus;
surface(A.x1,A.y1,A.z1,A.props);