function Gc = CFE_TF(a,na,b,nb)
% a = [1 0]
% na = [lam,0]
% b = [Kd Kp Ki]
% nb = [lam+nu lam 0]
% fotf([1 0],[lam,0],[Kd Kp Ki],[lam+nu lam 0]);

T = fotf(a,na,b,nb);

for i=1:1:length(T.nb)
    
    num(i) = CFE(1,T.nb(i));
    numfcn(i) = T.b(i)*num(i);

end

for i=1:1:length(T.na)
    
    den(i) = CFE(1,T.na(i));
    denfcn(i) = T.a(i)*den(i);

end

numtf = sum(numfcn);
% pretty(vpa(numtf))
dentf = sum(denfcn);
% pretty(vpa(dentf))
tf = numtf/dentf;
pretty(vpa(tf))
Gc = syms2tf(tf);

end

