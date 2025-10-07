extends Node2D


@onready var contenedor = $contenedorPenales
@onready var contenedor2 = $contenedorPenales2

func _ready() -> void:
	mostrar_top10("modo1") 
	mostrar_top10Palomita("modo2") 
	

func mostrar_top10(modo: String) -> void:
	# 1. Cargo el ranking desde JSON
	Global.cargar_ranking("Penales")
	
	# 2. Ordeno por puntaje (mayor a menor)
	Global.ranking.sort_custom(func(a, b):
		return a["puntos"] > b["puntos"]
	)

	# 3. Muestro hasta 10 entradas
	for i in range(min(10, Global.ranking.size())):
		var entrada = Global.ranking[i]
		var texto = "%d. %s - %d pts" % [i+1, entrada["nombre"], entrada["puntos"]]
		contenedor.get_child(i).text = texto

func mostrar_top10Palomita(modo: String) -> void:
	# 1. Cargo el ranking desde JSON
	Global.cargar_ranking("palomita")
	
	# 2. Ordeno por puntaje (mayor a menor)
	Global.ranking.sort_custom(func(a, b):
		return a["puntos"] > b["puntos"]
	)

	# 3. Muestro hasta 10 entradas
	for i in range(min(10, Global.ranking.size())):
		var entrada = Global.ranking[i]
		var texto = "%d. %s - %d pts" % [i+1, entrada["nombre"], entrada["puntos"]]
		contenedor2.get_child(i).text = texto


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
