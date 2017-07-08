using Gadfly

#Plotting Theme
blankTheme = Theme(
grid_color=colorant"grey",
panel_fill=colorant"white",
major_label_color=colorant"black",
minor_label_color=colorant"black")

#Array zum festhalten von Verschränkungwert je zufälliger Zustand
x=[]

#Funktion zur Berechnnung der Verschränkung
function vrs(X)

  #Platzanzahl
  a = rand(1:(X-1))
  b = (X-a)

  #erstelle zufälligen Zustand Psi mit Zeilen von Psi == dim 2^A , Spalten von Psi == dim 2^B)
  Psi= rand(-1:1,2^a,2^b)

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
		if 0> w[i] <-1.0e-15
			println(w[i])
			throw("eigenwert ist negativ")
    elseif abs(w[i]) < 1.0e-5
      w[i] = 0.0
    else
      V += (w[i]*log(w[i]))
    end
  end

  #Berechne Verschränkung

  # ein Zustand ist verschränkt, wenn die
  if  abs(V) < 1.0e-10
    push!(x,abs(V))
    println("-------------","\n","∑",w, "-> w*ln(w)=0 -> Nicht verschränkt","\n", "\n")
  else
    push!(x,abs(V))
    return println( "Anzahl aller Teilchen: ", X, "\n","\n",
    "Anzahl der Plätze in System A: ", a,"\n",
    "\n", "Anzahl der Plätze in System B : ",b ,"\n", "\n",
    "Zustandsmatrix Psi: \n", Psi, "\n","\n",
    "Die reduzierte Dichtematrix des System A ubd B ist: \n", ρ, "\n","\n",
    "Eigenwerte: ", w, "\n", "\n",
    "Die Verschränkung des zufälligen Zustands beträgt: \n","\n",-V,"\n","\n")
  end
  return Psi,ρ,w,V
end

#Plot der Verschränkungswerte mit Schleife über vrs(X)
function plt(X)
  deleteat!(x,1:length(x))
  for i in 1:40
    vrs(X)
  end
  plot(x=1:length(x), y=x, Geom.point, Geom.line, blankTheme)

end
