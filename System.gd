extends Node2D

var Planet = preload("res://Planet.tscn")
var Star = preload("res://Star.tscn")

const PLANET_PATH = 'res://assets/planets'
const STAR_PATH = 'res://assets/stars'

var viewport_size
var planets = []
var valid = true
var star
var atmospheres #= [tr("KEY_OXYGEN"), tr("KEY_NITROGEN"), tr("KEY_XENON")]
var cout_atmospheres #= {tr("KEY_OXYGEN") : 50, tr("KEY_NITROGEN") : 100, tr("KEY_XENON") : 200}
var dragged_planet
var current_planet

var min_step = 33
var max_step = 75


func _ready():
	viewport_size = get_viewport_rect().size
	hide()

func _draw():
	var radius
	for n in range(planets.size()):
		radius = star.position.distance_to(planets[n].position)
		draw_arc(star.position, radius, 0, 360, 5000, Color(255, 255, 255))
	if current_planet != null:
		draw_arc(current_planet.position, 17, 0, 360, 1000, Color(1, 1, 1, 1), 2)
		draw_arrow()
		
func draw_arrow():
	var star_offset_vector = Vector2(48, 0).rotated(current_planet.rotation)
	var planet_offset_vector = Vector2(32, 0).rotated(current_planet.rotation)
	var start_line = current_planet.position - planet_offset_vector
	var end_line = star.position + star_offset_vector
	var arrow_planet = []
	var arrow_star = []
	var arrow_head_base = Vector2(5, 0).rotated(current_planet.rotation + PI/2)
		
	draw_line(start_line, end_line, Color(1, 1, 1, 1), 2.0, true)

	arrow_planet.append(current_planet.position - planet_offset_vector + arrow_head_base)
	arrow_planet.append(current_planet.position - planet_offset_vector - arrow_head_base)
	arrow_planet.append(current_planet.position - Vector2(16, 0).rotated(current_planet.rotation))
	draw_colored_polygon(arrow_planet, Color(1, 1, 1, 1))

	arrow_star.append(star.position + star_offset_vector + arrow_head_base)
	arrow_star.append(star.position + star_offset_vector - arrow_head_base)
	arrow_star.append(star.position + Vector2(32, 0).rotated(current_planet.rotation))
	draw_colored_polygon(arrow_star, Color(1, 1, 1, 1))	
	
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
	$CalqueSystem.add_child(star)

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
		$CalqueSystem.add_child(p)
		p.connect("clicked", self, "_on_planet_click")
		p.connect("right_clicked", self, "_on_planet_right_click")

		var atmosphere = atmospheres[randi()%atmospheres.size()]
		print("planet ", _n, " d'atmo ", atmosphere)
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
	update_current_planet(null)
	for p in planets:
		p.queue_free()
	planets = []

func init():
	atmospheres = [tr("KEY_OXYGEN"), tr("KEY_NITROGEN"), tr("KEY_XENON")]
	cout_atmospheres = {tr("KEY_OXYGEN") : 50, tr("KEY_NITROGEN") : 100, tr("KEY_XENON") : 200}
	init_star()
	init_planets()
	star.position.x += viewport_size.x
	star.move_to_left(viewport_size.x)
	#star.connect("move_left_done", self, "reinit")
	for i in range(len(planets)):
		planets[i].position.x += viewport_size.x
		planets[i].move_to_left(viewport_size.x)
	
func reinit():
	my_free()
	init()

func free_star():
	star.queue_free()

func my_free():
	free_planets()
	free_star()

func drag_planet():
	if (typeof(current_planet) > 0) and (current_planet.dragging):
		var mousepos = get_viewport().get_mouse_position()
		var mouse_dist = mousepos.distance_to(star.position)
		var planet_dist = current_planet.position.distance_to(star.position)
	
		calculate_warning()
	
		var diff = planet_dist - mouse_dist - current_planet.mouse_offset
		var move_vector = Vector2(diff, 0)
		move_vector = move_vector.rotated(current_planet.rotation)
		if mouse_dist < viewport_size.y/2 and mouse_dist > 60:
			current_planet.position -= move_vector
		compute_temp(current_planet)

func calculate_warning():
	valid = true
	for p in planets:
		if current_planet != p:
			var p_dist = p.position.distance_to(star.position)
			var current_planet_diff = p_dist - current_planet.position.distance_to(star.position)
			if abs(current_planet_diff) <= 32:
				valid = false
				p.set_warn(true)
			else:
				p.set_warn(false)

	current_planet.set_warn(!valid)

func compute_temp(planet):
	var dist = float(planet.distance_to_star(star.position))
	var coef = 1 + float(planet.temp_coefficient)
	var tmp_min = int(-dist*2.5)+750-coef*50
	
	if (typeof(planet) > 0):
		var cost_curr_planet = planet.get_cost_pos()
		planet.compute_move(planet.position)
		$HUDLayer/HUDSystem.add_to_total_cout(planet.get_cost_pos() - cost_curr_planet)
	
	$HUDLayer/HUDSystem.update_temp(tmp_min, tmp_min + 100)
	$HUDLayer/HUDSystem.update_gaz(planet.atmosphere_new)

func update_current_planet(planet):
	if (planet != null):
		$HUDLayer/HUDSystem.update_maxi_planet(planet.get_coef_tmp()) # nope !!
	else:
		$HUDLayer/HUDSystem.hide_maxi_planet()
	current_planet = planet
	
# =============
# =  Display  =
# =============

func hide():
	.hide()
	$HUDLayer/HUDSystem.hide()
	$CalqueSystem.hide()

func show():
	.show()
	$HUDLayer/HUDSystem.show_tips()
	$CalqueSystem.show()

# =============
# = Callbacks =
# =============

func _unhandled_input(event):
	if event is InputEventMouseButton\
	and event.button_index == BUTTON_LEFT\
	and !event.pressed and current_planet\
	and current_planet.dragging:
		current_planet.stop_drag()
		current_planet.dragging = false
		$dragging_end.play()

func _on_planet_click(target):
	$HUDLayer/HUDSystem.show()
	compute_temp(target)
	update_current_planet(target)
	var mousepos = get_viewport().get_mouse_position()
	var mouse_dist = mousepos.distance_to(star.position)
	var offset = current_planet.position.distance_to(star.position) - mouse_dist
	current_planet.drag(offset)
	
	$HUDLayer/HUDSystem.update_gaz(current_planet.get_gaz())
	compute_temp(target)

func _on_planet_right_click(target):
	$HUDLayer/HUDSystem.add_to_total_cout(-target.get_cost())
	target.reinit()
	calculate_warning()
	compute_temp(target)
	$dragging_end.play()
	
func _on_HUDSystem_atmo_changed(new_atmo):
	var cost_curr_planet = current_planet.get_cost_atmo()
	current_planet.update_atmosphere(tr(new_atmo), get_cost_change_atmo(tr(new_atmo)))
	$HUDLayer/HUDSystem.add_to_total_cout(current_planet.get_cost_atmo() - cost_curr_planet)

func _on_HUDSystem_reinit_system():
	$reset.play()
	for i in planets.size():
		planets[i].reinit()
	$HUDLayer/HUDSystem.add_to_total_cout(0)
	update_current_planet(null)
	$HUDLayer/HUDSystem.show_tips()

func _on_HUDSystem_find_new_system():
	star.move_to_left(600)
	for i in range(len(planets)):
		planets[i].move_to_left(600)
	star.connect("move_left_done", self, "reinit")
	
func _on_HUDSystem_release_target():
	update_current_planet(null)
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
			if file.ends_with(".import"):
				files.append("%s/%s" % [path, file.replace(".import", "")])

	dir.list_dir_end()
	return files

func get_cost_change_atmo(atmo):
	return cout_atmospheres.get(atmo)
