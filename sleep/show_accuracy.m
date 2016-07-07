clear;
close all

addpath('../Functions/')

% load personal model results
load('results_personal')
acc_personal_all = out.performance(:,1);
load('results_personal_timeonly')
acc_personal_time = out.performance(:,1);
load('results_personal_notime')
acc_personal_sensor = out.performance(:,1);

% load global model results
load('results_global')
acc_global_all = out.performance(:,1);
load('results_global_timeonly')
acc_global_time = out.performance(:,1);
load('results_global_notime')
acc_global_sensor = out.performance(:,1);

figure(1)
n = sqrt(length(acc_personal_all))/1.98;
bar([.9 1.9 2.9],[nanmean(acc_global_sensor),nanmean(acc_global_time),nanmean(acc_global_all)],'barwidth',.2,'facecolor',[.5 .8 1])
hold on
bar([1.1 2.1 3.1],[nanmean(acc_personal_sensor),nanmean(acc_personal_time),nanmean(acc_personal_all)],'barwidth',.2,'facecolor',[.1 .4 .7])
errorbar([.9 1.9 2.9],[nanmean(acc_global_sensor),nanmean(acc_global_time),nanmean(acc_global_all)],[nanstd(acc_global_sensor)/n,nanstd(acc_global_time)/n,nanstd(acc_global_all)/n],'.k',...
    'linewidth',1);
errorbar([1.1 2.1 3.1],[nanmean(acc_personal_sensor),nanmean(acc_personal_time),nanmean(acc_personal_all)],[nanstd(acc_personal_sensor)/n,nanstd(acc_personal_time)/n,nanstd(acc_personal_all)/n],'.k',...
    'linewidth',1);
xlim([0 4])
% ylim([0 .5])
set(gca, 'xtick',[1 2 3],'xticklabel',{'Sensor','Time','Time+Sensors'});
set(gca, 'ygrid', 'on')
box off
ylabel('Classification Accuracy')
legend('Global Models','Personal Models');

figure(2)
[y,x] = hist(acc_personal_all,[.5:.025:1]);
plot(x,y,'color',[.1 .4 .7],'linewidth',2);
hold on;
[y,x] = hist(acc_global_all,[.5:.025:1]);
plot(x,y,'color',[.5 .8 1],'linewidth',2);
xlabel('Classification Accuracy')
ylabel('Number of Subjects')
box off
legend('Personal Models','Global Models','location','northwest');

%% global vs personal models
h = figure(3);
set(h,'position',[520   649   460   400])
plot(acc_global_all, acc_personal_all, '.','markersize',8)
hold on
plot([.5 1],[.5 1])
% axis([.25 1 .25 1])
ylabel('Personal Models Accuracy')
xlabel('Global Models Accuracy')
text(.55,.58,'y = x','rotation',45,'fontweight','bold','fontsize',12,'color',[.7 .3 0])
box off
mycorr(acc_global_all,acc_personal_all,'pearson')
% mdl = fitlm(acc_global_all, acc_personal_all);
% [coefs, ~, latent] = pca([acc_global_all, acc_personal_all]);
% slope = coefs(2,1)/coefs(1,1);
% x = [min(acc_global_all) max(acc_global_all)];
% x1 = nanmean(acc_global_all);
% y1 = nanmean(acc_personal_all);
% plot(x, slope*(x-x1)+y1, '--k', 'linewidth', 1);
% text(min(acc_global_all), slope*(min(acc_global_all)-x1)+y1+.02,'PCA1','rotation',atan(slope)*180/pi,...
%     'fontweight','bold','fontsize',12,'color',[0 0 0])



% sensor+time versus time-only
% h = figure
% set(h,'position',[520   649   460   400])
% plot(acc_personal_time, acc_personal_all, '.','markersize',8)
% hold on
% plot([.25 1],[.25 1])
% axis([.25 1 .25 1])
% ylabel('Time+Sensor Model Accuracy')
% xlabel('Time Model Accuracy')
% text(.35,.39,'y = x','rotation',45,'fontweight','bold','fontsize',12,'color',[.7 .3 0])
% box off
% mdl = fitlm(acc_personal_time, acc_personal_all);
% plot([min(acc_personal_time) max(acc_personal_time)], mdl.Coefficients.Estimate(2)*[min(acc_personal_time) max(acc_personal_time)]+mdl.Coefficients.Estimate(1),'--k','linewidth',1);
% 
% h = figure
% set(h,'position',[520   649   460   400])
% plot(acc_global_all, acc_global_time, '.','markersize',8)
% hold on
% plot([.25 1],[.25 1])
% axis([.25 1 .25 1])
% ylabel('Time+Sensor Model Accuracy')
% xlabel('Time Model Accuracy')
% text(.35,.39,'y = x','rotation',45,'fontweight','bold','fontsize',12,'color',[.7 .3 0])
% box off
% mdl = fitlm(acc_global_all,acc_global_time);
% plot([min(acc_global_all) max(acc_global_all)], mdl.Coefficients.Estimate(2)*[min(acc_global_all) max(acc_global_all)]+mdl.Coefficients.Estimate(1),'--k','linewidth',1);

%% final accuracies of personal models
load('results_personal_correctedtimes')
acc_personal_corrected_all = out.performance(:,1);
load('results_personal_correctedtimes_timeonly')
acc_personal_corrected_time = out.performance(:,1);
load('results_personal_correctedtimes_notime')
acc_persnal_corrected_sensor = out.performance(:,1);

load('bad_subjects')
acc_personal_corrected_all_good = acc_personal_corrected_all;
acc_personal_corrected_all_good(ind_bad) = [];
acc_personal_corrected_time_good = acc_personal_corrected_time;
acc_personal_corrected_time_good(ind_bad) = [];
acc_persnal_corrected_sensor_good = acc_persnal_corrected_sensor;
acc_persnal_corrected_sensor_good(ind_bad) = [];

figure(4)
bar([.9 1.9 2.9],[nanmean(acc_personal_sensor),nanmean(acc_personal_time),nanmean(acc_personal_all)],'barwidth',.2,'facecolor',[.7 .7 .7],'edgecolor',[.7 .7 .7])
hold on
bar([1.1 2.1 3.1],[nanmean(acc_persnal_corrected_sensor),nanmean(acc_personal_corrected_time),nanmean(acc_personal_corrected_all)],'barwidth',.2,'facecolor',[.4 .7 1])
bar([1.3 2.3 3.3],[nanmean(acc_persnal_corrected_sensor_good),nanmean(acc_personal_corrected_time_good),nanmean(acc_personal_corrected_all_good)],'barwidth',.2,'facecolor',[.4 1 .7])
errorbar([.9 1.9 2.9],[nanmean(acc_personal_sensor),nanmean(acc_personal_time),nanmean(acc_personal_all)],[nanstd(acc_personal_sensor)/n,nanstd(acc_personal_time)/n,nanstd(acc_personal_all)/n],'.k',...
    'linewidth',3,'color',[.7 .7 .7]);

errorbar([1.1 2.1 3.1],[nanmean(acc_persnal_corrected_sensor),nanmean(acc_personal_corrected_time),nanmean(acc_personal_corrected_all)],[nanstd(acc_persnal_corrected_sensor)/n,nanstd(acc_personal_corrected_time)/n,nanstd(acc_personal_corrected_all)/n],'.k',...
    'linewidth',3);
errorbar([1.3 2.3 3.3],[nanmean(acc_persnal_corrected_sensor_good),nanmean(acc_personal_corrected_time_good),nanmean(acc_personal_corrected_all_good)],[nanstd(acc_persnal_corrected_sensor)/n,nanstd(acc_personal_corrected_time)/n,nanstd(acc_personal_corrected_all)/n],'.k',...
    'linewidth',3);
xlim([0 4])
ylim([.75 .95])
set(gca, 'xtick',[1 2 3],'xticklabel',{'Sensor','Time','Time+Sensors'});
set(gca, 'ygrid', 'on')
box off
ylabel('Classification Accuracy')
legend('Before Quality Improvement','After Quality Improvement','After Removing Participants with Missing Data','location','northwest')
title('Personal Models');

%% final accuracies of global models
load('results_global_corrected')
acc_global_corrected_all = out.performance(:,1);
load('results_global_corrected_timeonly')
acc_global_corrected_time = out.performance(:,1);
load('results_global_corrected_notime')
acc_global_corrected_sensor = out.performance(:,1);

acc_global_corrected_all_good = acc_global_corrected_all;
acc_global_corrected_all_good(ind_bad) = [];
acc_global_corrected_time_good = acc_global_corrected_time;
acc_global_corrected_time_good(ind_bad) = [];
acc_global_corrected_sensor_good = acc_global_corrected_sensor;
acc_global_corrected_sensor_good(ind_bad) = [];

figure(5)
bar([.9 1.9 2.9],[nanmean(acc_global_sensor),nanmean(acc_global_time),nanmean(acc_global_all)],'barwidth',.2,'facecolor',[.7 .7 .7],'edgecolor',[.7 .7 .7])
hold on
bar([1.1 2.1 3.1],[nanmean(acc_global_corrected_sensor),nanmean(acc_global_corrected_time),nanmean(acc_global_corrected_all)],'barwidth',.2,'facecolor',[.4 .7 1])
bar([1.3 2.3 3.3],[nanmean(acc_global_corrected_sensor_good),nanmean(acc_global_corrected_time_good),nanmean(acc_global_corrected_all_good)],'barwidth',.2,'facecolor',[.4 1 .7])
errorbar([.9 1.9 2.9],[nanmean(acc_global_sensor),nanmean(acc_global_time),nanmean(acc_global_all)],[nanstd(acc_global_sensor)/n,nanstd(acc_global_time)/n,nanstd(acc_global_all)/n],'.k',...
    'linewidth',3,'color',[.7 .7 .7]);

errorbar([1.1 2.1 3.1],[nanmean(acc_global_corrected_sensor),nanmean(acc_global_corrected_time),nanmean(acc_global_corrected_all)],[nanstd(acc_global_corrected_sensor)/n,nanstd(acc_global_corrected_time)/n,nanstd(acc_global_corrected_all)/n],'.k',...
    'linewidth',3);
errorbar([1.3 2.3 3.3],[nanmean(acc_global_corrected_sensor_good),nanmean(acc_global_corrected_time_good),nanmean(acc_global_corrected_all_good)],[nanstd(acc_global_corrected_sensor)/n,nanstd(acc_global_corrected_time)/n,nanstd(acc_global_corrected_all)/n],'.k',...
    'linewidth',3);
xlim([0 4])
ylim([.75 .95])
set(gca, 'xtick',[1 2 3],'xticklabel',{'Sensor','Time','Time+Sensors'});
set(gca, 'ygrid', 'on')
box off
ylabel('Classification Accuracy')
legend('Before Quality Improvement','After Quality Improvement','After Removing Participants with Missing Data','location','northwest')
title('Global Models');