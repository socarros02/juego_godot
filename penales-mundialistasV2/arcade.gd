extends Node2D

var contador=0
var puntosActuales=0
var faseActual=1 
var puntoPenal:= Vector2(547, 557)
const faseMaxima=4
func _ready():
	print("Juego listo para jugar, esperando tiro")
	var puntoPenal = $ball.global_position
func _on_button_pressed() -> void:
	moverPelota(0)
	tiro(1)

func _on_button_2_pressed() -> void:
	moverPelota(1)
	tiro(2)

func _on_button_3_pressed() -> void:
	moverPelota(2)
	tiro(3)

func _on_button_4_pressed() -> void:
	moverPelota(4)
	tiro(4)

func _on_button_5_pressed() -> void:
	moverPelota(5)
	tiro(5)

func _on_button_6_pressed() -> void:
	moverPelota(6)
	tiro(6)
	
func moverPelota(lugar):
	var posicion=lugar
	var opciones=[$Button,$Button2,$Button3,$Button3,$Button4,$Button5,$Button6]
	var ball = $ball
	var button = opciones[lugar]
	var button_center= button.global_position+ button.size/2
	var tween = get_tree().create_tween()
	tween.tween_property(ball, "global_position", button_center, 0.2)

func tiro(pat):
	var gol
	
	gol = ataja(pat,faseActual)
	if gol==1:
		puntosActuales=puntos(faseActual,puntosActuales)
		faseActual=fase(contador,faseActual)
		contador=contadorFunc(contador)
		print("gol!!!|puntos:%d|fase %d|"%[puntosActuales,faseActual])
		$ball.global_position=puntoPenal
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
	if contador == 3 && faseactual < faseMaxima:
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
				break
			else:
				gol=1
	return gol
	
