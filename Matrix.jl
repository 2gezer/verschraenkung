
function Matrix(N)
  #Teilchenanzahl
  l_A = rand(10:(N*2))
  l_B = 2*N-l_A
  #erstelle Platzhalter für Teilchen des Systems A (z. Bsp.: 0== spin up, 1== spin down)
  A=rand(0:1,(l_A,l_A))
  a=size(A,1)

  #erstelle B Platzhalter für Teilchen aus System B
  B=rand(0:1,(l_B,l_B))
  b=size(B,1)

  #erstelle Matrix aus System A und B : (Zeilen von M == dim A , Spalten von M == dim B)
  M= zeros(a,b)
  #Fülle die Matrix nach der Formel ψ= ∑ψij |i> |j>
  for i in 1:a
    for j in 1:b
      M[i,j]= A[i]*B[j]
    end
  end
  #Normieren: |a|^2+|b|^2 =1
  C=zeros(size(M))
  for i in eachindex(M)
    C[i]= M[i]^2
  end
  if sum(C) != 0
    c= 1/sum(C)
    #Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
    ρ = zeros(a,a)
    for i in 1:size(M,1)
      for k in 1:size(M,1)
        for j in 1:size(M,2)
          ρ[i,k]= sum(c^2*M[i,j]*M[k,j])   #markdown julia docs.
        end
      end
    end

    #Berechne Eigenwerte
    w= eigvals(ρ)
    v= zeros(w)
    for i in 1:length(w)
      if w[i] < 0.00000000001
        v[i]=0
        else
          v[i]= (w[i]*log(w[i]))
            end
    end
    #Berechne Verschränkung
    V= -sum(v)
  return println( "Anzahl aller Teilchen: ", N, "\n","\n",
  "Anzahl der Platzhalter in System A: ", l_A,"\n",
  "\n", "Anzahl der Platzhalter in System B : ",l_B ,"\n",
  "Zustandsmatrix M: \n", c*M, "\n","\n",
  "Die reduzierte Dichtematrix des Systems A ubd B ist: \n", ρ, "\n","\n",
  "Eigenwerte: ", w, "\n", "\n",
  "Die Verschränkung des zufälligen Zustands beträgt: \n","\n",V)

else
  println("Matrix M hat nur Nulleinträge")
end
end
