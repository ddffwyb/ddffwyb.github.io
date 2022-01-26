function signal = generate_plane_signal(D, r, vs, t)
% GENERATE_PLANE_SIGNAL 产生无线大平板的光声信号
% 其产生的信号的默认初始声压 p0 = 1
%
% 使用方法
%   signal = generate_plane_signal(D, r, vs, t)
%
% 输入参数
%   D  平板的厚度
%   r  探测器距离平板中心的距离
%   vs 声速
%   t  时间序列
%
% 输出参数
%   signal 产生的信号

    u = @(x) double(x > 0);  % u 为单位阶跃函数
    signal = (u(r - vs * t + D / 2) .* u(-r + vs * t + D / 2) + ...
        u(r + vs * t + D / 2) .* u(-r - vs * t + D / 2)) / 2;

end
