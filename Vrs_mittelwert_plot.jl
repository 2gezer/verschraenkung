#Packages
#Pkg.add("Gadfly") Pkg.add("Cairo") Pkg.add("Fontconfig")
using Gadfly
using Cairo
using Fontconfig

#### Variablen und Umgebung ###
Psi = zeros() #Zustandsmatrix
ρ = zeros()   #reduzierte Dichtematrix
x=[]          #Werte der Verschränkung je zufälliger Zustand
xs=[]         #Mittelwert der Verschänkung für die jeweilige Platzanzahl


#Plotting Theme
blankTheme = Theme(
grid_color=colorant"grey",
panel_fill=colorant"white",
major_label_color=colorant"black",
minor_label_color=colorant"black")



#Funktion zur Berechnnung der Verschränkung
function vrs(X,a)

  #Platzanzahl
  b = (X-a) #wähle feste plätze

  #erstelle zufälligen Zustand Psi (Zeilen von Psi == dim 2^a , Spalten == dim 2^b)
  Psi= rand(-1:1,2^a,2^b)

  #Normiere: |a|^2+|b|^2 =1
  Psi= Psi/norm(Psi)

  #Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
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
  return Psi,ρ,w,V,x,a
end

#Plot der Verschränkungswerte mit Schleife über vrs(X)
function plt(X,a)
  #Lösche die Einträge aus vorheriger Schleife
  if isempty(x) isempty(xs)== false
  deleteat!(x,1:length(x))
  deleteat!(xs,1:length(x))
end
for j in (a+1):X
  for i in 1:100
    vrs(j,a)
  end
  push!(xs,mean(x)) #speichere Mittelwert der Verschränkung in Array
end
	println("Mittelwert der Verschränkung bei ",X, " Plätzen: ", xs[end])
  p = plot(x=1:length(xs), y=xs, Guide.title("Verschränkung verschiedener Zustände bei $X Plätzen,\n mit Aufteilung A= $a, B= $(X-a)"),
					Guide.XLabel("Plätze "),Guide.YLabel("mittlere Verschränkungswert"),
					blankTheme, Geom.line)
          img = PDF("Verschränkung $X,$a.pdf", 8inch, 6inch)
          draw(img, p)
	return p
end
@time plt(12,5)
