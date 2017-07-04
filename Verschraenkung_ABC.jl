
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

#Frei gewählter Zustand für A und B
A= (1,1)
a= size(A,1)

BC= (0,1,0,0)
b= size(BC,1)

#Zustandsraum 2^N.... wie implentieren?
2^N
# #Teilchenanzahl A
# N=8
# N_a = N-rand(1:N)
# N_b = N- N_a
#Matrix aus den Zuständen von A und B
Psi= zeros(a,b)

for i in 1:a
  for j in 1:b
    Psi[i,j] = (A[i])*BC[j]

  end
end

#Normiere
Psi = Psi/norm(Psi)

#Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
ρ = zeros(a,a)
for i in 1:size(Psi,1)
  for k in 1:size(Psi,1)
    for j in 1:size(Psi,2)
      ρ[i,k]+= sum(Psi[i,j]*Psi[k,j])
      #println(ρ) #markdown julia docs.
    end
  end
end

#Berechne Eigenwerte
w= eigvals(ρ)
v= zeros(w)
for i in 1:length(w)
  if w[i] <=0
    v[i]=0
    else
      v[i]= (w[i]*log(w[i]))
        end
end
if sum(v) ==0
  V=0
else
V= -sum(v)
end
return println( "Anzahl aller Teilchen: ", sum(A)+sum(BC), "\n","\n",
"Anzahl der Plätze in System A: ", A,"\n",
"\n", "Anzahl der Plätze in System B : ",BC ,"\n",
"Zustandsmatrix M: \n", Psi, "\n","\n",
"Die reduzierte Dichtematrix des Systems A ubd B ist: \n", ρ, "\n","\n",
"Eigenwerte: ", w, "\n", "\n",
"Die Verschränkung des zufälligen Zustands beträgt: \n","\n",V)

#Berechne Verschränkung
