# N-site Heisenberg model with random couplings
# J_i^alpha and a random magnetic field h_i on
# each site

d=length(bits(1))
###
function dec2dual(M,N)
  z=Array{Int64}(N)
  for i in 1:N
    z[i] = Int(bits(M)[d+1-i])-48
  end
  return z
end
#Bei dec2dual(0,6)
#BoundsError: attempt to access "0000000000000000000000000000000000000000000000000000000000000000"
###
function binaer(x,N)
  if x!=0
    n=x
    l=Int64(trunc(log2(n)))+1
    z= zeros(N)
    i=1

    while l>0
      if x- 2^(l-1) >0 || x- 2^(l-1)== 0
        z[i] = 1
        x= x- 2^(l-1)
        l= l-1
        i=i+1
      elseif x- 2^(l-1)<0
        z[i] = 0
        l= l-1
        i=i+1
      end
    end
  else z=zeros(N)
  end
  return z
end



function Hamilton()
  N=6
  L = Int(3*N*(N-1)/2)
  h = 2.0*rand(N) - 1.0

  site1=Array{Int8}(0)
  site2=Array{Int8}(0)
  alpha=Array{Int8}(0)

  for i in 1:N-1
    for j in i+1:N
      push!(site1,i,i,i)
      push!(site2,j,j,j)
      push!(alpha,1,2,3)
    end
  end
  println(site1)
  println(site2)
  println(alpha)

  J = 2.0*rand(L) - 1.0

  println(J)
  H=zeros(2^N,2^N)

  for i in 0:(2^N-1)
    z=binaer(i,N)
    for j in 1:L
      p = site1[j]
      q = site2[j]
      i_prime = i + (1-2*z[p])*2^(p-1) + (1-2*z[q])*2^(q-1)
      if alpha[j]==1
        H[i_prime+1,i+1] = H[i_prime+1,i+1] - 0.25*J[j]
      end
      if alpha[j]==2
        H[i_prime+1,i+1] = H[i_prime+1,i+1] + 0.25*J[j]*(2*z[p]-1)*(2*z[q]-1)
      end
      if alpha[j]==3
        H[i+1,i+1] = H[i+1,i+1] - 0.25*J[j]*(2*z[p]-1)*(2*z[q]-1)
      end
    end

    for j in 1:N
      H[i+1,i+1] = H[i+1,i+1] - h[j]*(z[j]-0.5)
    end

  end

  E=eigvals(H)

  Edeg = Array(Float64,1)
  deg = Array(Int64,1)
  acc = 1e-10

  Edeg[1] = E[1]
  deg[1] = 1
  count = 1

  for i in 2:2^N
    if (abs(E[i] - Edeg[count]) < acc)
      deg[count] += 1
    else
      count += 1
      push!(Edeg,E[i])
      push!(deg,1)
    end
  end

  println("number of different eigenvalues: ", count)
  println()
  println("energies\t degeneracies")

  for i in 1:count
    @printf("%0.5f \t %d \n",Edeg[i],deg[i])
  end
  a= eigvecs(H)
  a1= a[:,1]

  return a1
end


#definiere up down Spins
u=[1,0]
d=[0,1]

#bidle Funktion für äußeres Produkt
function tensor(x,n)
  if n>1
    A=[]
    B= f(x,n-1)
    for i in x
      for j in B
        push!(A, kron(i,j))
      end
    end
    return A
  else
    return x
  end
end

function buildPsi(x,N,a)
  b=N-a
  B=[]
  state=spzeros(2^a,2^b)
  basisA=tensor([u,d],a)
  basisB=tensor([u,d],b)


  for i in 1:length(basisA)
    for j in 1:length(basisB)

      push!(B,kron(basisA[i],basisB[j]))
    end
  end

  l=1
  for i in 1:2^a
    for j in 1:2^b
      state[i,j]=dot(x,B[l])
      l+=1
    end
  end
  return state
end


function rho(X,a)
  ρ::Array{Float64,2} = zeros(2^a,2^a)
  for i in 1:size(X)[1]
    for k in 1:size(X)[1]
      for j in 1:size(X)[2]
        ρ[i,k]+= sum(X[i,j]*X[k,j])
      end
    end
  end
  return ρ
end

function vrs(N)
  w::AbstractArray = eigvals(N)
  V::Float64 = 0
  for i = 1:length(w)
    if 0> w[i] <-1.0e-14
      println(w[i])
      throw("eigenwert ist negativ")
    elseif abs(w[i]) < 1.0e-5
      w[i] = 0.0
    else
      V += (w[i]*log(w[i]))
    end
  end
  return V
end

abs(vrs(rho(buildPsi(a1,6,3),3)))
