close all;
img = imread('https://trip-yamagata-japan.com/barrier-free/images/higashine12-0-1.jpg');
f = figure;
imshow(img);
f.OuterPosition = [100 100 700 600];%�摜���������̂ő傫�߂ɕ\���@�Ȃ��Ă��悢

hold on;
axis on;

dx = address.x(path.A) - address.x(path.B);
dy = address.y(path.A) - address.y(path.B);
Dist = hypot(dx,dy);
G = graph(path.A, path.B,Dist);
%G = graph(address.No(1),address.No(end));
p = plot(G,'XData',address.x,'YData',address.y);%,'EdgeLabel',G.Edges.Weight);

path1 = shortestpath(G,16,40);
highlight(p,path1,'EdgeColor','g','LineWidth',2);