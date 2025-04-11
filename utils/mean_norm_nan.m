function Y = mean_norm_nan(X)

Y = X - nanmean_rod(X);
Ymax = max(Y);
Ymin = min(Y);

Y = 2 * Y / (Ymax-Ymin);
