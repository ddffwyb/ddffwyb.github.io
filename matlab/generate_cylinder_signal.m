function signal = generate_cylinder_signal(R, r, vs, t)
% GENERATE_CYLINDER_SIGNAL 产生无限长圆柱的光声信号
% 其产生的信号的默认初始声压 p0 = 1
%
% 使用方法
%   signal = generate_cylinder_signal(R, r, vs, t)
%
% 输入参数
%   R  圆柱的半径
%   r  探测器距离圆柱中心的距离
%   vs 声速
%   t  时间序列
%
% 输出参数
%   signal 产生的信号

    N = length(t);
    signal = zeros(1, N);
    for i = 1:N
        ti = t(i);
        d = vs * ti;
        if ti <= (r - R) / vs
            signal(i) = 0;
        elseif ti > (r - R) / vs && ti < (r + R) / vs
            low = (r - R) / d;
            high = (r^2 + d^2 - R^2) / (2 * r * d);
            y = @(x) atan(abs(sqrt((R^2 - (r - d * x).^2) ./ ...
                (r^2 + d^2 - 2 * r * d * x - R^2))));
            signal(i) = 4 * d^2 * integral(y, low, high) + ...
                pi * d / r * (R^2 - (r - d)^2);
        elseif ti >= (r + R) / vs
            low = (r - R) / d;
            high = (r + R) / d;
            y = @(x) atan(abs(sqrt((R^2 - (r - d * x).^2) ./ ...
                (r^2 + d^2 - 2 * r * d * x - R^2))));
            signal(i) = 4 * d^2 * integral(y, low, high);
        end
        signal(i) = signal(i) / d;
    end
    temp = diff(signal) / (t(2) - t(1)) / (4 * pi * vs^2);
    signal(1:N - 1) = temp;
    signal(N) = signal(N - 1);

end
