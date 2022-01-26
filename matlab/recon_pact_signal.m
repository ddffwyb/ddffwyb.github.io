function signal_recon = recon_pact_signal( ...
    signal_backproj, detector_location, x_grid, y_grid, z_grid, ...
    vs, fs, num_detector, num_time)
% RECON_PACT_SIGNAL 使用 delay and sum (DAS) 算法重建光声信号
%
% 使用方法
%   signal_recon = recon_pact_signal(signal_backproj, detector_location, ...
%                                    x_grid, y_grid, z_grid, vs, fs, ...
%                                    num_detector, num_time)
% 输入参数
%   signal_backproj         反投影信号，其每一行是一个探测器的信号
%   detector_location       探测器坐标，其每一行是一个探测器的坐标
%   x_grid、y_grid、z_grid  重建区域空间网格
%   vs、fs                  声速、采样率
%   num_detector、num_time  探测器数量、采样点数
%
% 输出参数
%   signal_recon  重建的信号，大小于 x_grid 相同

    signal_recon = 0 * x_grid;  % 初始化重建信号
    for i = 1:num_detector
        temp_signal = signal_backproj(i, :);      % 取出本次循环要用的信号
        temp_location = detector_location(i, :);  % 取出本次循环要用的坐标
        temp_signal(num_time) = 0;                % 方便处理过大的索引
        % 计算距离和延迟索引
        dx = x_grid - temp_location(1);
        dy = y_grid - temp_location(2);
        dz = z_grid - temp_location(3);
        d = sqrt(dx.^2 + dy.^2 + dz.^2);
        idx = round(d / vs * fs);
        % 处理过大的索引
        idx(idx > num_time) = num_time;
        % delay and sum
        if idx < num_time
            signal_recon = signal_recon + temp_signal(idx);
        end
    end

end
