A = diag([-1 0 1]);
B = diag([1 1],1);
C = -1i*B;
B = B + B';
C = C + C';

syms x y z
sigx = [0 1; 1 0];
sigy = [0 -1i; 1i 0];
sigz = [1 0; 0 -1 ];
II = eye(length(A));

figure(1);
hold on;
for k=[sym(1/4)] %[sym(1/7) sym(1/6) sym(1/5) sym(1/4) sym(1/3) sym(1/2) sym(1)]

	L = kron(A-x*II,sigx) + kron(k*B-y*II,sigy)+ kron(k*C,sigz);
	
	poly = det(L);
	factors = factor(poly);
	xyinterval = [-1.25 1.25 -1.5 1.5 ];
	fcontour(factors(2),xyinterval,'LevelList',[0 ],'MeshDensity',600,'LineColor','k')
end
hold off;

figure(2);
hold on;
for k=[1/3] % [1/7 1/6 1/5 1/4 1/3 1/2 1]
	x = -1.5:0.005:1.5;
	gap = zeros(size(x));
	for j = 1:length(x)
		L = kron(A-x(j)*II,sigx) + kron(k*B,sigy)+ kron(k*C,sigz);
		gap(j) = min(abs(eig(L)));
	end
	plot(x,gap,'k')
	pause(0.3)
end
hold off;