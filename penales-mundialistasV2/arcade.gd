extends Node2D
var contador=0
var puntosActuales=0
var faseActual=1 
const faseMaxima=4
func _ready():
	print("Juego listo para jugar, esperando tiro")

func _on_button_pressed() -> void:
	tiro(1)


func _on_button_2_pressed() -> void:
	tiro(2)


func _on_button_3_pressed() -> void:
	tiro(3)


func _on_button_4_pressed() -> void:
	tiro(4)


func _on_button_5_pressed() -> void:
	tiro(5)


func _on_button_6_pressed() -> void:
	tiro(6)

func tiro(pat):
	var gol
	gol = ataja(pat,faseActual)
	if gol==1:
		
		contador=contadorFunc(contador)
		puntosActuales=puntos(faseActual,puntosActuales)
		faseActual=fase(contador,faseActual)
		
		print("gol!!!|puntos:%d|fase %d|"%[puntosActuales,faseActual])
	else:
		print("atajo el aquero|puntos:%d|fase %d|"%[puntosActuales,faseActual])
		get_tree().change_scene_to_file("res://menu.tscn")

func contadorFunc(contador):
	contador=contador+1
	if contador%4==0:
		contador=1
	return contador	
func fase(contador,fase):
	var faseactual=fase
	if contador % 3 == 0 && faseactual < faseMaxima:
		faseactual=faseactual+1
	return faseactual
	
func puntos(fase,puntos):
	var puntaje = puntos
	puntaje=fase*15+puntaje
	return puntaje

func ataja(tiro,fase):
	var gol
	var opciones =[1,2,3,4,5,6]
	opciones.shuffle()
	for i in range(fase):
			if tiro == opciones[i]:
				gol=0
				for x in range(fase):
					print(opciones[x])
				break
			else:
				gol=1
				
	return gol
	
