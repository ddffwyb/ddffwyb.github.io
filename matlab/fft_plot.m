function [f, P1] = fft_plot(X, Fs, varargin)
% FFT_PLOT 自动使用 fft 计算频谱并随即调用 plot 绘制频谱图
%
% 使用方法
%   fft_plot(X, Fs) 绘制采样率为 Fs 的信号 X 的频谱图
%   fft_plot(X, Fs, 'is_hamming', 1) 是否加窗，默认为 1（加窗），0 则不加
%   fft_plot(X, Fs, 'is_padding', 1) 是否补零，默认为 1（补零），0 则不补
%   [f, P1] = fft_plot(X, Fs) 返回绘图所用的频率 f 和单边频谱 P1，供自定义绘图
%
% 输入参数
%   X  输入信号
%   Fs 采样率
%   is_hamming （可选）是否加窗，默认加窗
%   is_padding （可选）是否补零，默认补零
%
% 输出参数（可忽略）
%   f  绘图所使用的横轴频率
%   P1 绘图所使用的纵轴单边频谱

    p = inputParser;                  % 解析参数
    addRequired(p, 'X');              % 必有参数 X
    addRequired(p, 'Fs');             % 必有参数 Fs
    addOptional(p, 'is_hamming', 1);  % 默认加窗
    addOptional(p, 'is_padding', 1);  % 默认补零
    parse(p, X, Fs, varargin{:});

    w = ones(size(p.Results.X));      % 默认矩形窗
    L = length(p.Results.X);          % 信号的长度
    if p.Results.is_hamming           % 是否加窗
        w = reshape(hamming(L), size(p.Results.X));
    end
    if p.Results.is_padding           % 是否补零
        L = 2 ^ (nextpow2(L) + 1);
    end

    Y = fft(w .* p.Results.X, L);     % 信号的傅里叶变换
    P2 = abs(Y/L);                    % 双侧频谱
    P1 = P2(1:L/2+1);                 % 单侧频谱
    P1(2:end-1) = P1(2:end-1) * 2;
    f = p.Results.Fs * (0:L/2)/L;     % 频率 f
    plot(f, P1);                               % 按照给定参数绘图
    title('Single-Sided Amplitude Spectrum');  % 默认标题
    xlabel('f (Hz)');                          % 默认 xlabel
    ylabel('|P1(f)|');                         % 默认 ylabel

end
