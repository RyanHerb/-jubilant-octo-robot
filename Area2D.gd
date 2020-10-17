extends Area2D

signal loreEnd


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		emit_signal("loreEnd")

