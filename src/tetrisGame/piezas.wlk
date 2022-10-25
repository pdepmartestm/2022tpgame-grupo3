import wollok.game.*
import clases.*

object piezas{
	const coleccionPiezas = [piezaL,piezaLInvertido,piezaS,piezaSInvertido,piezaT,piezaCuadrado,piezaLargo, piezaP]
	
	method randomPieza() = coleccionPiezas.get(0.randomUpTo(coleccionPiezas.size()).roundUp() - 1)		
}

object piezaL{
	
	var property color = "naranja.png"
	
	method instanciar(x, y){
		const bloquesActivos = []	
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1,y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1,y-1), image = color))
		return bloquesActivos
	}
}

object piezaCuadrado{
	var property color = "amarillo.png"

	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x,y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y), image = color))
		return bloquesActivos
	}
}

object piezaLargo{
	var property color = "celeste.png"

	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+2), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y-1), image = color))
		return bloquesActivos
	}
}
object piezaLInvertido{
	var property color = "azul.png"
	
	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y+1), image = color))
		return bloquesActivos
	}
}
object piezaT{
	var property color = "violeta.png"	
	
	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		return bloquesActivos
	}
}
object piezaS{
	var property color = "verde.png"
	
	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		return bloquesActivos
	}
}
object piezaSInvertido{
	var property color = "rojo.png"
	
	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1, y), image = color))
		return bloquesActivos
	}
}

object piezaP{
	var property color = "MEGAnaranja.png"

	method instanciar(x, y){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x,y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y), image = color))
		//bloquesActivos.add(new Bloque(position = game.at(x, y-2), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y-1), image = color))
		return bloquesActivos
	}
}
