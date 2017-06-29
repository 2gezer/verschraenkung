
function Matrix(L)
  #Teilchenanzahl
  N=14
  K=N-L
  #erstelle Matrix von System A mit zufälligen Einträgen, (0== spin up, 1== spin down)
  A=rand(0:1,(L,L))
  a=size(A,1)

  #erstelle Matrix von System B
  B=rand(0:1,(K,K))
  b=size(B,1)

  #erstelle Matrix aus System A und B
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
        ρ[i,k]= sum(c^2*M[i,j]*M[k,j])
        end
      end
    end

    #Berechne Eigenwerte
    w= eigvals(ρ)
    v= zeros(w)
    for i in 1:length(w)
      try
      v[i]= (w[i]*log(w[i]))
    catch (DomainError(), println("not a number but zero"))

    end
  end
  if V !=NaN
    V= -sum(v)
  else throw(DomainError())
  end
    return println("Matrix des Systems A und B : \n", c*M, "\n","\n",
    "Die reduzierte Dichtematrix des Systems A ubd B ist: \n", ρ, "\n","\n",
    "Eigenwerte: ", w, "\n", "\n",
    "Die Verschränkung des zufälligen Zustands beträgt: \n", V)
  else
    println("Matrix M hat nur Nulleinträge")
  end


end
