import wollok.game.*
import clases.*
import piezas.*
import gameManager2.*


object tetrisGame {
	
	var pieza //Guarda la abstraccion de la pieza activa
	var piezaSiguiente //Referencia a la pieza siguiente
	var ultimoTiro = 0 //Distancia de la cual se tiro una pieza por ultima vez
	var velocidad = 0 //Velocidad actual del juego
	var alturaMax = 1 //Altura del bloque mas alto
	var derrota = false

	

	//Inicia la logica
	method play(){
		game.clear()
		
		derrota = false
		alturaMax = 1
		
		self.crearParedes()
		self.nuevaPiezaSiguiente()
		self.nuevaPieza()
		self.iniciarControles()
		game.onTick(750, "bajar pieza",{ self.bajarPieza()})
	}
	
	//Metodo que instancia una nueva pieza
	// Clase generador de piezas con estos dos métodos:
	method nuevaPieza(){
		if(alturaMax<20){
			pieza = piezaSiguiente
			pieza.mover(-9, 2)
			self.nuevaPiezaSiguiente()
		}else{self.activarDerrota()}
	}
	
	method nuevaPiezaSiguiente(){
		const listaNumeros = [1,2,3,4,5]
		var numero = listaNumeros.anyOne()
		//console.println(numero)}
		// Agregar una tercera opción



		if(numero==1){
			piezaSiguiente = new PiezaLoca()
		}else if(numero==2){
			piezaSiguiente = new PiezaGiroInvertido()
		}else{piezaSiguiente = new Pieza()}
		
		
		piezaSiguiente.instanciar(piezas.randomPieza(), 14 ,18)
	}
	
	method crearParedes(){
		//Inicio paredes del campo de juego
		 (0 .. 23).forEach({i => 
		 	game.addVisual(new Bloque(position = game.at(0,i), activo = false))
		 	game.addVisual(new Bloque(position = game.at(11,i), activo = false))
		 	//Genera paredes fuera del area visible pero no importa
		 	game.addVisual(new Bloque(position = game.at(i,0), activo = false))
		 })	 
	}

	
	//Desactiva la pieza cuando cae
	method desactivarPieza(){
		//obtengo las filas que abarca la pieza
		const filas = pieza.filasActivas()		
		pieza.desactivar()	
		//veo si hace falta modifica el bloque mas alto
		if(filas.max() > alturaMax){ alturaMax = filas.max() }	
		//me fijo que filas de las que abarcaba la pieza tengo que eliminar
		self.eliminarFilas(filas)
		//siempre que se desactivo una pieza debe activarse otra
		self.nuevaPieza()
	}

	
	//Metodo que se fija que filas fueron afectadas cuando cae una pieza, y borra las que sea necesario borrar. Despues invoca reacomodarFilas para bajar las que esten arriba
	method eliminarFilas(filas){
		//me guardo que filas tengo que eliminar
		const filasEliminadas = []
		
		self.posibleFilaQueSacar(filas, filasEliminadas)
		
		// acelero el juego
		self.acelerar(filasEliminadas.size() * 3)
		// necesito bajar las filas de arriba
		if(filasEliminadas.size() > 0){ self.reacomodarFilas(filasEliminadas) }		
		// sumo los puntos
		puntaje.sumarPuntos(ultimoTiro, velocidad, filasEliminadas.size())	
	}
	
	method posibleFilaQueSacar(filas, filasEliminadas){
		
		filas.forEach({fila =>	
			//por cada fila potencial me fijo si la tengo que eliminar
			// sacar a método: tengo que eliminar fila?
			var eliminar = true
			
			(1 .. 11).forEach({i =>
				//me fijo que cada casillero tenga algo
				if(game.getObjectsIn(game.at(i, fila)).isEmpty()){eliminar = false}//hay por lo menos un casillero vacio, no elimino			
			})
			
			if(eliminar){self.eliminar(fila, filasEliminadas)}
				// Eliminar fila
		})	
	}
	
	method eliminar(fila, filasEliminadas){
		filasEliminadas.add(fila)
		(1 .. 10).forEach({i =>
		//elimino los bloques
			game.getObjectsIn(game.at(i, fila)).forEach({bloque => bloque.eliminar()})		
		})
	}


	//Metodo que, cuando se eliminan filas reacomoda las filas de arriba para recompactar el tablero
	method reacomodarFilas(filasAEliminar){
		var bias = 1
		const size = filasAEliminar.size()
		//Empiezo desde filaElim (que es la fila mas baja a eliminar), la saco afuera del forEach porque no la puedo sacar una vez adentro
		var filaElim = filasAEliminar.min()
		filasAEliminar.remove(filasAEliminar.min())
		//Me fijo todas las filas desde la fila a reubicar mas baja + 1 hasta la fila mas alta
		(filaElim + 1 .. alturaMax).forEach({fila =>		
			
			if(filasAEliminar.size() > 0){ filaElim = filasAEliminar.min() }				
			if(filaElim == fila){
				//Si la fila minima que queda dentro de "filasAEliminar" es en la que estoy parado, la saco de filasAEliminar y sumo 1 al bias
				bias += 1
				filasAEliminar.remove(filasAEliminar.min())
			}else{
				//console.println("Reubico fila " + fila + "con un bias de " + bias)
				//Si la fila no es la misma, tengo que reubicar, y la reubico por el bias (si saltee 1 fila, lo muevo 1 abajo, si saltee 3, muevo 3 abajo)
				(1 .. 10).forEach({columna =>
					game.getObjectsIn(game.at(columna, fila)).forEach({bloque =>
						bloque.mover(0, -bias)
					})
				})
			}			
			//Reubico, si es una fila eliminada no reubico ya que no hay nada para reubicar, sumo 1 al bias y voy a la siguiente fila	
		})
		alturaMax -= size
	}
	
	
	//Acelera la velocidad del juego
	method acelerar(dif){
		velocidad += dif
		game.removeTickEvent("bajar pieza")
		game.onTick(750 - velocidad, "bajar pieza",{ self.bajarPieza() })
	}
	
	
	//Metodo que se invoca por tick de "bajar pieza"
	method bajarPieza(){
		if(pieza.ver(0, -1)){
			pieza.mover(0, -1)
		}else{
			self.desactivarPieza()
		}
	}
	
	
	//Inicia los controles de la pieza
	method iniciarControles(){
		
		self.iniciarTeclaIzquierda_Derecha()

		keyboard.up().onPressDo{ pieza.girar() }		
		keyboard.down().onPressDo{ self.bajarPieza() }
		keyboard.space().onPressDo{ self.bajarConBarraEspaciadora()	}
		keyboard.m().onPressDo{ self.activarDerrota() }
	}
	
	
	method bajarConBarraEspaciadora(){
		const bloqueMasBajo = pieza.bloqueMasBajo() 
		if(bloqueMasBajo > alturaMax){
			pieza.mover(0, -(bloqueMasBajo - alturaMax) + 1)	
		}
		ultimoTiro = pieza.encontrarFondo()
		pieza.mover(0, ultimoTiro)
		self.desactivarPieza()	
	}
	
	method iniciarTeclaIzquierda_Derecha(){
		keyboard.left().onPressDo {
			if(pieza.ver(-1, 0)){
				pieza.mover(-1, 0)
			}
		}
		keyboard.right().onPressDo {
			if(pieza.ver(1, 0)){
				pieza.mover(1, 0)
			}
		}
	}
	
	//Metodo que se invoca cuando la nueva pieza que entra se superpone con un bloque ya existente
	method activarDerrota(){
		console.println("PERDISTE")
		console.println("Tu puntaje total fue: " + puntaje.puntos())
		derrota = true
		puntaje.resetearPuntos()

		self.cerrarJuego()
	}
	
	
	method cerrarJuego() {
		game.clear()
		gameManager.mostrarMenu()
	}
	
}


object puntaje{
	var property puntos = 0
	method sumarPuntos(ultimoTiro, velocidad, lineasEliminadas){
		puntos += (ultimoTiro.abs() + velocidad) * (lineasEliminadas + 1)
		console.println(puntos)
	}
	method resetearPuntos(){
		puntos = 0
	}
}