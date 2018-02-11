
defmodule Utils do
	def belongs(par, conjunto) do
		Enum.member?(conjunto, par)
	end
	def findAllElements(lista_pares) do
		Elements.loop1(lista_pares, [])
	end
	def getx(par) do
		Enum.at(par, 0)
	end
	def gety(par) do
		Enum.at(par, 1)
	end
	def union(a, b) do
		Enum.concat(b, a) |> Enum.uniq
	end

end

defmodule Closure do
	def reflexive(lista_pares) do
		lista_pares_reflexivos = Reflexive.loop1(Utils.findAllElements(lista_pares), [])
		Utils.union(lista_pares, lista_pares_reflexivos)
	end
	def transitive(lista_pares) do
		lista_pares_transitivos = Transitive.loop1(lista_pares, [])
		lista_pares_transitivos
	end
	def reflexive_transitive(lista_pares) do
		aux = Closure.reflexive(lista_pares)
		Enum.sort(Closure.transitive(aux))
	end
end


defmodule Elements do
	def loop1(lista_pares, lista_elementos) when length(lista_pares) <= 0 do
		lista_elementos
	end 
	def loop1(lista_pares, lista_elementos) do
		[first|rest] = lista_pares
		x = Utils.getx(first)
		y = Utils.gety(first)
		lista_elementos = Utils.union(lista_elementos, [x,y])
		lista_elementos = loop1(rest, lista_elementos)
	end
end

defmodule Reflexive do
	def loop1(lista_elementos, lista_pares_reflexivos) when length(lista_elementos) <=0 do
		lista_pares_reflexivos
	end
	def loop1(lista_elementos, lista_pares_reflexivos) do
		[first|rest] = lista_elementos
		lista_pares_reflexivos = Utils.union(lista_pares_reflexivos, [[first, first]])
		lista_pares_reflexivos = Reflexive.loop1(rest, lista_pares_reflexivos)
		lista_pares_reflexivos
	end
end

defmodule Transitive do
	def loop1(lista_pares, lista_pares_transitivos) when length(lista_pares) <= 0 do
		lista_pares_transitivos
	end 
	def loop1(lista_pares, lista_pares_transitivos) do
		lista_pares_transitivos = Utils.union(lista_pares, lista_pares_transitivos)
		[first|rest] = lista_pares
		x1 = Utils.getx(first)
		y1 = Utils.gety(first)
		lista_pares_transitivos = Transitive.loop2(lista_pares_transitivos, [], x1, y1)
		lista_pares_transitivos = Transitive.loop1(rest, lista_pares_transitivos)
	end
	def loop2(lista_pares_iterando, lista_pares_transitivos, x1, y1) when length(lista_pares_iterando) <= 0 do
		lista_pares_transitivos
	end
	def loop2(lista_pares_iterando, lista_pares_transitivos, x1, y1) do
		lista_pares_transitivos = Utils.union(lista_pares_iterando, lista_pares_transitivos)
		[first|rest] = lista_pares_iterando
		x2 = Utils.getx(first)
		y2 = Utils.gety(first)
		
		condicao = (x2==y1) && (Utils.belongs([x1, y2], lista_pares_transitivos) == false)
		if condicao do
			lista_pares_transitivos = Utils.union(lista_pares_transitivos, [[x1, y2]])
			lista_pares_transitivos = Closure.transitive(lista_pares_transitivos)
		end
		lista_pares_transitivos = Transitive.loop2(rest, lista_pares_transitivos, x1, y1)
	end
end

defmodule GetData do
	def oneByOne(contador, conjunto) do
		input = IO.gets "Par " <> to_string(contador) <> ":\n"
		if input != "end\n" do

			if input =~ " " do
				contador = contador+1
				input = String.replace(input, "\n", "")
				par = String.split(input, " ")

				conjunto = Utils.union([par], conjunto)
			else
				conjunto = conjunto
				IO.puts "Verifique se está no formato correto"	
			end

			conjuto = GetData.oneByOne(contador, conjunto)

		else
			conjunto = conjunto
		end
	end
		def fromConsole() do
		contador = 0

		IO.puts "Insira os pares ordenados do conjunto desejado um a um como nos exemplos abaixo:\n1 2\n3 5\n7 9\nQuando desejar parar de escrever insira 'end'!\n\n"
		conjunto = GetData.oneByOne(contador, [])
		IO.inspect conjunto, label: "Input"
		conjunto
	end

end


IO.puts "PCS3856 - EP1: Fecho transitivo e reflexivo\n\n
  Damaris Andreia Cardona   8471348
  Paula Ueda                8042482\n
---------------------------------------------\n"
lista_pares = GetData.fromConsole()

resp = Closure.reflexive_transitive(lista_pares)
IO.inspect resp, label: "Resultado"
