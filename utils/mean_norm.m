function Y = mean_norm(X)

Y = X - mean(X);
Ymax = max(Y);
Ymin = min(Y);

Y = 2 * Y / (Ymax-Ymin);
