function [] = plotLossAccFNRFCR(epo, EXTgc_stat, args, fig, titl)

args.epoch = epo;
% Train & Test Loss --------------------------
figure(1+fig), clf, hold on
title({titl; 'Train & Test Loss'})
set(gcf, 'color','white')
plotNice(EXTgc_stat.m_train,'b')
plotNice(EXTgc_stat.m_test, 'r')
eb([],EXTgc_stat.m_test,EXTgc_stat.sem_test, [1 182/255 193/255])
eb([], EXTgc_stat.m_train,EXTgc_stat.sem_train, [188/255 210/255 238/255])
legend('Train Data', 'Test Data')
ylim([0 .6])
xlim([0 50])
xlabel('Epoch #')
ylabel('Loss')

%legend('FNR = FN / (FN + TP)', 'FPR = FP / (FP + TN)')

% Accuracy --------------------------
figure(2+fig), clf, hold on
title({titl; 'Test Data Accuracy'})
set(gcf, 'color','white')
plotNice(EXTgc_stat.m_acc, 'b')
eb([], EXTgc_stat.m_acc,EXTgc_stat.sem_acc, [188/255 210/255 238/255])
plotNice(EXTgc_stat.m_acc,'b')
xlim([0 50])
ylim([80 100])
xlabel('Epoch #')
ylabel('Test Data Accuracy (%)')

% FPR, FNR --------------------------
figure(3+fig), clf, hold on
title({titl; 'Test Data FNR & FPR'})
set(gcf, 'color','white')
plotNice(EXTgc_stat.m_fpr, 'r')
plotNice(EXTgc_stat.m_fnr,'b')
eb([],EXTgc_stat.m_fpr,EXTgc_stat.sem_fpr, [1 182/255 193/255])
eb([], EXTgc_stat.m_fnr,EXTgc_stat.sem_fnr, [188/255 210/255 238/255])
legend('FPR', 'FNR')
ylim([0 30])
xlim([0 50])
xlabel('Epoch #')
ylabel('Test Data FNR & FPR (%)')
%legend('FNR = FN / (FN + TP)', 'FPR = FP / (FP + TN)')

function [] = plotNice(m_f0,color)
    plot(m_f0, 'o','color', color, 'markersize',1, 'markerfacecolor',color)
end
function []= eb(x, m, sem, color)
    errorbar(x, m, sem, '.', 'color', color,'markersize',1, 'markerfacecolor', color,'capsize',0)
end

end