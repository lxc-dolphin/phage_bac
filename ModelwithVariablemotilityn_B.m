function out = model
%
% ModelwithVariablemotilityn_B.m
%
% Model exported on Apr 17 2017, 18:49 by COMSOL 5.2.1.262.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('D:\Li_xc\comsol_Li_xc\Comsol with matlab\4_17_2017 with different assumptions');

model.label('Model with Variable motility(n_B).mph');

model.comments(['Untitled\n\n']);

model.baseSystem('none');

model.param.set('Delta_a', '500[um]', '"""thickness of the soft agar"""');
model.param.set('Dn', '9000000[um^2/h]', '"""diffusion constant of nutrient"""');
model.param.set('Dp', '0[um^2/h]', '"""phage diffusion constant"""');
model.param.set('Db', '1000000[um^2/h]', '"""bateria diffusion constant from lingchong"""');
model.param.set('K', 'n0/5', '"""Michaelis-Menten constant for Monod growth law"""');
model.param.set('eta', '80000[1/h/um]', '"""phage adsorption rate"""');
model.param.set('gmax', '(0.55)[1/h]', '"""maximal growth rate"""');
model.param.set('Keta', '500*B0/2', '""');
model.param.set('Ketap', '1000*P0/2', '""');
model.param.set('beta', '50', '"""phage burst size"""');
model.param.set('n0', '1.5[1/um^2]', '"""initial nutrient concn"""');
model.param.set('B0', '1[1/um^2]', '"""initial baterial concn"""');
model.param.set('P0', '0.1[1/um^2]', '"""initial phage concn"""');
model.param.set('alpha_tax', 'Db', '"""chemotactic term"""');
model.param.set('Ktax', '0.5[1/um^2]', '""""""');
model.param.set('Klysis', '1[1/h]', '""""""');
model.param.set('eta_dim', 'eta/Delta_a/Klysis/B0', '""');
model.param.set('Kn_dim', 'K/B0', '""');
model.param.set('gmax_dim', 'gmax/Klysis', '""');
model.param.set('Ktax_dim', 'Ktax/B0', '""');
model.param.set('alpha_taxdim', 'alpha_tax/Db', '""');
model.param.set('Keta_dim', 'Keta/B0', '""');
model.param.set('Ketap_dim', 'Ketap/B0', '""');
model.param.set('Kdb', '70[1/um^2]', '""');
model.param.set('Kdb_dim', 'Kdb/B0', '""');
model.param.set('Ketad', '10*Db/1', '""');
model.param.set('Ketad_dim', 'Ketad/Db', '""');
model.param.set('sigma_b', '3000[um]', '""');
model.param.set('sigma_bdim', 'sigma_b*(Klysis/Db)^0.5', '""');
model.param.set('ratio_n', '0.2', '""');
model.param.set('dis', '0.0205', '""');

model.modelNode.create('comp1');

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').repairTolType('relative');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '100000*(Klysis/Db)^0.5');
model.geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.geom('geom1').run;

model.view.create('view2', 3);

model.physics.create('g', 'GeneralFormPDE', 'geom1');
model.physics('g').field('dimensionless').component({'B' 'L' 'P' 'n'});

model.mesh('mesh1').autoMeshSize(1);

model.view('view1').axis.set('abstractviewrratio', '0.05000000074505806');
model.view('view1').axis.set('abstractviewlratio', '-0.05000000074505806');
model.view('view1').axis.set('abstractviewxscale', '0.2968961000442505');
model.view('view1').axis.set('abstractviewbratio', '-0.15762481093406677');
model.view('view1').axis.set('xmax', '246.95721435546875');
model.view('view1').axis.set('xmin', '-246.95721435546875');
model.view('view1').axis.set('abstractviewyscale', '0.2968960702419281');
model.view('view1').axis.set('ymax', '104.99999237060547');
model.view('view1').axis.set('ymin', '-104.99999237060547');
model.view('view1').axis.set('abstractviewtratio', '0.15762481093406677');

model.physics('g').prop('Units').set('DependentVariableQuantity', 'none');
model.physics('g').prop('Units').set('CustomDependentVariableUnit', '1');
model.physics('g').prop('Units').set('CustomSourceTermUnit', '1/s');
model.physics('g').feature('gfeq1').set('f', {'gmax_dim*n/(n+Kn_dim)*max(B,0)-eta_dim*P/(P+Ketap_dim)*max(B,0)/(max(B,0)+Keta_dim)'; 'eta_dim*P/(P+Ketap_dim)*max(B,0)/(max(B,0)+Keta_dim)-max(L,0)'; '-eta_dim*P/(P+Ketap_dim)*max(B,0)/(max(B,0)+Keta_dim)+beta*max(L,0)'; '-0.05*gmax_dim*n/(n+Kn_dim)*max(B,0)-0.05*gmax_dim*n/(n+Kn_dim)*max(L,0)'});
model.physics('g').feature('gfeq1').set('Ga', {'((-alpha_taxdim*(n/(n+Ktax_dim))*(Kdb_dim)/(B+L+Kdb_dim))*Bx+1*alpha_taxdim*(Kdb_dim)/(B+L+Kdb_dim)*(max(B,0)*Ktax_dim/(Ktax_dim+n)^2*nx))+alpha_taxdim*(n/(n+Ktax_dim))*((B)*Kdb_dim/(Kdb_dim+B+L)^2*Bx)' '((-alpha_taxdim*(n/(n+Ktax_dim))*(Kdb_dim)/(B+L+Kdb_dim))*By+1*alpha_taxdim*(Kdb_dim)/(B+L+Kdb_dim)*(max(B,0)*Ktax_dim/(Ktax_dim+n)^2*ny))+alpha_taxdim*(n/(n+Ktax_dim))*((B)*Kdb_dim/(Kdb_dim+B+L)^2*By)'; '((-alpha_taxdim*(n/(n+Ktax_dim))*(Kdb_dim)/(B+L+Kdb_dim))*Lx+1*alpha_taxdim*(Kdb_dim)/(B+L+Kdb_dim)*(max(L,0)*Ktax_dim/(Ktax_dim+n)^2*nx))+alpha_taxdim*(n/(n+Ktax_dim))*((L)*Kdb_dim/(Kdb_dim+B+L)^2*Lx)' '((-alpha_taxdim*(n/(n+Ktax_dim))*(Kdb_dim)/(B+L+Kdb_dim))*Ly+1*alpha_taxdim*(Kdb_dim)/(B+L+Kdb_dim)*(max(L,0)*Ktax_dim/(Ktax_dim+n)^2*ny))+alpha_taxdim*(n/(n+Ktax_dim))*((L)*Kdb_dim/(Kdb_dim+B+L)^2*Ly)'; '-Dp/Db*Px' '-Dp/Db*Py'; '-Dn/Db*nx' '-Dn/Db*ny'});
model.physics('g').feature('init1').set('B', 'B0/B0*exp(-(x^2+y^2)/(2*(0.01*1000000*(Klysis/Db)^0.5)^2))*((x^2+y^2)^(0.5)<sigma_bdim)');
model.physics('g').feature('init1').set('P', 'P0/B0*exp(-((x+dis*1000000*(Klysis/Db)^0.5)^2+y^2)/(2*(0.005*1000000*(Klysis/Db)^0.5)^2))*(((x+dis*1000000*(Klysis/Db)^0.5)^2+y^2)^0.5<sigma_bdim/2)');
model.physics('g').feature('init1').set('n', 'n0/B0-n0/B0/5*exp(-(x^2+y^2)/(2*(sigma_bdim)^2))');

model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('time', 'Transient');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').create('ta1', 'TimeAdaption');
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std1');

model.result.create('pg1', 'PlotGroup2D');
model.result.create('pg2', 'PlotGroup2D');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').feature('surf2').create('hght1', 'Height');
model.result('pg2').create('surf1', 'Surface');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result.export.create('img1', 'Image2D');

model.study('std1').feature('time').set('tlist', 'range(0,1*Klysis,100*Klysis)');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').set('clist', {'range(0,1*Klysis,100*Klysis)'});
model.sol('sol1').feature('t1').set('atoludotactive', {'comp1_B' 'off' 'comp1_n' 'off' 'comp1_P' 'off' 'comp1_L' 'off'});
model.sol('sol1').feature('t1').set('maxstepbdfactive', true);
model.sol('sol1').feature('t1').set('tlist', 'range(0,1*Klysis,100*Klysis)');
model.sol('sol1').feature('t1').set('atoludot', {'comp1_B' '1e-3' 'comp1_n' '1e-3' 'comp1_P' '1e-3' 'comp1_L' '1e-3'});
model.sol('sol1').feature('t1').set('minorder', '2');
model.sol('sol1').feature('t1').set('eventtol', '0.001');
model.sol('sol1').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_B' 'global' 'comp1_n' 'global' 'comp1_P' 'global' 'comp1_L' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_B' '1e-3' 'comp1_n' '1e-3' 'comp1_P' '1e-3' 'comp1_L' '1e-3'});
model.sol('sol1').feature('t1').feature('se1').feature('ssDef').set('segvar', {'comp1_B' 'comp1_n' 'comp1_P' 'comp1_L'});
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.L 0 comp1.B 0 comp1.P 0');
model.sol('sol1').feature('t1').feature('ta1').set('tfrac', '0.0001');
model.sol('sol1').feature('t1').feature('ta1').set('tadapmesh', {'mesh2' 'mesh3' 'mesh4' 'mesh5' 'mesh6' 'mesh7' 'mesh8' 'mesh9' 'mesh10' 'mesh11'  ...
'mesh12' 'mesh13' 'mesh14' 'mesh15' 'mesh16' 'mesh17' 'mesh18' 'mesh19' 'mesh20' 'mesh21'  ...
'mesh22' 'mesh23' 'mesh24' 'mesh25' 'mesh26' 'mesh27' 'mesh28' 'mesh29' 'mesh30' 'mesh31'  ...
'mesh32' 'mesh33' 'mesh34' 'mesh35' 'mesh36' 'mesh37' 'mesh38' 'mesh39' 'mesh40' 'mesh41'  ...
'mesh42' 'mesh43' 'mesh44' 'mesh45' 'mesh46' 'mesh47' 'mesh48' 'mesh49' 'mesh50' 'mesh51'  ...
'mesh52' 'mesh53' 'mesh54' 'mesh55' 'mesh56' 'mesh57' 'mesh58' 'mesh59' 'mesh60' 'mesh61'  ...
'mesh62' 'mesh63' 'mesh64' 'mesh65' 'mesh66' 'mesh67' 'mesh68' 'mesh69' 'mesh70' 'mesh71'  ...
'mesh72' 'mesh73' 'mesh74' 'mesh75' 'mesh76' 'mesh77' 'mesh78' 'mesh79' 'mesh80' 'mesh81'  ...
'mesh82' 'mesh83' 'mesh84' 'mesh85' 'mesh86' 'mesh87' 'mesh88' 'mesh89' 'mesh90' 'mesh91'  ...
'mesh92' 'mesh93' 'mesh94' 'mesh95' 'mesh96' 'mesh97' 'mesh98' 'mesh99' 'mesh100' 'mesh101'});
model.sol('sol1').feature('t1').feature('ta1').set('worstpar', '0.1');
model.sol('sol1').feature('t1').feature('ta1').set('ngenlocal', '10');
model.sol('sol1').feature('t1').feature('ta1').set('tfracactive', true);
model.sol('sol1').feature('t1').feature('ta1').set('rmethod', 'regular');
model.sol('sol1').feature('t1').feature('ta1').set('eefunctime', 'sqrt(comp1.Lx^2+comp1.Ly^2)');
model.sol('sol1').feature('t1').feature('ta1').set('rf', '0.001');
model.sol('sol1').feature('t1').feature('ta1').set('samplepts', 'range(0.0,0.01,1.0)');
model.sol('sol1').feature('t1').feature('ta1').set('tadapsol', 'sol2');
model.sol('sol1').feature('t1').feature('ta1').set('elselect', 'worst');
model.sol('sol1').runAll;
model.sol('sol2').label('Refined Mesh Solution 1');
model.sol('sol2').runAll;

model.result('pg1').set('looplevel', {'40'});
model.result('pg1').feature('surf1').set('expr', 'L+B');
model.result('pg1').feature('surf1').set('descr', 'L+B');
model.result('pg1').feature('surf1').set('colortable', 'GrayScale');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').feature('hght1').active(false);
model.result('pg1').feature('surf1').feature('hght1').set('scale', '2.7325582991901394');
model.result('pg1').feature('surf1').feature('hght1').set('scaleactive', false);
model.result('pg1').feature('surf2').active(false);
model.result('pg1').feature('surf2').set('expr', 'P');
model.result('pg1').feature('surf2').set('descr', 'Dependent variable P');
model.result('pg1').feature('surf2').set('resolution', 'normal');
model.result('pg1').feature('surf2').feature('hght1').set('scale', '0.30393544212705914');
model.result('pg1').feature('surf2').feature('hght1').set('scaleactive', false);
model.result('pg2').feature('surf1').set('expr', 'n');
model.result('pg2').feature('surf1').set('descr', 'Dependent variable n');
model.result('pg2').feature('surf1').set('resolution', 'normal');
model.result('pg3').set('looplevel', {'200'});
model.result('pg3').feature('surf1').set('rangecolormin', '10');
model.result('pg3').feature('surf1').set('rangecoloractive', 'on');
model.result('pg3').feature('surf1').set('rangecolormax', '70');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result.export('img1').set('axes', false);
model.result.export('img1').set('imagetype', 'tiff');
model.result.export('img1').set('title', false);
model.result.export('img1').set('options', 'on');
model.result.export('img1').set('tifffilename', 'C:\Users\xiaocli\Desktop\t100.tif');
model.result.export('img1').set('logo', false);
model.result.export('img1').set('alwaysask', true);
model.result.export('img1').set('printunit', 'mm');
model.result.export('img1').set('webunit', 'px');
model.result.export('img1').set('printheight', '90');
model.result.export('img1').set('webheight', '600');
model.result.export('img1').set('printwidth', '120');
model.result.export('img1').set('webwidth', '800');
model.result.export('img1').set('printlockratio', 'off');
model.result.export('img1').set('weblockratio', 'off');
model.result.export('img1').set('printresolution', '300');
model.result.export('img1').set('webresolution', '96');
model.result.export('img1').set('size', 'current');
model.result.export('img1').set('antialias', 'on');
model.result.export('img1').set('zoomextents', 'off');
model.result.export('img1').set('title', 'off');
model.result.export('img1').set('legend', 'on');
model.result.export('img1').set('logo', 'off');
model.result.export('img1').set('options', 'on');
model.result.export('img1').set('fontsize', '9');
model.result.export('img1').set('customcolor', [1 1 1]);
model.result.export('img1').set('background', 'color');
model.result.export('img1').set('axes', 'off');
model.result.export('img1').set('qualitylevel', '92');
model.result.export('img1').set('qualityactive', 'off');
model.result.export('img1').set('imagetype', 'tiff');

out = model;
