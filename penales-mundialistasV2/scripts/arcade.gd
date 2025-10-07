extends Node2D

@onready var mostrarPuntos: Label = $mostrarPuntos
@onready var pausaPotencia = $potencia

func activarBotones():
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=false

func desactivarBotones():
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=true

var is_paused = false

var valor_actual

##barra de potencia
func _process(delta):
	if is_paused:
		return
	if $potencia.value < $potencia.max_value:
		$potencia.value += 75* faseActual * delta
		valor_actual=$potencia.value
	if $potencia.value >= $potencia.max_value:
		$potencia.value = $potencia.min_value
	actualizar_color_barra()
	if Input.is_action_just_pressed("PAUSA"):
		_on_menu_button_pressed()
		$MenuButton.show_popup()

var tuto=0

func _ready() -> void:
	desactivarBotones()
	var menu= $MenuButton
	menu.get_popup().id_pressed.connect(_on_menu_option_selected)
	


##pasar tutorial

func _on_siguiente_pressed() -> void:
	var tutorial=[$objetivo,$comoJugar,$ganarPuntos,$perderPuntos]
	tutorial[tuto].visible=false
	tuto +=1
	if tuto<4:
		tutorial[tuto].visible=true
	if tuto==4:
		$siguiente.disabled=false
		$omitir.disabled=false
		$siguiente.visible=false
		$omitir.visible=false
		$potencia.visible=true
		$vidas.visible=true
		activarBotones()
		$MenuButton.visible=true
func _on_omitir_pressed() -> void:
	var tutorial=[$objetivo,$comoJugar,$ganarPuntos,$perderPuntos]
	for i in range(4):
		tutorial[i].visible=false
	$siguiente.disabled=false
	$omitir.disabled=false
	$siguiente.visible=false
	$omitir.visible=false
	$potencia.visible=true
	$vidas.visible=true
	activarBotones()
	$MenuButton.visible=true
	

var contador=0

var puntosActuales=0

var faseActual=1 

var vidas=2

##posiciones del arquero
var arribaIzq=Vector2(300, 267)
var arribaMedio=Vector2(552, 264)
var arribaDerecha=Vector2(780, 265)
var abajoIzq=Vector2(298, 439)
var abajoMedio=Vector2(551, 432)
var abajoDer=Vector2(784, 416)

##posiicon de pelota
var puntoPenal= Vector2(547, 557)

const faseMaxima=3

func _on_arriba_izquierda_pressed() -> void:
	moverPelota(0)
	tiro(1,valor_actual)
	
func _on_arriba_medio_pressed() -> void:
	moverPelota(1)
	tiro(2,valor_actual)

func _on_arriba_derecha_pressed() -> void:
	moverPelota(2)
	tiro(3,valor_actual)

func _on_abajo_izquierda_pressed() -> void:
	moverPelota(3)
	tiro(4,valor_actual)

func _on_abajo_medio_pressed() -> void:
	moverPelota(4)
	tiro(5,valor_actual)

func _on_abajo_deecha_pressed() -> void:
	moverPelota(5)
	tiro(6,valor_actual)

##mueve la pelota al lugar que clickeo el usuario con un array de los botones para que vayan al centro de los mismos
func moverPelota(lugar):
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	var ball = $ball
	var button = opciones[lugar]
	var button_center= button.global_position+ button.size/2
	var tween = get_tree().create_tween()
	tween.tween_property(ball, "global_position", button_center, 0.2)

##logica para contar vidas, puntaje y fase
func tiro(pat,potencia):
	var gol
	gol = ataja(pat,faseActual,vidas,potencia)
	if gol==1:
		puntosActuales=puntos(faseActual,puntosActuales)
		faseActual=fase(contador,faseActual)
		contador=contadorFunc(contador)
		_on_mostrarPuntaje(puntosActuales)
		ACTIVAR_GOL(pat,gol)
		
	else:
		Global.puntosActuales=puntosActuales
		vidas = vidas -1
		penalAtajado(pat,gol)
		
	
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

##funcion que retorna al la logica de vidas etc el 1 o 0 segun si la pelota entro o no a gol
func ataja(tiro,fase,vida,potencia):
	var gol=1
	var opciones =[1,2,3,4,5,6]
	var vidas=[$vidas/corazon3,$vidas/corazon2,$vidas/corazon1]
	opciones.shuffle()
	fase = fase + 1
	if potencia< 30:
		fase = fase+1
	elif potencia>75:
		fase = fase - 1


	for i in range(fase):
		if tiro == opciones[i]:
			gol=0
			vidas[vida].visible=false
	
	if potencia>90:
		gol=1
	
	return gol


##al terminar el timer del tiro vuelve todo a ser funcional
func _on_timer_timeout() -> void:
	$animacion.visible=false
	$atajo.visible=false
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=false
	$ball.global_position=puntoPenal
	$arqueroEstatico.visible=true
	$arqueroMovDer.visible=false
	$arqueroMovDer.flip_h=false
	$gol.stop()
	$abucheos.stop()
	is_paused=false
	if vidas<0:
			get_tree().change_scene_to_file("res://Escenas/perdiste_arcade.tscn")

##las proximas 2 funciones desbilitan los botones por un tiempo para no seguir jugando hasta que pase la animacion
func ACTIVAR_GOL(pat,gol):
	$animacion.visible=true
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=true
	$gol.play()	
	moverArquero(pat,gol)
	is_paused=true
	$Timer.start()

func penalAtajado(pat,gol):
	$atajo.visible=true
	var opciones=[$GridContainer/arribaIzquierda,$GridContainer/arribaMedio,$GridContainer/arribaDerecha,$GridContainer/abajoIzquierda,$GridContainer/abajoMedio,$GridContainer/abajoDeecha]
	for i in range(6):
		opciones[i].disabled=true
	$abucheos.play(1.0)
	moverArquero(pat,gol)
	is_paused=true
	$Timer.start()

##mueve al arquero si es gol a un lugar donde no va la pelota y si no es gol hacia la pelota
func moverArquero(tiro,gol):
	$arqueroEstatico.visible=false

	var mover=[arribaIzq,arribaMedio,arribaDerecha,abajoIzq,abajoMedio,abajoDer]
	tiro =tiro-1
	var tiroRandom = tiro
	if gol==1:
		while tiro == tiroRandom:
			tiroRandom = randi() % 6
	tiro = tiroRandom
	if tiro == 0 or tiro == 3:
		$arqueroMovDer.flip_h=true
	$arqueroMovDer.visible=true
	$arqueroMovDer.position=mover[tiro]

##cambiar los colores de la barra de potencia
func actualizar_color_barra():
	var percent = $potencia.value / $potencia.max_value  
	var color:Color
	if percent < 0.5:
		color = Color(1,percent*2,0)
	else:
		color= Color(1-(percent-0.5)*2,1,0)
	
	var style = $potencia.get("theme_override_styles/fill")
	if style:
		style.bg_color=color


func _on_menu_button_pressed() -> void:
	desactivarBotones()
	is_paused=true

func _on_menu_option_selected(id):
	match id:
		0:
			activarBotones()
			is_paused=false
		1:
			get_tree().change_scene_to_file("res://Escenas/menu.tscn")
