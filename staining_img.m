function [masked_image] = staining_img(ii, bw)

ii(ii < bw) = 0;
masked_image = ii;
