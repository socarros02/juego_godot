extends Control
@onready var mostrarPuntos: Label = $puntos

func _ready() -> void:
	_on_mostrarPuntaje()

func _on_mostrarPuntaje():
	mostrarPuntos.text= "Puntuacion total %03d" % Global.puntosActuales
func _on_volver_al_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	
