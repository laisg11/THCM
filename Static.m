%�����ӿռ�ĳ�����Ԫ��
clear all
clc
addpath('lib')
addpath('Data')
%�������
load Data
Nodes=[1,5,45,41,901,905,945,941];
scale=1;
Omiga=5;

%�������
[Kr,Mr]=MatrixTransform(M_Fine,K_Fine,Nodes,Omiga);
%��������

%load Reducted
K=Kr;

%����߽����� 1~4�ڵ�̶� ��һ��
for i=1:12
    K(i,:)=0;
    K(:,i)=0;
    K(i,i)=1;
end
% ���߽�����
P(24)=0;
P(4*3+3)=-10000;
P(5*3+3)=-10000;
U=P*inv(K);

% ����
a=20/2;h=40;b=100;
temp=[ 0   -a   h;...
       0    a   h;...
       0    a   0;...
       0   -a   0;...
       b   -a   h;...
       b    a   h;...
       b    a   0;...
       b   -a   0;];
% for i=1:8
%     Nodes(i).loc=temp(i,:);
%     Nodes(i).dis=U(i*3-2:i*3);
% end
% for i=1:8
%     Nodes(i+8).loc=temp(i,:)+[0,0,100];
%     Nodes(i+8).dis=U(i*3-2+24:i*3+24);
% end
PostPlot(temp,U,scale)