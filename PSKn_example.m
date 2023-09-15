% simulation for updated model

clear all

model = mphopen('Model with Variable motility(n_B) and Variable lysis rate - Parameter Sweep test.mph');
%%%%%%% modifications starts 
model.param.set('lambda', '0.2', '""');
model.param.set('n0','5.5[1/um^2]', '""');
model.param.set('alpha_tax','2*Db','""');
model.physics('g').feature('gfeq1').set('f', {'gmax_dim*n/(n+Kn_dim)*max(B,0)-eta_dim*P/(1*Ketap_dim)*max(B,0)/(1.8*Keta_dim)';
                                              'eta_dim*P/(1*Ketap_dim)*max(B,0)/(1.8*Keta_dim)-max(L,0)*(n)/n0'; 
                                              '-eta_dim*P/(1*Ketap_dim)*max(B,0)/(1.8*Keta_dim)+beta*max(L,0)*(n)/n0'; 
                                              '-lambda*gmax_dim*n/(n+Kn_dim)*max(B,0)-lambda*gmax_dim*n/(n+Kn_dim)*max(L,0)'});
%%%%%%% modifications ends 

% parameter1 -->Kn

parameter1 = {
               'n0/10';
               'n0/5';
               'n0/2';
               'n0';
               '10*n0';
               '50*n0';
               '100*n0';
               'n0/20'
             };

parameter1name = 'Kn';

addre = pwd;

pg2 = model.result('pg2');

pg2.feature('surf1').set('expr','(B+L)*B0');
pg2.feature('surf1').set('descr','B+L');
pg2.feature('surf1').set('colortable','GrayScale');
pg2.feature('surf1').set('rangecoloractive','on');
pg2.feature('surf1').set('rangecolormin','10');
pg2.feature('surf1').set('rangecolormax','70');


size1 = size(parameter1);
length1 = size1(1);

ReName = 'Kn';
mkdir(ReName);

for i = length1:length1
     
    chapara = char(parameter1(i));
    
%   model.physics('g').feature('init1').set('n',chapara);
    
    model.param.set('K', chapara , '""');
    model.sol('sol1').runAll;
    
    pg2.set('looplevel','91');
    pg2.set('title','Bacteria');
    figure(i);
    mphplot(model,'pg2','rangenum',1);
    saveas(gcf,[addre,'\' ReName '\',parameter1name num2str(i),'.jpg']);
    filename = ['\' ReName '\',parameter1name num2str(i)];
    mphsave(model,filename);
    fprintf('finish parameter %s  %s\n',string(parameter1name),string(parameter1(i)));
    
end