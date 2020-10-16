extends Node2D

var intensity = 1

func _ready():
	pass

func init(pos, sprt, intens):
	position = pos
	set_sprite(sprt)
	intensity = intens

func set_sprite(sprite):
	$Light2D/Sprite.texture = sprite
