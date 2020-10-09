extends Node2D

var Planet = preload("res://Planet.tscn")

var planets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var screen_size = get_viewport_rect().size
	$Star.position = Vector2(screen_size.x/2, screen_size.y/2)
	var p
	var direction
	var step = 50
	var velocity = Vector2(step, 0)
	for n in range(4):
		p = Planet.instance()
		planets.append(p)
		add_child(p)
	
		direction = $Star.rotation + rand_range(-PI, PI)
		p.position = $Star.position
		p.rotation = direction
		velocity = velocity.rotated(p.rotation)
		p.position += velocity*(n+1)
		
func _draw():
	var radius
	for n in range(planets.size()):
		radius = $Star.position.distance_to(planets[n].position)
		draw_arc($Star.position, radius, 0, 360, 10000, Color(255, 255, 255))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
