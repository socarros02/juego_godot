extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/arcade.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/tutorial_palomita.tscn")

func _on_tabla_posiciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/tabla_posiciones.tscn")
