%実行前にpath.xlsx,address.xlsxをインポートして下さい
close all;
img = imread('https://trip-yamagata-japan.com/barrier-free/images/higashine12-0-1.jpg');
f = figure;
imshow(img);
f.OuterPosition = [100 100 700 600];%画像が小さいので大きめに表示、なくてもよい

hold on;
axis on;

dx = address.x(path.A) - address.x(path.B);
dy = address.y(path.A) - address.y(path.B);
Dist = hypot(dx,dy);

%G = graph(address.No(1),address.No(end)); %動作検証用
G = graph(path.A, path.B,Dist);
p = plot(G,'XData',address.x,'YData',address.y);

path1 = shortestpath(G,16,40);
highlight(p,path1,'EdgeColor','g','LineWidth',2);
