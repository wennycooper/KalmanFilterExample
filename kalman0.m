close all;
clear;

% generate a sin wave with gaussian noise 
Z0=(1:1000);
noise=randn(1,1000)*10;  
Z = 100 * sin(2*3.14*0.002*Z0); % freq = 0.002
Z=Z+noise;

X=[0; 0];
P=[1 0; 0 1];
F=[1 1; 0 1];
Q=[0.0001, 0; 0 0.0001];  % prediction noise wk ~ N(0, Q) 
H=[1 0];
R=5;   % measurement noise vk ~ N(0, R)

figure;
hold on;

for i=1:1000
    X_ = F*X;
    P_ = F*P*F'+Q;
    K = P_*H'/(H*P_*H'+R);
    X = X_ + K*(Z(i)-H*X_);
    P = (eye(2) - K*H)*P_;
    fprintf('i=%d\n', i);
    disp(P);
    plot(i,Z(i),'*');hold on;
    plot(i,X(1),'r*');hold on;
end

