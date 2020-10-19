extends Node2D

signal move_left_done

var intensity = 1
var pos = 0

func _ready():
	pass

func init(_pos, sprt, intens):
	position = _pos
	set_sprite(sprt)
	intensity = intens

func set_sprite(sprite):
	$Light2D/Sprite.texture = sprite

func move_to_left(_pos):
	pos = _pos
	$Timer.start()

func _on_Timer_timeout():
	position.x -= 30
	pos -= 30
	if pos <= 0:
		$Timer.stop()
		emit_signal("move_left_done")

