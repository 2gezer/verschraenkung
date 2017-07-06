
#Teilchenanzahl

# # bezeichne Spins, wie   ???
# u=0 #up
# d=1 #down
# uu = 00 #upup
# ud = 01 #updown
# du = 10 #downup
# dd = 11 #downdown


#Gebe Zustand durch manuelles Eingeben von Spinverteilung in A und B ein.
function verschraenkt(A,B)
  #Dimension von A
  a= size(A,1)
  #dimension von B
  b= size(B,1)

  #Zustandsraum 2^N.... wie implentieren?
#  Psi = rand(0:1,(2^a,2^b)

  Psi= zeros(a,b)
  for i in 1:a
    for j in 1:b
      Psi[i,j] = (A[i])*B[j])
    end
  end

  #Normiere
  Psi = Psi/norm(Psi)

  #Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
  ρ = zeros(a,a)
  for i in 1:size(Psi,1)
    for k in 1:size(Psi,1)
      for j in 1:size(Psi,2)
        ρ[i,k]+= sum(Psi[i,j]*Psi[k,j]) #+ da, sonst ρ[i,k] zu Null überschrieben wird
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
  # Voraussetzung: Summe der Eigenwerte=1 ???
  if 1.1< sum(w) < 0.9
      V=0
      println("Keine Verschränkung, da Summe der Eigenwerte ≠ 1", sum(w), w)
    else
      V= -sum(v)
  return println("Anzahl der Plätze: ", sum(A)+sum(B), "\n","\n",
  "Spinverteilung ausgehend von Anfangszustand in  A: ", A,"\n",
  "\n", "Spinverteilung ausgehend von Anfangszustand in B : ",B ,"\n","\n",
  "normierte Zustandsmatrix Psi : \n", Psi, "\n","\n",
  "Die reduzierte Dichtematrix des Systems A ubd B ist: \n", ρ, "\n","\n",
  "Eigenwerte: ", w, "\n", "\n",
  "Die Verschränkung des zufälligen Zustands beträgt: \n","\n",V)
end
end
  #Berechne Verschränkung
