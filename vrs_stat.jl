using Gadfly
using DataFrames
using Distributions


#Stelle einen zufaellig praeparierten Zustand auf
function PsiRand(N,a)
  #Plaetzverteilung kan beliebig gewaehlt werden
  b = (N-a)

  #erstelle einen zufaelligen Zustand zunächst ohne  Koeffizienten
  state = rand(-1:1,2^a,2^b)  #Binomial(), Poisson, Gauß-Verteilungen ausprobieren

  #Normiere: |a|^2+|b|^2 =1
  nState= state/norm(state)

  return nState
end


#Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
function rho(N,a)
  ρ::Array{Float64,2} = zeros(2^a,2^a)
  for i in 1:size(N)[1]
    for k in 1:size(N)[1]
      for j in 1:size(N)[2]
        ρ[i,k]+= sum(N[i,j]*N[k,j])
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

function statV(N,a)
  l=2000
  x= zeros(l)
  V::Float64 = 0
  for i in 1:l
    K=PsiRand(N,a)
    V= abs(vrs((rho(K,a))))
    if V<1.0e-14
      println("Keine Verschränkung bei Zustand ", K)
    end
    x[i]=V
  end
  return x
 end

function statS(N)
  df = DataFrame(a1 = statV(N,1), a2 = statV(N,2), a3 =statV(N,3), a4 =statV(N,4), a5=statV(N,5))

return df
end

#Plot der Verschränkung
 function plt(N,a)

   b= N-a
   #Lösche die Eintraege aus vorheriger Schleife
   x = copy(statV(N,a))
   println("Mittelwert der Verschraenkung bei ",N, " Plaetzen: ", mean(x))


   #Plotting Theme
   blankTheme = Theme(
   grid_color=colorant"grey",
   panel_fill=colorant"white",
   major_label_color=colorant"black",
   minor_label_color=colorant"black")

   p = plot(x=x , y=1:length(x), Guide.title("Verschraenkung verschiedener Zustaende bei $N Plaetzen"),
   Guide.XLabel("Plaetze mit Aufteilung A= $a, B= $b) "),Guide.YLabel("Haeufigkeit"),
   blankTheme, Geom.histogram(bincount= floor(1000*log(2))))
  #  img = PDF("Verschraenkung $N.pdf", 8inch, 6inch)
  #  draw(img, p)
   return p
 end

@time plt(6,2)
