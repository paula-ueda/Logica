
defmodule Utils do
	def notTerminal(palavra) do
		aux = String.downcase(palavra)
		if aux == palavra do
			res = false
		else
			res = true
		end
		res
	end

	def findNext(palavra, regras, tamanho) do
		Substitui.loop(palavra, regras, tamanho, [])
	end
end



defmodule Substitui do
	def loop(palavra, regras, tamanho,  respostas) when length(regras)<=0 do
		respostas
	end
	def loop(palavra, regras, tamanho, respostas) do
		[first|rest] = regras
		
		res = String.replace(palavra, Enum.at(first, 0), Enum.at(first, 1))

		if String.length(res)<=tamanho do
			respostas = Enum.concat(respostas, [res]) |> Enum.uniq
		end
		Substitui.loop(palavra, rest, tamanho, respostas)
		
	end
end

defmodule Funcao2 do
	def loop(lista, regras, tamanho, resultado) when length(lista) <= 0 do
		resultado
	end 
	def loop(lista, regras, tamanho, resultado) do
		[first|rest] = lista
		if Utils.notTerminal(first) do
			res = Utils.findNext(first, regras, tamanho)
			if length(res)>0 do
				rest = Enum.concat(rest, res) |> Enum.uniq	
				resultado = Enum.concat(resultado, res) |> Enum.uniq			
			end
			
		end

		Funcao2.loop(rest, regras, tamanho, resultado)		
	end
end


defmodule Funcao1 do
	def loop(lista) when length(lista) <= 0 do
		lista
	end 
	def loop(lista) do
		[first|rest] = lista
		IO.puts (Funcao1.loop(rest))
		first
	end
end


defmodule Terminais do
	def loop(lista, resultado) when length(lista)<= 0 do
		resultado
	end
	def loop(lista, resultado) do
		[first|rest] = lista
		if Utils.notTerminal(first) == false do
			resultado = Enum.concat(resultado, [first])
		end
		Terminais.loop(rest, resultado)
	end
end

IO.puts "PCS3856 - EP1: Fecho transitivo e reflexivo\n\n
  Damaris Andreia Cardona   8471348
  Paula Ueda                8042482\n
---------------------------------------------\n"
palavra = "aaaaaa"
tamanho = String.length(palavra)

raiz = ["S"]
regras = [["S", "a"], ["S", "aS"]]

todas = Funcao2.loop(raiz, regras, tamanho, raiz)
terminais = Terminais.loop(todas, [])
l = "Cadeias terminais com até o comprimento da palavra"
IO.inspect terminais, label: l

if Enum.member?(terminais, palavra) == true do

	IO.puts "A palavra " <> palavra <> " eh gerada pela gramatica!"
end
