function F = cost_fo_fcn(Kp,Ki,Kd,lam,nu)

Gc = CFE_TF([1 0],[lam,0],[Kd Kp Ki],[lam+nu lam 0]);
Gp = tf(61.6326,[1 35.0427 0]);

T = (Gc*Gp)/(1+(Gc*Gp));

S=stepinfo(T,'RiseTimeLimits',[0.1 0.9]);
tr=S.RiseTime;
ts=S.SettlingTime;
Mp=S.Overshoot;
Ess=1/(1+dcgain(T));
F=(1-exp(-0.7298))*(Mp+Ess)+exp(-0.7298)*(ts-tr);

end