% ��̬������� Newmark
% ��ʼ������
clear all
clc
disp('NEWMARK-��  ��̬ģ��')
addpath('Data')
addpath('lib')
load ElCentro  % mm/s/s
load Reducted  % ���� Kr Mr

% ���ò���
Nnode=8;            %�ڵ���
DoN=3;              %�ڵ����ɶ�
ElCentro_dt=0.02;   %�غ�ʱ������
PLoad=[6,5];        %���ؽ����
PDof=3;             %���ط���
scale=9800;            %���طŴ�ϵ��
dt=0.02;gama=0.5;beta=1/4;

%1 ��ʼ������
U(Nnode*DoN,1)=0;    %��ʼ��λ��
U1(Nnode*DoN,1)=0;   %��ʼ���ٶ�
U2(Nnode*DoN,1)=0;   %��ʼ�����ٶ�

ElCentro=ElCentro*scale;

a(8)=1/beta/dt/dt;
a(1)=gama/beta/dt;
a(2)=1/beta/dt;
a(3)=1/2/beta-1;
a(4)=gama/beta-1;
a(5)=dt/2*(gama/beta-2);
a(6)=dt*(1-gama);
a(7)=gama*dt;

K=Kr;M=Mr;
C=10000*K+150*M;

%2 �γɵ�Ч�ն���
Ke=K+a(8)*M+a(1)*C;
%3 ������һʱ�̵ĵ�Ч�غ�
Ua(1:Nnode*DoN)=0;
Ub(1:Nnode*DoN)=0;
P(1:Nnode*DoN)=0;
for i=0:dt:30-2*dt
    t=i/dt+1;    
%    Ua(PLoad(1)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1);
%    Ua(PLoad(2)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1);
    
%    Ub(PLoad(1)*3-3+PDof)=U2(PLoad(1)*3-3+PDof,round(t));
%    Ub(PLoad(2)*3-3+PDof)=U2(PLoad(2)*3-3+PDof,round(t));

%    P=M*(Ua-Ub)';
    P(PLoad(1)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1);   
    P(PLoad(2)*3-3+PDof)=ElCentro(round(i/ElCentro_dt)+1); 

    Pe=P'+M*(a(8)*U(:,round(t))+a(2)*U1(:,round(t))+a(3)*U2(:,round(t)))+C*(a(1)*U(:,round(t))+a(4)*U1(:,round(t))+a(5)*U2(:,round(t)));
    %4 ������һʱ��λ���ٶȼ��ٶ�
    U(:,round(t+1))=Ke\Pe;
    U2(:,round(t+1))=a(8)*(U(:,round(t+1))-U(:,round(t)))-a(2)*U1(:,round(t))-a(3)*U2(:,round(t));
    U1(:,round(t+1))=U1(:,round(t))+a(6)*U2(:,round(t))+a(7)*U2(:,round(t+1));
end

Xdata=0:dt:30-dt;
Ydata=U(21,:);
plot(Xdata,Ydata)





