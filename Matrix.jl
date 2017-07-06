
function Matrix(P)

  ##zeros(Int8, 2^a, 2^b)??

  #Platzanzahl
  a = rand(1:(P-1))
  b = (P-a)

  #erstelle zufälligen Zustand Psi mit Zeilen von Psi == dim 2^A , Spalten von Psi == dim 2^B)
  Psi= rand(0:1,2^a,2^b)

  #Normiere: |a|^2+|b|^2 =1
  Psi= Psi/norm(Psi)

  #Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
  ρ = zeros(2^a,2^a)
  for i in 1:size(Psi,1)
    for k in 1:size(Psi,1)
      for j in 1:size(Psi,2)
        ρ[i,k]+= sum(Psi[i,j]*Psi[k,j])   #println(ρ) #markdown julia docs.
      end
    end
  end

  #Berechne Eigenwerte
  w= eigvals(ρ)

  #deklariere Verschränkungsvariable
  V::Float32 =0.0

  #Summe der Produkte der Eigenwerte mit ihren logarithmierten Werten
  for i in 1:length(w)
    if abs(w[i]) < 1.0e-10
      w[i] = 0.0
    else
      V += (w[i]*log(w[i]))
      #  throw(w) Exception wenn?
    end
  end


#Berechne Verschränkung

# ein Zustand ist verschränkt, wenn die
if  abs(V) < 1.0e-10
  println("∑",w, "-> w*ln(w)=0 -> Nicht verschränkt","\n", "\n")
else

return println( "Anzahl aller Teilchen: ", P, "\n","\n",
"Anzahl der Plätze in System A: ", a,"\n",
"\n", "Anzahl der Plätze in System B : ",b ,"\n", "\n",
"Zustandsmatrix Psi: \n", Psi, "\n","\n",
"Die reduzierte Dichtematrix des System A ubd B ist: \n", ρ, "\n","\n",
"Eigenwerte: ", w, "\n", "\n",
"Die Verschränkung des zufälligen Zustands beträgt: \n","\n",-V)
end
return Psi,ρ,w
end
