extends Node2D

var dragging = false
var viewport_size

var atmosphere_origin = "oxygen";
var atmosphere_new = "oxygen"
var position_init = Vector2(0, 0)
var temp_coefficient = 1;
var tmp_cost = Vector2(0, 0)

signal clicked(target)

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size

func init(pos, atm, sprt, coef):
	position = pos
	atmosphere_origin = atm
	init_atmospheres(atm)
	set_sprite(sprt)
	temp_coefficient = coef

func reinit():
	atmosphere_new = atmosphere_origin
	tmp_cost = [0, 0]

func distance_to_star(star):
	return position.distance_to(star)
	
func is_origin_atmosphere(text):
	if text == atmosphere_origin:
		return true
	return false

func update_atmosphere(text, cost):
	atmosphere_new = text
	print(tmp_cost, cost)
	if atmosphere_origin == text:
		tmp_cost[1] = 0
	else:
		tmp_cost[1] = cost

func init_atmospheres(gaz):
	atmosphere_origin = gaz
	atmosphere_new = gaz

func compute_move(vect):
	tmp_cost[0] = int(position_init.distance_to(vect)*10)

func set_warn(warn):
	if warn:
		$KinematicBody2D/Sprite.modulate = Color(1, 0, 0)
	else:
		$KinematicBody2D/Sprite.modulate = Color(1, 1, 1)

# =============
# = Callbacks =
# =============

func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton\
	and event.button_index == BUTTON_LEFT\
	and event.pressed:
		emit_signal("clicked", self)

# =========
# = Utils =
# =========

func get_origin_position():
	return position_init

func get_gaz():
	return atmosphere_new
	
func get_cost_atmo():
	return tmp_cost[1]
	
func get_cost_pos():
	return tmp_cost[0]

func set_sprite(sprite):
	$KinematicBody2D/Sprite.texture = sprite

func put_origin_position(value):
	position_init = value
