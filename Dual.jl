# A= rand(0:1,2,2)
# a= length(A)
# d= zeros(a)
# d[1]= A[a]*2^0
#
# #[println(A[i,j]) ]
# for i in 1:a
# 	while i<a
# 		d[i+1] =(A[a-i])*2^(i)
# 		#d = reshape(d, size(A))
# 		break
# 	end
# end
# s=sum(d)

function binaer(M,N)
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
