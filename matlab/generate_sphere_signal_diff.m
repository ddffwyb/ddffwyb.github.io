function signal_diff = generate_sphere_signal_diff(R, r, vs, t)
% GENERATE_SPHERE_SIGNAL 产生球的光声信号的时间导数信号
% 其产生的信号的默认初始声压 p0 = 1
%
% 使用方法
%   signal_diff = generate_sphere_signal(R, r, vs, t)
%
% 输入参数
%   R  球半径
%   r  探测器距离球心的距离
%   vs 声速
%   t  时间序列
%
% 输出参数
%   signal_diff 产生的时间导数信号
    
    u = @(x) double(x > 0);  % u 为单位阶跃函数
    signal_diff = -vs / (2 * r) .* u(R- abs(r - vs * t));

end
