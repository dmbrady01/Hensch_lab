function createlatencyfigure(cdata1, facevertexcdata1, faces1, vertices1, xdata1, ydata1, vertexnormals1)
%CREATEFIGURE(CDATA1,FACEVERTEXCDATA1,FACES1,VERTICES1,XDATA1,YDATA1,VERTEXNORMALS1)
%  CDATA1:  patch cdata
%  FACEVERTEXCDATA1:  patch facevertexcdata
%  FACES1:  patch faces
%  VERTICES1:  patch vertices
%  XDATA1:  patch xdata
%  YDATA1:  patch ydata
%  VERTEXNORMALS1:  patch vertexnormals
 
%  Auto-generated by MATLAB on 12-Oct-2010 00:48:18
 
% Create figure
figure1 = figure;
 
% Create axes
axes1 = axes(...
  'CameraUpVector',[0 1 0],...
  'CLim',[1 2],...
  'Parent',figure1);
axis([-100 500 0 10]);
box('on');
 
% Create patch
patch1 = patch(...
  'CData',cdata1,...
  'FaceVertexCData',facevertexcdata1,...
  'FaceColor','flat',...
  'Faces',faces1,...
  'Vertices',vertices1,...
  'XData',xdata1,...
  'YData',ydata1,...
  'VertexNormals',vertexnormals1,...
  'Parent',axes1);
 