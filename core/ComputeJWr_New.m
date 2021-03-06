function [G2 e2 r2 W2] = ComputeJWr_New(I2,Z2,I3,Z3,G_initial,InParas,epsilon,kmax,i,r1)

[rows cols] = size(I1);
I22 = WarpImage(I2,Z2,G,InParas);
r = GetResidual(I1,I22);
[delta iteration]= TDistributionScaleEstimator(initial_sigma,default_dof,r);
%Use t-distribution
W = TDistributionInfluenceFunction(r,delta,default_dof);
% h = GetHistogram(r,W,100);
% a = [-50:1:50];
% plot(a,h,'*');
%Use FIS based method
%W = WDFIS(r,d_r);
GetDerivative = CalcDerivative;
I22_dx = GetDerivative.fun1(I22);
I22_dy = GetDerivative.fun2(I22);

J = zeros(rows*cols,6);
for i = 1:rows*cols
    p2 = GetPosition(i,cols);
    y = p2(2);
    x = p2(1);
    J_I = [I22_dx(y,x) I22_dy(y,x)];
    J_w = ComputeJw(p2,Z1(y,x),InParas);
    J(i,:) = ComputeJacobian(J_I,J_w);  
end
