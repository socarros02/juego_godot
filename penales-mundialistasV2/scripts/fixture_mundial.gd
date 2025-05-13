extends Node2D

@onready var banderaSeleccionada= $argentina
@onready var banderas = [banderaSeleccionada, $alemania, $brasil, $colombia,$españa, $francia, $italia, $portugal]
@onready var cuartosFinal= [$cuartos1,$cuartos2,$cuartos3,$cuartos4,$cuartos5,$cuartos6,$cuartos7,$cuartos8]
@onready var semiFInal= [$semis1,$semis2,$semis3,$semis4]

var asignarCuarto=[]
var fase = 2
var penalConveritdo=0
var penalRecibido=0


func desabilitarPenales():
	var opciones=[$patear/arribaIzquierda,$patear/arribaMedio,$patear/arribaDerecha,$patear/abajoIzquierda,$patear/abajoMedio,$patear/abajoDerecha]
	for i in range(6):
		opciones[i].disabled=true
	$penales.visible=false
func habilitarBotones():
	var opciones=[$patear/arribaIzquierda,$patear/arribaMedio,$patear/arribaDerecha,$patear/abajoIzquierda,$patear/abajoMedio,$patear/abajoDerecha]
	for i in range(6):
		opciones[i].disabled=false
	$penales.visible=true
		
func numeroRandom(random):
	random=randi()%50+1
	return random

func _ready() -> void:
	asignarPosicion(asignarCuarto)
	desabilitarPenales()

func asignarPosicion(asignarcuarto):
	asignarCuarto.resize(8)
	banderas.shuffle()
	for i in range(banderas.size()):
		asignarCuarto[i] = banderas[i]
		var marker = cuartosFinal[i]
		asignarCuarto[i].get_parent().remove_child(asignarCuarto[i])
		marker.add_child(asignarCuarto[i])        
		asignarCuarto[i].position = Vector2.ZERO
	return asignarCuarto

func posicionSemifinal():
	var x = 0
	var y = 1
	var random
	
	for i in range(4):
		var cuartosArriba = asignarCuarto[x]
		var cuartosAbajo = asignarCuarto[y]
		var semis= semiFInal[i]
		random=numeroRandom(random)
		if cuartosAbajo== banderaSeleccionada or cuartosArriba == banderaSeleccionada:
			var tiro=0
			patear(tiro,fase)
		else:
			if random<=25:
				cuartosArriba.get_parent().remove_child(cuartosArriba)
				semis.add_child(cuartosArriba)
			else:
				cuartosAbajo.get_parent().remove_child(cuartosAbajo)
				semis.add_child(cuartosAbajo)
		x=x+2
		y=y+2
	


func _on_continuar_pressed() -> void:
	posicionSemifinal()
	
func patear(tiro,fase):
	var gol
	var opciones =[1,2,3,4,5,6]
	opciones.shuffle()
	for i in range(fase):
			if tiro == opciones[i]:
				gol=0
				break
			else:
				gol=1
	return gol


func _on_arriba_izquierda_pressed() -> void:
	pass # Replace with function body.


func _on_arriba_medio_pressed() -> void:
	pass # Replace with function body.


func _on_arriba_derecha_pressed() -> void:
	pass # Replace with function body.


func _on_abajo_izquierda_pressed() -> void:
	pass # Replace with function body.


func _on_abajo_medio_pressed() -> void:
	pass # Replace with function body.


func _on_abajo_derecha_pressed() -> void:
	pass # Replace with function body.
