function [sbestpos, sbestval] = pso_example_fcn_fopid()

as = 0;
us = 10;
d = 5;
ssize = 10;
w = 0.8;
c1 = 2.5;
c2 = 2.5;
as_nu_lam = 0;
us_nu_lam = 1;


s1 = unifrnd(as,us,[ssize 3]);
s2 = unifrnd(as_nu_lam,us_nu_lam,[ssize 2]);
swarm = [s1 s2];
obj = zeros(ssize,1);

kp = swarm(:,1);
ki = swarm(:,2);
kd = swarm(:,3);


for i=1:ssize    
    obj(i) = cost_fo_fcn(swarm(i,1),swarm(i,2),swarm(i,3),swarm(i,4),swarm(i,5));    
end

velocity = zeros(ssize,d);
pbestpos = swarm;
pbestvalue = obj;
sbestval = min(obj);
idx = find(sbestval == obj);
sbestpos = swarm(idx,:);

iterasyon = 1;
objit = sbestval;

while(iterasyon<=10)

    for i=1:ssize

       velocity(i,:) = (w*velocity(i,:))+(c1*unifrnd(0,1)*(pbestpos(i,:)-swarm(i,:)))+(c2*unifrnd(0,1)*(sbestpos-swarm(i,:)));

    end

    vmax = (us-as)/2;
    vmax_nu_lam = (us_nu_lam-as_nu_lam)/2;

    for i=1:ssize

        for j=1:d

            if (velocity(i,j)>vmax)

                velocity(i,j) = vmax;

            elseif(velocity(i,j)<-vmax)

                velocity(i,j) = -vmax;

            end

        end

    end
    
    for i=1:ssize

        for j=1:d

            if (velocity(i,j)>vmax_nu_lam)

                velocity(i,j) = vmax_nu_lam;

            elseif(velocity(i,j)<-vmax_nu_lam)

                velocity(i,j) = -vmax_nu_lam;

            end

        end

    end
    
    swarm = swarm +velocity;
    
    for i=1:ssize

        for j=1:d

            if (swarm(i,j)>us)

                swarm(i,j) = us;

            elseif(swarm(i,j)<as)

                swarm(i,j) = as;

            end

        end

    end

    for i=1:ssize

        obj(i) = cost_fo_fcn(swarm(i,1),swarm(i,2),swarm(i,3),swarm(i,4),swarm(i,5)); 

    end

    for i=1:ssize

        if(obj(i)<pbestvalue(i))

            pbestvalue(i) = obj(i);
            pbestpos(i,:) = swarm(i,:);

        end

    end

    if(min(obj)<sbestval)

        sbestval = min(obj);
        idx = find(sbestval==obj);
        sbestpos = swarm(idx,:);

    end
    
    iterasyon = iterasyon+1;
    objit(iterasyon) = sbestval;
    
end

for i=1:iterasyon
    
    plot(i,objit(i),'*')
    hold on
    title('FOPID based on PSO algorithm')
end



end