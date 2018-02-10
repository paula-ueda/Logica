
defmodule Utils do
	def belongs?(par, conjunto) do
		Enum.member?(conjunto, par)
	end
	def getx(par) do
		Enum.at(par, 0)
	end
	def gety(par) do
		Enum.at(par, 1)
	end
	def union(a, b) do
		Enum.concat(a, b) |> Enum.uniq
	end
	def reflexive_closure(lista_pares, lista_elementos) do
		lista_pares_reflexivos = Recor_reflexive.reflexive(lista_elementos, [])
		Utils.union(lista_pares, lista_pares_reflexivos)
	end

end

defmodule Recor_reflexive do
	def reflexive(lista_elementos, lista_pares_reflexivos) when length(lista_elementos) <=0 do
		lista_pares_reflexivos
	end
	def reflexive(lista_elementos, lista_pares_reflexivos) do
		[first|rest] = lista_elementos
		lista_pares_reflexivos = Utils.union(lista_pares_reflexivos, [[first, first]])
		lista_pares_reflexivos = Recor_reflexive.reflexive(rest, lista_pares_reflexivos)
		lista_pares_reflexivos
	end
end


lista_elementos = [1,2,3]
lista_pares = [[1,5], [1,6], [2,1], [2,2], [3,5]]
resp = Utils.reflexive_closure(lista_pares, lista_elementos)
IO.inspect resp, label: "The hope is"
par = [2,5]
x = Utils.getx(par)
IO.puts x


