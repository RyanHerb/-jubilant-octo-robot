extends Area2D

signal click_to_system

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		$OpenSystem.play()
		emit_signal("click_to_system")
