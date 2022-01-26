function img_filtered = lightspot(img, disk_radius, threshold)
%lightspot 函数：提取荧光图像中的光点。
% disk_radius 为执行形态学开运算的结构单元半径，其值越小。保留结构越多。
% threshold 为图像增强卡的阈值，按百分比计算，小于该值的元素被设置为 0。
    img2 = imtophat(img, strel('disk', disk_radius));
    img3 = imadjust(img2, [0, 0.1], [0, 1]);
    img_filtered = img3 .* uint8(img3 > 255 * threshold);
end
