extends ProgressBar
func _process(delta):
	if value < max_value:
		value += 50 * delta
		Global.potencia=value
	if value == 100:
		value=min_value
		Global.potencia=value
