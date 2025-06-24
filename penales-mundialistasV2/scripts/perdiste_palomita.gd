extends Control
@onready var mostrarPuntos: Label = $Label

func _ready() -> void:
	_on_mostrarPuntaje()

func _on_mostrarPuntaje():

		mostrarPuntos.text= "PUNTUACION TOTAL %03d" % Global.puntoPalomita

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
