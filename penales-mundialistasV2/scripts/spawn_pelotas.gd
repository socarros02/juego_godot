extends Node2D

var puntaje = 0
var posicion = 0
var vida=3

@onready var corazones= [$vidas/corazon1,$vidas/corazon2,$vidas/corazon3]
@onready var pelotas = [$pelota, $pelota2, $pelota3,$pelota4,$pelota5,$pelota6]
@onready var spawns = [
	Vector2(1300,150),
	Vector2(1300,500),
	Vector2(1300,450),
	Vector2(1300,350)
]
@onready var mostrarPuntos: Label = $puntaje

func _ready():
	
	for pelota in pelotas:
		if pelota:
			pelota.connect("pelota_cabeceada", Callable(self, "_on_pelota_cabeceada"))
			pelota.connect("restarVida", Callable(self, "_on_restarVida")) 

	
func _on_restarVida():
	vida -= 1
	corazones[vida].visible=false
	if vida <= 0:
		$gameOver.visible=true
		$Timer.stop()
		$muerte.start()
func _on_pelota_cabeceada():
	puntaje += 20
	Global.puntoPalomita=puntaje
	mostrarPuntos.text = "%03d" % puntaje
	if puntaje==140:
		$Timer.wait_time=2.0


func _on_timer_timeout() -> void:
	var spawn_index = randi() % spawns.size()
	var spawn_pos = spawns[spawn_index]

	var pelota = pelotas[posicion]
	pelota.position = spawn_pos
	pelota.visible = true
	pelota.activa = true

	posicion += 1
	if posicion >= pelotas.size():
		posicion = 0


func _on_muerte_timeout() -> void:
	get_tree().change_scene_to_file("res://Escenas/perdistePalomita.tscn")
