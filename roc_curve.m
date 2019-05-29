function ROC_data = roc_curve(class_1, class_2, dispp, dispt)
% Setting default parameters and detecting errors
    if(nargin<4), dispt = 1;    end
    if(nargin<3), dispp = 1;    end
    if(nargin<2), error('Params "class_1" or "class_2" are not indicated.'); end
    class_1 = class_1(:);
    class_2 = class_2(:);
    
    % Calculating the threshold values between the data points
    s_data = unique(sort([class_1; class_2]));          % Sorted data points
    s_data(isnan(s_data)) = [];                 % Delete NaN values
    d_data = diff(s_data);                      % Difference between consecutive points
    if(isempty(d_data)), error('Both class data are the same!'); end
    d_data(length(d_data)+1,1) = d_data(length(d_data));% Last point
    thres(1,1) = s_data(1) - d_data(1);                 % First point
    thres(2:length(s_data)+1,1) = s_data + d_data./2;   % Threshold values
        
    % Calculating the sensibility and specificity of each threshold
    curve = zeros(size(thres,1),2);
    distance = zeros(size(thres,1),1);
    for id_t = 1:1:length(thres)
        TP = length(find(class_2 >= thres(id_t)));    % True positives
        FP = length(find(class_1 >= thres(id_t)));    % False positives
        FN = length(find(class_2 < thres(id_t)));     % False negatives
        TN = length(find(class_1 < thres(id_t)));     % True negatives
        
        %curve(id_t,1) = log(TP/(TP + FN));   % Sensitivity
        curve(id_t,2) = FN/(FN+TP);
        %curve(id_t,2) = TN/(TN + FP);	% Specificity
        curve(id_t,1) = FP/(FP+TN);
        % Distance between each point and the optimum point (0,1)
        distance(id_t)= sqrt((1-curve(id_t,1))^2+(curve(id_t,2)-1)^2);
    end
    
    % Optimum threshold and parameters
    [~, opt] = min(distance);
    TP = length(find(class_2 >= thres(opt)));    % No. true positives
    FP = length(find(class_1 >= thres(opt)));    % No. false positives 
    FN = length(find(class_2 < thres(opt)));     % No. false negatives                                 
    TN = length(find(class_1 < thres(opt)));     % No. true negatives       
    
    % Output parameters
    param.Threshold = thres(opt);               % Optimum threshold position
    param.Sensi = curve(opt,1);                 % Sensitivity
    param.Speci = curve(opt,2);                 % Specificity
    param.AROC  = abs(trapz(1-curve(:,2),curve(:,1))); % Area under curve
    param.Accuracy = (TP+TN)/(TP+TN+FP+FN);     % Aaccuracy
    param.PPV   = TP/(TP+FP);                   % Positive predictive value
    param.NPV   = TN/(TN+FN);                   % Negative predictive value
    param.FNR   = FN/(FN+TP);                   % False negative rate
    param.FPR   = FP/(FP+TN);                   % False positive rate
    param.FDR   = FP/(FP+TP);                   % False discovery rate
    param.FOR   = FN/(FN+TN);                   % False omission rate
    param.F1_score = 2*TP/(2*TP+FP+FN);         % F1 score
    param.MCC   = (TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));  % Matthews correlation coefficient
    param.BM    = param.Sensi+param.Speci-1;    % Informedness
    param.MK    = param.PPV+param.NPV-1;        % Markedness
    
    param.TP = TP;    % No. true positives
    param.FP = FP;    % No. false positives 
    param.FN = FN;    % No. false negatives                                 
    param.TN = TN;    % No. true negatives  
    
    % Plotting if required
    if(dispp == 1)
        fill_color = [11/255, 208/255, 217/255];
        fill([1-curve(:,2); 1], [curve(:,1); 0], fill_color,'FaceAlpha',0.5);
        hold on; plot(1-curve(:,2), curve(:,1), '-b', 'LineWidth', 2);
        hold on; plot(1-curve(opt,2), curve(opt,1), 'or', 'MarkerSize', 10);
        hold on; plot(1-curve(opt,2), curve(opt,1), 'xr', 'MarkerSize', 12);
        hold off; axis square; grid on; xlabel('1 - specificity'); ylabel('sensibility');
        title(['AROC = ' num2str(param.AROC)]);
    end
    
    % AROC warning
    if param.AROC < 0.5
        warning('Since AROC is less than 0.5, you should swap the classes: roc_curve(class_2,class_1).');
    end
    
    % Log screen parameters if required
    if(dispt == 1)
        fprintf('\n ROC CURVE PARAMETERS\n');
        fprintf(' ------------------------------\n');
        fprintf('  - Distance:     %.4f\n', distance(opt));
        fprintf('  - Threshold:    %.4f\n', param.Threshold);
        fprintf('  - Sensitivity:  %.4f\n', param.Sensi);
        fprintf('  - Specificity:  %.4f\n', param.Speci);
        fprintf('  - AROC:         %.4f\n', param.AROC);
        fprintf('  - Accuracy:     %.4f\n', param.Accuracy);
        fprintf('  - PPV:          %.4f\n', param.PPV);
        fprintf('  - NPV:          %.4f\n', param.NPV);
        fprintf('  - FNR:          %.4f\n', param.FNR);
        fprintf('  - FPR:          %.4f\n', param.FPR);
        fprintf('  - FDR:          %.4f\n', param.FDR);
        fprintf('  - FOR:          %.4f\n', param.FOR);
        fprintf('  - F1 score:     %.4f\n', param.F1_score);
        fprintf('  - MCC:          %.4f\n', param.MCC);
        fprintf('  - BM:           %.4f\n', param.BM);
        fprintf('  - MK:           %.4f\n', param.MK);
        fprintf(' \n');
    end
    
    % Assinging parameters and curve data
    ROC_data.param = param;
    ROC_data.curve = curve;
end

