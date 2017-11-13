function [param] = VIDOSAT_videodenoising_param(param)
%Function for tuning paramters for VIDOSAT denoising
%
%Note that all input parameters need to be set prior to simulation. 
%This tuning function is just an example settings which we provide, for 
%generating the results in the "VIDOSAT paper". However, the user is
%advised to carefully modify this function, thus choose optimal values  
%for the parameters depending on the specific data or task at hand.

n = param.nSpatial * param.nFrame;
sig = param.sig;
%% multi-pass denoising signal list     -   sig2
if sig <= 8
    sig2 = sig;
elseif sig <= 12
    sig2 = [sig*0.9, sig/3];
elseif sig <= 17
    sig2 = [sig*0.9, sig*0.2, sig*0.1, sig*0.05];
elseif sig <= 50
    sig2 = [sig*0.9, sig*0.2, sig*0.1];
else
    sig2 = [sig*0.9, sig*0.2, sig*0.04, sig*0.03];
end
param.sig2 = sig2;

numPass = size(sig2, 2);
param.numPass = numPass;
param.l0 = 0.01;                                          % regularizer weight, lambda_0
param.maxNumber = 15*n;                                   % mini-batch Size, M

% %% coefficient  -   la
% la = 0.01/sig;

%% initial OCTOBOS   -   transform
D1 = dctmtx(sqrt(param.nSpatial));                              % spatial transform init.
D2 = dctmtx(param.nFrame);                            % temporal transform init.
D0 = kron(kron(D1, D2), D1);
if(det(D0)<0)
    D0(1,:)=-D0(1,:);
end
D = zeros(size(D0, 1), size(D0, 2), numPass);
for i = 1 : numPass
    D(:, :, i) = D0;                                % 3D transform init.
end
param.transform = D;

% param.la = la;
end

