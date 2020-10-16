extends Node2D

var Planet = preload("res://Planet.tscn")
var Star = preload("res://Star.tscn")

const PLANET_PATH = 'res://assets/planets'
const STAR_PATH = 'res://assets/stars'

var viewport_size
var planets = []
var star
var atmospheres = ["oxygen", "nitrogen", "xenon"]
var cout_atmospheres = {"oxygen" : 10, "nitrogen" : 50, "xenon" : 90}
var dragged_planet
var current_planet

var min_step = 25
var max_step = 75


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size
	init_star()
	init_planets()

func _draw():
	var radius
	for n in range(planets.size()):
		radius = star.position.distance_to(planets[n].position)
		draw_arc(star.position, radius, 0, 360, 5000, Color(255, 255, 255))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	drag_planet()
	update()

func get_random_sprite(list):
	var rand_index = randi() % list.size()
	var sprite = load("%s" % list[rand_index])
	return [rand_index, sprite]

func init_star():
	randomize()
	var star_sprites = get_star_sprites()
	var rand_sprite = get_random_sprite(star_sprites)
	star = Star.instance()
	add_child(star)

	var intensity = rand_sprite[0]
	var sprite = rand_sprite[1]

	var pos = Vector2(viewport_size.x/3, viewport_size.y/2)
	star.init(pos, sprite, intensity)

func init_planets():
	randomize()
	var p
	#var radius
	var planet_sprites = get_planet_sprites()
	var previous_dist = 35; # initial minimum distance from sun
	var rng = rand_range(2, 5)
	max_step = viewport_size.y / (rng * 2)
	for _n in range(rng):
		p = Planet.instance()
		planets.append(p)
		add_child(p)
		p.connect("clicked", self, "_on_planet_click")

		var atmosphere = atmospheres[randi()%atmospheres.size()]
		var rand_sprite = get_random_sprite(planet_sprites)
		var rand_index = rand_sprite[0]
		var sprite = rand_sprite[1]

		p.init(star.position, atmosphere, sprite, rand_index+1)

		var s = rand_range(min_step, max_step)
		var step = Vector2(previous_dist + s, 0)
		p.rotation = star.rotation + rand_range(-PI, PI)
		step = step.rotated(p.rotation)
		p.position += step
		previous_dist = p.position.distance_to(star.position)

		p.position.x = clamp(p.position.x, 0, viewport_size.x)
		p.position.y = clamp(p.position.y, 0, viewport_size.y)
		p.put_origin_position(p.position)

func free_planets():
	# TODO
	pass

func free_star():
	# TODO
	pass

func drag_planet():
	if (typeof(current_planet) > 0) and (current_planet.dragging):
		var mousepos = get_viewport().get_mouse_position()
		var mouse_dist = mousepos.distance_to(star.position)
		var planet_dist = current_planet.position.distance_to(star.position)

		var diff = planet_dist - mouse_dist
		var move_vector = Vector2(diff, 0)
		move_vector = move_vector.rotated(current_planet.rotation)
		if mouse_dist < viewport_size.y/2 and mouse_dist > 60:
			current_planet.position -= move_vector

func hide():
	.hide()
	$HUDLayer/HUDSystem.hide()

func show():
	.show()
	$HUDLayer/HUDSystem.show()

func compute_temp(planet):
	var dist = float(planet.distance_to_star($Star.position))
	var coef = 1 + float(planet.temp_coefficient)
	#print(dist, " ", coef)
	$HUDLayer/HUDSystem.update_temp(int(-dist*2.7)+750-coef*50, int(-dist*2.2)+750-coef*50)
	$HUDLayer/HUDSystem.update_gaz(planet.atmosphere_new)

# =============
# = Callbacks =
# =============

func _unhandled_input(event):
	if event is InputEventMouseButton\
	and event.button_index == BUTTON_LEFT\
	and !event.pressed and current_planet\
	and current_planet.dragging:
		current_planet.dragging = false

func _on_planet_click(target):
	$HUDLayer/HUDSystem.show()
	compute_temp(target)
	current_planet = target
	current_planet.dragging = true
	$HUDLayer/HUDSystem.update_gaz(current_planet.get_gaz())

	var cost_curr_planet = current_planet.get_cost_pos()
	current_planet.compute_move(target.position)
	$HUDLayer/HUDSystem.add_to_total_cout(current_planet.get_cost_pos() - cost_curr_planet)
	compute_temp(target)
	#entourer la planete d'un cercle

func _on_HUDSystem_atmo_changed(new_atmo):
	var cost_curr_planet = current_planet.get_cost_atmo()
	current_planet.update_atmosphere(new_atmo, cout_atmospheres.get(new_atmo))
	$HUDLayer/HUDSystem.add_to_total_cout(current_planet.get_cost_atmo() - cost_curr_planet)

func _on_HUDSystem_reinit_system():
	for i in planets.size():
		planets[i].position = planets[i].get_origin_position()
	$HUDLayer/HUDSystem.add_to_total_cout(0)
	current_planet = null
	$HUDLayer/HUDSystem.show_tips()

# =========
# = Utils =
# =========

func get_planet_sprites():
	return get_file_list(PLANET_PATH)

func get_star_sprites():
	return get_file_list(STAR_PATH)

func get_file_list(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.ends_with("png"):
				files.append("%s/%s" % [path, file])

	dir.list_dir_end()

	return files
