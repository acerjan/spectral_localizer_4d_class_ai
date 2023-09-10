function char_poly = clifford_clifford(d)

% This creates  d  Clifford matrices, then looks
% at the signature of the localizer of thos
% matrices, at the origin.  Also commputes
% the expected answer by the formula in the main theorem.

if d < 2
	fprintf("oh no, too small\n");
	return
end
if mod(d,2)==0
	fprintf("oh no, even\n");
	return
end


I = [1 0;0 1];
sigx = [0  1; 1  0];
sigy = [0 -i; i  0];
sigz = [1  0; 0 -1];

A = {};

for k = 1:d
	A{k} = 1;
end
II = 1;

next_odd_d = d + mod(d+1,2);

for dd = 3:2:next_odd_d
	for k = 1:dd
		if k<(dd-1)
			A{k} = kron(sigz,A{k});
		elseif k == (dd-1)
			A{k} = kron(sigx,II);
		elseif k == dd
			A{k} = kron(sigy,II);
		else
			A{k} = kron(I,A{k});
		end
	end
	II = kron(II,I);
end

prodA = eye(length(A{1}));
for j = 1:(next_odd_d-1)
	prodA = prodA*A{j};
end
if mod(next_odd_d,4)==3
	prodA = -i*prodA;
end
testOKA = (norm(A{next_odd_d} - prodA) < 10^-12);
if ~testOKA
  A{next_odd_d} = -A{next_odd_d};
end

testOKA = (norm(A{next_odd_d} - prodA) < 10^-12);


testOKA = true;
for j = 1:d
	Aj = A{j};
	testOKA = testOKA & (norm(Aj' - Aj) < 10^-12);
	testOKA = testOKA & (norm(Aj*Aj - II) < 10^-12);
	for k=1:d
		if k ~= j
			Ak = A{k};
			testOKA = testOKA & (norm(Aj*Ak + Ak*Aj) < 10^-12);
		end
	end
end
testOKA;


L =  0;
for k=1:d
	L = L + kron(A{k},A{k});
end
ev = eig(L);

% Compute signature the slow way.  Good enough here.
signature = sum(ev > 0) - sum(ev <= 0)  

should_be = nchoosek( (d-1), (d-1)/2 ) 


end

