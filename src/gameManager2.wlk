import wollok.game.*

import tetrisGame.tetris.tetrisGame

 object gameManager {
 	const cellsize = 40 // pixeles
	const height = 22 // en celdas
	const width = 23 // en celdas
	
	const piecelen = 120 // pixeles de ancho de cada piecita (15puzzle)
 	
 	method inicializar() {
		game.cellSize(cellsize)
		game.height(height)
		game.width(width)
		game.boardGround("img/fondoCorto.png")
		game.title("TETRIS")
 	}
 	
 	method mostrarMenu() {
 		game.clear()
 		if (!game.hasVisual(home)) game.addVisual(home)
 		// Eventos para iniciar cada juego
 		keyboard.s().onPressDo {

 		//tetrisGame.showMenu()
 		}
 		keyboard.j().onPressDo {
			tetrisGame.play()
		}
		keyboard.c().onPressDo {
			self.menuControles()
		}
		keyboard.v().onPressDo {
			self.menuHome()
		}
 	}
 	
 	method menuControles() {
 		game.removeVisual(home)
 		game.addVisual(controles)
 	}
 	method menuHome(){
 		if (!game.hasVisual(home)){
 			game.removeVisual(controles)
 			game.addVisual(home)
 		}
 	}
 }

object home {
	const property image = "img/home.png"
	const property position = game.at(-7, 0)
}
object controles {
	const property image = "img/controles1.png"
	const property position = game.at(0, 0)
}
