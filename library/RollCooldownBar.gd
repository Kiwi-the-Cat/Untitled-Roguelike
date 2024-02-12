extends ProgressBar
func _process(delta):
	#Sets the cooldown bar to percentage of cooldown remaining divided by total cooldown time
	if get_parent().roll_cooldown.get_time_left() > 0:
		visible = true
		value = get_parent().roll_cooldown.get_time_left() / (get_parent().roll_time * 5) * 100
	else:
		visible = false
