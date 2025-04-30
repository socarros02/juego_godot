extends Node2D


func atajar(ataja):
	var atajar
	atajar = atajado(ataja)
	if atajar==1:
		print("atajo el arquerooo, podes seguir jugando")
		get_tree().change_scene_to_file("res://arcade.tscn")
	else:
		print("no atajaste, volves al menu")
		get_tree().change_scene_to_file("res://menu.tscn")
func atajado(tiro):
	var gol
	var opciones =[1,2,3,4,5,6]
	opciones.shuffle()
	if tiro == opciones[1]:
		gol=1
	else:
		gol=0
	return gol
	
