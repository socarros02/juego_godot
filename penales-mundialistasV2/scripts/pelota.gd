extends Node2D

signal pelota_cabeceada
signal restarVida
var puntaje= Global.puntoPalomita
var velocidad = 15
var activa = false

func _physics_process(delta: float) -> void:
	if activa:
		$cabeceada.position+=Vector2.LEFT*velocidad

func _on_cabeceada_body_entered(body: Node2D) -> void:
	if body.name == "vanPersie":
		emit_signal("pelota_cabeceada")
		$cabeceada.global_position=Vector2(1600,200)
		_reset()
	
	if body.name=="final":
		emit_signal("restarVida")
		$cabeceada.global_position=Vector2(1600,200)
		_reset()


func _reset():
	activa = false
	visible = false
