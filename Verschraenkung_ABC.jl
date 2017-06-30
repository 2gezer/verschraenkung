#Teilchenanzahl
N=3
# bezeichne Spins
u=0 #up
d=1 #down
uu = 00 #upup
ud = 01 #updown
du = 10 #downup
dd = 11 #downdown
#erstelle Array für die Basisvektoren von System A
A=[u d]
a= size(A,2)
#erstelle Array für Basisvektoren von System B
BC= [u u u d d u d d ]
b= size(BC,2)
#Zustandsraum 2^N.... wie implentieren?
2^N

#Allgemeine Matrix mit allen möglichen Zuständen von A und B
Psi= zeros(a,b)

Psi[1,1]=A[1]*B[2]

for i in 1:a
  for j in 1:b
    Psi[i,j] = A[i]*B[j]
  end
end

#Freigewählter zustand

Psi[1,2]
Psi[2,2]
