from sage.rings.number_field.S_unit_solver import solve_S_unit_equation, eq_up_to_order
x = polygen(ZZ, 'x')

K2.<a2> = NumberField(x^2-26); K2

S = K2.ideal(2).prime_factors(); S
P2=S[0]; P2

SUK = UnitGroup(K2,S=tuple(S)); SUK
gens=SUK.gens_values(); gens

beta=gens[:]
for i in range(1,len(gens)):
	for j in range(0,i):
		beta.append(gens[i]*gens[j])

beta
len(beta)
