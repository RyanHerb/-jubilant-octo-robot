extends Area2D

signal click_to_system

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		emit_signal("click_to_system")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
