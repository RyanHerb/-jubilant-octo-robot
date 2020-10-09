extends Node2D

var dragging = false

signal dragsignal;

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("dragsignal",self,"_toggle_drag")
	
func _toggle_drag():
	dragging = !dragging


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)




func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("dragsignal")
