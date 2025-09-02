extends Node2D

signal pelota_cabeceada
signal restarVida
var puntaje= Global.puntoPalomita
var velocidad = 15
var activa = false

func _ready() -> void:
	var menu= get_parent().get_parent().get_node("spawnPelotas/MenuButton")
	menu.get_popup().id_pressed.connect(_on_menu_option_selected)
	
func _physics_process(delta: float) -> void:
	if activa:
		$cabeceada.position+=Vector2.LEFT*velocidad
	if Input.is_action_just_pressed("PAUSA"):
		_on_menu_button_pressed()

func _on_cabeceada_body_entered(body: Node2D) -> void:
	if body.name == "vanPersie":
		emit_signal("pelota_cabeceada")
		$cabeceada.global_position.x=1600
		_reset()
	
	if body.name=="final":
		emit_signal("restarVida")
		$cabeceada.global_position.x=1600
		_reset()


func _reset():
	activa = false
	visible = false


func _on_menu_button_pressed() -> void:
	velocidad=0
	
func _on_menu_option_selected(id):
	match id:
		0:
			velocidad=15
