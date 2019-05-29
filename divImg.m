function di = divImg(g)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%if size(g)==[400, 350]
%       q=15*ones(1, 10);
%   w=15*ones(1, 10);
 q=[13,13,13,13,13,13,13,13,13,11];
 w=q;

%      q=50*ones(1, 3);
%  w=50*ones(1, 3);
di=mat2cell(g, q, w);
% end
% if size(g)==[150 150]
%     q=15*ones(1, 10);
% w=15*ones(1, 10);
% di=mat2cell(g, q, w);
% end
end

