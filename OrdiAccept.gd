extends AnimatedSprite

var parent

func _ready():
	parent = get_parent()# Replace with function body.

func _process(delta):
	if parent && (frame == 9) && (parent.visible):
		$notif_loop.play()
