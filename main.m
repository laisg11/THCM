%�����ӿռ�ĳ�����Ԫ�� 20�ڵ�
clear all
clc
addpath('lib')
addpath('Data')
%�������
load Data
Nodes=[1,5,45,41,226,230,270,266,451,455,495,491,676,680,720,716,901,905,945,941];
scale=1;
Omiga=5;

%�������
[Kr,Mr]=MatrixTransform(M_Fine,K_Fine,Nodes,Omiga);
%��������

fileID = fopen('Kr.for','w');
fprintf(fileID,'     # %8.5e,%8.5e,%8.5e,%8.5e,\n',Kr);
fclose(fileID);

fileID = fopen('Mr.for','w');
fprintf(fileID,'     # %8.5e,%8.5e,%8.5e,%8.5e,\n',Mr);
fclose(fileID);

save MTX_r Kr Mr