function [e] = computeError()
N = 460000;
e = sqrt((8/N)*log((4*(2*N)^10)/0.05));

end
