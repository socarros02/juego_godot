extends Control
@onready var input_nombre: LineEdit = $LineEdit

func _ready():
	input_nombre.text = Global.nombre 
	input_nombre.max_length = 10

# Función para guardar el nombre al presionar el botón
func _on_button_pressed() -> void:
	var nombre_ingresado = input_nombre.text.strip_edges()
	if nombre_ingresado != "":
		Global.nombre = nombre_ingresado
		print("Nombre guardado en Global:", Global.nombre)
		if Global.modo == 1:
			get_tree().change_scene_to_file("res://Escenas/arcade.tscn")
		else:
			get_tree().change_scene_to_file("res://Escenas/tutorial_palomita.tscn")
		# Opcional: cambiar de escena o mostrar mensaje
	else:
		print("⚠️ Ingrese un nombre válido")
