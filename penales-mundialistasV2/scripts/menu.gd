extends Control
func _ready() -> void:
	$musicaFondo.play()

func _on_button_pressed() -> void:
	Global.modo = 1
	get_tree().change_scene_to_file("res://Escenas/ingresar_nombre.tscn")

func _on_button_2_pressed() -> void:
	Global.modo = 2
	get_tree().change_scene_to_file("res://Escenas/ingresar_nombre.tscn")

func _on_tabla_posiciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/top10.tscn")
