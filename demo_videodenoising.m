clear;
addpath('vidosat_tool');
addpath('Common');
%%% loading demo data %%%
load('demo_data/gsalesman_sig10.mat');  
data.noisy = noisy;
data.oracle = 'demo_data/gsalesman.avi';

%%% VIDOSAT parameters %%%
param.nSpatial = 64;
param.stride = 1;
param.sig = 10;           
param.nFrame = 8;
% param.nFrame = 16;
param.strideTemporal = 1;
% param.isTesting = true;
%%% VIDOSAT video denoising %%%
[Xr, outputParam] = VIDOSAT_videodenoising(data, param);




%%%%%%%% visualization of the generated data %%%%%%%%
% decomment the corresponding visualizations that you want

% %%% play the noisy video frames %%%
% figure; implay(uint8(data.noisy), []);
% %%% play the denoised video frames %%%
% figure; implay(uint8(Xr), []);

% %%% plot frame-by-frame PSNR %%%
% figure; 
% framePSNR = outputParam.framePSNR;
% numFrame = size(framePSNR, 2);
% plot(1:numFrame, framePSNR, '-r', 'MarkerSize',10,'LineWidth',3.2);
% xlim([1 numFrame]);
% set(gca,'FontSize',24);
% xlabel('Frame Number');
% ylabel('Denoised PSNR');
% legend(['VIDOLSAT, n = ', num2str(param.nSpatial * param.nFrame)]);
% grid on;
