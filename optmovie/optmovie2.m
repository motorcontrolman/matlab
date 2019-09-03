clear all;
close all;

%% �O���[�o���ϐ��̐錾
global xdata;
global fun;
global vidObj;

%% �T���v���f�[�^�̍쐬�A�v���b�g
xdata = [0:0.01:1];
fun = @(a,b,x) tanh(a*x-b) + tanh(b);
ydata = fun(4,0.8,xdata) + ( rand(size(xdata)) - 0.5 ) /10;

figure;
subplot(211);
scatter(xdata,ydata);
axis([0 1 0 2]);grid on;
hold on;

%% �r�f�I�쐬�̏���
vidObj = VideoWriter('result2.mp4','MPEG-4');
vidObj.FrameRate = 1/0.1;
open(vidObj);

%% �œK������ċȐ��ߎ�
efun = @(x) sum( ( fun(x(1),x(2),xdata) - ydata ).^2 );
options = optimset('Display','iter','OutputFcn',@outfun);

x0 = [0 0];
bestx = fminsearch(efun , x0, options);

%% �r�f�I�쐬�̊���
close(vidObj);

function stop = outfun(x, optimValues, state)

%% �O���[�o���ϐ��̐錾
    global xdata;
    global fun;
    global vidObj;

 %% �i���ϐ��̒�`
    persistent p;
    persistent t;
 
 %% �o�͊֐��̒��g
    stop = false;
    delete(p);delete(t); %�ߎ��Ȑ��A�e�L�X�g�f�[�^��}����폜
    
    y = fun(x(1),x(2),xdata); %�ߎ��Ȑ��̍쐬�A�v���b�g
    subplot(211);
    p = plot(xdata,y,'-r');
    
    str = ['iter=' num2str(optimValues.iteration) newline];
    str = [str 'a=' num2str(x(1)) newline];
    str = [str 'b=' num2str(x(2))];
    t = text(0.7,0.4, str,'FontSize',14); %�e�L�X�g�f�[�^�̍쐬
    
    subplot(212);
    plot(optimValues.iteration,optimValues.fval,'.r','MarkerSize',10);
    hold on;
    grid on;
    axis([0 80 0 200]);
    writeVideo(vidObj, getframe(gcf));
    drawnow
end