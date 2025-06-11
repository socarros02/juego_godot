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
		
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not vida:
		return	
	if Input.is_action_just_pressed("click"):
		click()

func _on_muerte_timeout() -> void:
	die()
