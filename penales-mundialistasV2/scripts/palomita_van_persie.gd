extends Node2D
@onready var mostrarPuntos: Label = $puntaje

var puntaje = Global.puntoPalomita
func _on_mostrarPuntaje(puntos):
	mostrarPuntos.text= Global.puntoPalomita
func _ready() -> void:
	_on_mostrarPuntaje(puntaje)
