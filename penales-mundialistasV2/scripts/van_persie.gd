extends RigidBody2D
var velocidad = 350
var vida = true
func die():
	get_tree().change_scene_to_file("res://Escenas/perdistePalomita.tscn")
func click():
	linear_velocity = Vector2.UP * velocidad
func _physics_process(delta: float) -> void:
	if position.y>515 and vida:
		vida = false
		gravity_scale=0
		$gameOver2.visible=true
		linear_velocity=Vector2.ZERO
		Global.vidas=0
		$muerte.start()
func _ready() -> void:
	var menu= get_parent().get_node("spawnPelotas/MenuButton")
	menu.get_popup().id_pressed.connect(_on_menu_option_selected)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PAUSA"):
		_on_menu_button_pressed()       
		var menu = get_parent().get_node("spawnPelotas/MenuButton")
		menu.get_popup().popup()  

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not vida:
		return	
	if Input.is_action_just_pressed("click"):
		click()

func _on_muerte_timeout() -> void:
	die()


func _on_menu_button_pressed() -> void:
	velocidad = 0
	gravity_scale=0
	linear_velocity = Vector2.ZERO

func _on_menu_option_selected(id):
	match id:
		0:
			velocidad=350
			gravity_scale=1
		1:
			get_tree().change_scene_to_file("res://Escenas/menu.tscn")
