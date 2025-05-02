extends Node2D
@onready var mostrarPuntos: Label = $mostrarPuntos


var contador=0

var puntosActuales=0

var faseActual=1 

var vidas=2


var arribaIzq=Vector2(300, 267)

var arribaMedio=Vector2(552, 264)

var arribaDerecha=Vector2(780, 265)

var abajoIzq=Vector2(298, 439)

var abajoMedio=Vector2(551, 432)

var abajoDer=Vector2(784, 416)


var puntoPenal= Vector2(547, 557)
const faseMaxima=4

func _on_arriba_izquierda_pressed() -> void:
	moverPelota(0)
	tiro(1)
	
func _on_arriba_medio_pressed() -> void:
	moverPelota(1)
	tiro(2)

func _on_arriba_derecha_pressed() -> void:
	moverPelota(2)
	tiro(3)

func _on_abajo_izquierda_pressed() -> void:
	moverPelota(3)
	tiro(4)

func _on_abajo_medio_pressed() -> void:
	moverPelota(4)
	tiro(5)

func _on_abajo_deecha_pressed() -> void:
	moverPelota(5)
	tiro(6)

func moverPelota(lugar):
	var posicion=lugar
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	var ball = $ball
	var button = opciones[lugar]
	var button_center= button.global_position+ button.size/2
	var tween = get_tree().create_tween()
	tween.tween_property(ball, "global_position", button_center, 0.2)

func tiro(pat):
	var gol
	gol = ataja(pat,faseActual,vidas)
	if gol==1:
		puntosActuales=puntos(faseActual,puntosActuales)
		faseActual=fase(contador,faseActual)
		contador=contadorFunc(contador)
		_on_mostrarPuntaje(puntosActuales)
		print("gol!!!|puntos:%d|fase %d|"%[puntosActuales,faseActual])
		ACTIVAR_GOL(pat,gol)
		
	else:
		print("atajo el aquero|puntos:%d|fase %d|"%[puntosActuales,faseActual])
		vidas = vidas -1
		penalAtajado(pat,gol)
		if vidas<0:
			get_tree().change_scene_to_file("res://Escenas/menu.tscn")
		
	
func _on_mostrarPuntaje(puntos):
	mostrarPuntos.text= "%03d" % puntos
	

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

func ataja(tiro,fase,vida):
	var gol
	var opciones =[1,2,3,4,5,6]
	var vidas=[$vidas/corazon3,$vidas/corazon2,$vidas/corazon1]
	opciones.shuffle()
	for i in range(fase):
			if tiro == opciones[i]:
				gol=0
				vidas[vida].visible=false
				break
			else:
				gol=1
	return gol


		
func _on_timer_timeout() -> void:
	$animacion.visible=false
	$atajo.visible=false
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=false
	$ball.global_position=puntoPenal
	$arqueroEstatico.visible=true
	$arqueroMovDer.visible=false
	

func ACTIVAR_GOL(pat,gol):
	$animacion.visible=true
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=true
	moverArquero(pat,gol)
	$Timer.start()
	
func penalAtajado(pat,gol):
	$atajo.visible=true
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=true
	moverArquero(pat,gol)
	$Timer.start()

func moverArquero(tiro,gol):
	$arqueroEstatico.visible=false

	var mover=[arribaIzq,arribaMedio,arribaDerecha,abajoIzq,abajoMedio,abajoDer]
	tiro =tiro-1
	if gol==1:
		tiro=tiro-2
		if tiro<0:
			tiro=tiro+4
		
	$arqueroMovDer.visible=true
	$arqueroMovDer.position=mover[tiro]
			
