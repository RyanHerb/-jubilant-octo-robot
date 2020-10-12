extends Node2D

var dragging = false
var viewport_size

var atmosphere_origin = "oxygen";
var atmosphere_new = "oxygen"
var position_init = Vector2(0, 0)
var temp_coefficient = 1;
var tmp_cost = Vector2(0, 0)

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
	
func is_origin_atmosphere(text):
	if text == atmosphere_origin:
		return true
	return false

func update_atmosphere(text, cost):
	atmosphere_new = text
	if atmosphere_origin == text:
		tmp_cost[1] = 0
	else:
		tmp_cost[1] = cost

func put_origin_position(value):
	position_init = value
	
func get_origin_position():
	return position_init

func init_atmospheres(gaz):
	atmosphere_origin = gaz
	atmosphere_new = gaz
	
func get_cost_atmo():
	return tmp_cost[1]
	
func compute_move(vect):
	return position_init.distance_to(vect)

func set_sprite(sprite):
	$KinematicBody2D/Sprite.texture = sprite
