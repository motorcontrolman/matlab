clear all;
close all;

%% グローバル変数の宣言
global xdata;
global fun;
global vidObj;

%% サンプルデータの作成、プロット
xdata = [0:0.01:1];
fun = @(a,b,x) tanh(a*x-b) + tanh(b);
ydata = fun(4,0.8,xdata) + ( rand(size(xdata)) - 0.5 ) /10;

figure;
subplot(211);
scatter(xdata,ydata);
axis([0 1 0 2]);grid on;
hold on;

%% ビデオ作成の準備
vidObj = VideoWriter('result2.mp4','MPEG-4');
vidObj.FrameRate = 1/0.1;
open(vidObj);

%% 最適化を介して曲線近似
efun = @(x) sum( ( fun(x(1),x(2),xdata) - ydata ).^2 );
options = optimset('Display','iter','OutputFcn',@outfun);

x0 = [0 0];
bestx = fminsearch(efun , x0, options);

%% ビデオ作成の完了
close(vidObj);

function stop = outfun(x, optimValues, state)

%% グローバル変数の宣言
    global xdata;
    global fun;
    global vidObj;

 %% 永続変数の定義
    persistent p;
    persistent t;
 
 %% 出力関数の中身
    stop = false;
    delete(p);delete(t); %近似曲線、テキストデータを図から削除
    
    y = fun(x(1),x(2),xdata); %近似曲線の作成、プロット
    subplot(211);
    p = plot(xdata,y,'-r');
    
    str = ['iter=' num2str(optimValues.iteration) newline];
    str = [str 'a=' num2str(x(1)) newline];
    str = [str 'b=' num2str(x(2))];
    t = text(0.7,0.4, str,'FontSize',14); %テキストデータの作成
    
    subplot(212);
    plot(optimValues.iteration,optimValues.fval,'.r','MarkerSize',10);
    hold on;
    grid on;
    axis([0 80 0 200]);
    writeVideo(vidObj, getframe(gcf));
    drawnow
end