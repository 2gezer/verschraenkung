# N-site Heisenberg model with random couplings
# J_i^alpha and a random magnetic field h_i on
# each site

d=length(bits(1))

function dec2dual(M,N)
  z=Array(Int64,N)
  for i in 1:N
    z[i] = Int(bits(M)[d+1-i])-48
  end
  return z
end

N = 6
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
A=zeros(H)
Psi = zeros() #Zustandsmatrix
ρ = zeros()
x=[]
function Hamilton(N)
for i in 0:(2^N-1)
  z=dec2dual(i,N)
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

return A
end

function vrs(X)
Hamilton(X)
for i = 1:2^N
  for j= 1:2^N
  Psi[j,i] += A[i,j]
end
end
ρ = zeros(2^a,2^a)
for i in 1:size(Psi,1)
  for k in 1:size(Psi,1)
    for j in 1:size(Psi,2)
      ρ[i,k]+= sum(Psi[i,j]*Psi[k,j])
    end
  end
end

#Berechne Eigenwerte
w= eigvals(ρ)

#Verschränkungsvariable
V::Float32 =0.0

#Summe der Produkte der Eigenwerte mit ihren logarithmierten Werten
for i in 1:length(w)
  if 0> w[i] <-1.0e-14
    println(w[i])
    throw("eigenwert ist negativ")
  elseif abs(w[i]) < 1.0e-5
    w[i] = 0.0
  else
    V += (w[i]*log(w[i]))
  end
end

#Berechne Verschränkung
V= abs(V);
# für V=0 keine Verschränkung
if  V < 1.0e-10
  push!(x,V)
  #println("------------------------","\n","∑",w, "-> w*ln(w)=0 -> Nicht verschränkt","\n","------------------------", "\n")
else
  push!(x,V)
  # return println("Anzahl aller Teilchen: ", X, "\n","\n",
  # "Anzahl der Plätze in System A: ", a,"\n",
  # "\n", "Anzahl der Plätze in System B : ",b ,"\n", "\n",
  # "Zustandsmatrix Psi: \n", Psi, "\n","\n",
  # "Die reduzierte Dichtematrix des System A ubd B ist: \n", ρ, "\n","\n",
  # "Eigenwerte: ", w, "\n", "\n",
  # "Die Verschränkung des zufälligen Zustands beträgt: \n","\n",-V,"\n------------ \n")
end
# for i in eachindex(x)
#   x[i]= floor(x[i],3)
# end
return Psi,ρ,w,V,x
end


function plt(X)
  #Lösche die Einträge aus vorheriger Schleife
  if isempty(x) == false
  deleteat!(x,1:length(x))
  end
  for i in 1:1000
    vrs(X)
  end
println("Mittelwert der Verschränkung bei ",X, " Plätzen: ", mean(x))
#  vMin= minimum(x)
#  vMax= maximum(x)
# N= length(x)
# bins= (vMax-vMin)/50

# for i in eachindex(x)
#   p[i] = Int(floor(x[i]/(i*log(2))*100+1))
# end
#
#

#  times= collect(vMin:vMax)
#
#  pHist= plot(x=vMin:vMax, y=p, Geom.line)



  p = plot(x=x , y=1:length(x), Guide.title("Verschränkung verschiedener Zustände bei $X Plätzen"),
					Guide.XLabel("Plätze mit Aufteilung A= 2, B= $(X-2) "),Guide.YLabel("Häufigkeit"),
					blankTheme, Geom.histogram(bincount= floor(1000*log(2))))
          img = PDF("Verschränkung $X.pdf", 8inch, 6inch)
          draw(img, p)
	return p
end
@time plt(6)
