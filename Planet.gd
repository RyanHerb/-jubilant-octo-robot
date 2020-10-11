extends Node2D

var dragging = false
var viewport_size

var atmosphere = "O2";
var temp_coefficient = 1;

signal dragsignal(target);
signal clicked(target)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("dragsignal",self,"_toggle_drag")
	viewport_size = get_viewport_rect().size

func _toggle_drag(_target):
	dragging = !dragging

func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("dragsignal", self)
			if event.pressed:
				emit_signal("clicked", self)

func distance_to_star():
	return position.distance_to(Vector2(viewport_size.x/2, viewport_size.y/2))

func set_sprite(sprite):
	$KinematicBody2D/Sprite.texture = sprite
