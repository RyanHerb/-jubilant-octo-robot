extends AnimatedSprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	pass
	if parent && (frame == 9) && (parent.visible):
		$notif_loop.play()
