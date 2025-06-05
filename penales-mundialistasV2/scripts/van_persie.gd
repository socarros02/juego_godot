extends RigidBody2D

var velocidad = 350
var vida = true
func die():
	print("e morido")
func click():
	linear_velocity = Vector2.UP * velocidad

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not vida:
		return	
	if Input.is_action_just_pressed("click"):
		click()
