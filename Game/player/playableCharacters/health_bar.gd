extends ProgressBar

func _on_value_changed(value: float) -> void:
	var backgroundStylebox = get_theme_stylebox("background")
	var fillStylebox = get_theme_stylebox("fill")

	if(value == max_value):
		fillStylebox.set_corner_radius(1,0)
		fillStylebox.set_corner_radius(2,0)
	else:
		fillStylebox.set_corner_radius(1,8)
		fillStylebox.set_corner_radius(2,8)
