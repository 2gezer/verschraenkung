
function Matrix(P)
  #Platzanzahl
  a = rand(1:(P-1))
  b = (P-a)

  #erstelle zufälligen Zustand Psi mit zeilen von Psi == dim A , Spalten von Psi == dim B)
  M= rand(0:1,(2^a,2^b))

  #Normieren: |a|^2+|b|^2 =1
  M= M/norm(M)
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
    if w[i] < 0.00000000000001
      v[i]=0
    else
      v[i]= (w[i]*log(w[i]))
    end
  end
  #Berechne Verschränkung
  if sum(v) ==0
    V=0
    println("Nicht verschränkt")
  else
    V= -sum(v)
  end
  return println( "Anzahl aller Teilchen: ", P, "\n","\n",
  "Anzahl der Plätze in System A: ", a,"\n",
  "\n", "Anzahl der Plätze in System B : ",b ,"\n",
  "Zustandsmatrix M: \n", M, "\n","\n",
  "Die reduzierte Dichtematrix des Systems A ubd B ist: \n", ρ, "\n","\n",
  "Eigenwerte: ", w, "\n", "\n",
  "Die Verschränkung des zufälligen Zustands beträgt: \n","\n",V)
end
