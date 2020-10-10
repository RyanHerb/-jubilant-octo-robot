extends Node2D

var Planet = preload("res://Planet.tscn")

var viewport_size
var planets = []
var dragged_planet

var min_step = 70
var max_step = 70

# Called when the node enters the scene tree for the first time.
func _ready():
	$Temperature.hide()
	randomize()
	var p
	var direction
	var radius
	viewport_size = get_viewport_rect().size
	$Star.position.x = viewport_size.x/2
	$Star.position.y = viewport_size.y/2
	for n in range(4):
		p = Planet.instance()
		planets.append(p)
		add_child(p)
	
		var s = rand_range(min_step, max_step)
		radius = Vector2(s, 0)
		direction = $Star.rotation + rand_range(-PI, PI)
		p.position = $Star.position
		p.rotation = direction
		radius = radius.rotated(p.rotation)
		p.position += radius * (n+1)
		p.connect("dragsignal", self, "_on_planet_drag")
		p.position.x = clamp(p.position.x, 0, viewport_size.x)
		p.position.y = clamp(p.position.y, 0, viewport_size.y)
		
func _draw():
	var radius
	for n in range(planets.size()):
		radius = $Star.position.distance_to(planets[n].position)
		draw_arc($Star.position, radius, 0, 360, 10000, Color(255, 255, 255))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (typeof(dragged_planet) > 0) and (dragged_planet.dragging):
		var mousepos = get_viewport().get_mouse_position()
		dragged_planet.position = Vector2(mousepos.x, mousepos.y)
		dragged_planet.position.x = clamp(dragged_planet.position.x, 0, viewport_size.x)
		dragged_planet.position.y = clamp(dragged_planet.position.y, 0, viewport_size.y)
	update()
		

func _on_planet_drag(target):
	dragged_planet = target
	compute_temp(target.distance_to_star())
	$Temperature.show()
	#entourer la planete d'un cercle
	
	#calculer distance au soleil
	#puis afficher temperature de cette planete
	#afficher cout de l'operation

func compute_temp(dist):
	$Temperature.add_text(str(-dist*1.5 + 300))
