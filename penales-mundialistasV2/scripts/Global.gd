extends Node
var faseActual
var puntosActuales=0
var potencia
var vidas
var puntoPalomita = 0
var modo = 0
var nombre: String = ""
var ranking: Array = []

func cargar_ranking(modo: String) -> void:
	var filename = "user://ranking_%s.json" % modo
	if FileAccess.file_exists(filename):
		var file = FileAccess.open(filename, FileAccess.READ)
		var content = file.get_as_text()
		file.close()

		var parsed = JSON.parse_string(content)
		if typeof(parsed) == TYPE_ARRAY:
			ranking = parsed
		else:
			ranking = []
	else:
		ranking = []

func guardar_puntaje(nombre: String, modo: String) -> void:
	cargar_ranking(modo)
	if puntosActuales == 0:
		puntosActuales = Global.puntoPalomita
	var entrada = {
		"nombre": nombre,
		"puntos": puntosActuales
	}
	ranking.append(entrada)
	Global.puntosActuales = 0
	Global.puntoPalomita = 0
	var filename = "user://ranking_%s.json" % modo
	var file = FileAccess.open(filename, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(ranking, "\t"))
		file.close()
