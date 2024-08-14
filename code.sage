from sage.rings.number_field.S_unit_solver import solve_S_unit_equation, eq_up_to_order

#Creation of the number field K2=Q(sqrt(26))

x = polygen(ZZ, 'x')
K2.<a2> = NumberField(x^2-26); K2

#Creation of the ring of S-units

S = K2.ideal(2).prime_factors(); S
SUK = UnitGroup(K2,S=tuple(S)); SUK
gens=SUK.gens_values(); gens

#Creation of a list 'beta' containing the possibilities for beta

beta=gens[:]
for i in range(0,len(gens)-1):
	for j in range(i+1,len(gens)):
		beta.append(gens[i]*gens[j])
beta

#Creation of a list 'listL' containing the possibilities for the fields L=Q(sqrt(beta))

R.<y> = PolynomialRing(K2)
polyL=[y^2-bt for bt in beta]
listL=[K2]
for f in polyL:
	L.<a>=K2.extension(f)
	listL.append(L.absolute_field('a'))
listL

# Creation of a function 'sols' which computes the S-units of a field L, where S is the set of primes above 2

def sols(NF,S):
	sols = solve_S_unit_equation(NF, S)
	return sols

# Creation of a function that checks whether for a given number field, the condition in the main theorem: valuation (-4XY) <= 6*valuation(2) holds

def check(NF):
	try:
		ok=True
		S = NF.primes_above(2)
		sols2 = sols(NF,S)
		for s in sols2:
			X=s[2]
			Y=s[3]
			I=NF.ideal(4*X*Y)
			J=NF.ideal(2)
			for P in S:
				if I.valuation(P)>6*J.valuation(P):
					ok=False
		return ok
	except Exception as e:
		print(f"Solutions could not be computed for {L}: {e}")
		return False

# Checking for which L the condition in the main theorem holds

for L in listL:
	try:
		if check(L):
			print(f"The condition in the main theorem holds for {L}")
		else:
			print(f"The condition in the main theorem does not hold for {L}")
	except Exception as e:
		print(f"Error occured : {e}")


