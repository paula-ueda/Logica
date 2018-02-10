
defmodule Utils do
	def belongs(par, conjunto) do
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

	def transitive_closure(lista_pares) do
		Transitive.loop1(lista_pares, [])

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

defmodule Transitive do
	def loop1(lista_pares, lista_pares_transitivos) when length (lista_pares) <= 0 do
		lista_pares_transitivos
	end 
	def loop1(lista_pares, lista_pares_transitivos) do:
		lista_pares_transitivos = union(lista_pares_transitivos, lista_pares)
		[first|rest] = lista_pares
		x1 = Utils.getx(first)
		y1 = Utils.gety(first)
		lista_pares_transitivos = Transitive.loop2(lista_pares_transitivos, [], x1, y1)
		lista_pares_transitivos = Transitive.loop1(rest, lista_pares_transitivos)
	end
	def loop2 (lista_pares_iterando, lista_pares_transitivos, x1, y1) when length (lista_pares) <= 0 do
		lista_pares_transitivos
	end
	def loop2 (lista_pares_iterando, lista_pares_transitivos, x1, y1) do
		lista_pares_transitivos = union (lista_pares_transitivos, lista_pares_iterando)
		[first|rest] = lista_pares_iterando
		x2 = Utils.getx(first)
		y2 = Utils.gety(first)
		
		condicao = (x2==y1) && (Utils.belongs([x1, y2], lista_pares_transitivos) == false)
		if condicao? do
			lista_pares_transitivos = Utils.union (lista_pares_transitivos, [[x1, y2]])
			lista_pares_transitivos = transitive_closure(lista_pares_transitivos)
		end
		lista_pares_transitivos = Transitive.loop2(rest, lista_pares_transitivos, x1, y1)
	end
end


lista_elementos = [1,2,3]
lista_pares = [[1,2], [2,3], [2,1], [3,2]]
resp = Utils.transitive_closure(lista_pares)
IO.inspect resp, label: "The hope is"


