extends Area2D

signal Comment_end

var nul = "Did your mama forced you to chose this job?"
var moyen = "You did the minimum expected"
var good = "Nice job!"

func choose_comments(prestige, prestige_max):
	if (prestige < (prestige_max/2)):
		$Comment.text = nul
	elif (prestige > (prestige_max*3/4)):
		$Comment.text = good
	else:
		$Comment.text = moyen
	var strTotal = "Total: %s" %[str(prestige)]
	$TotalRes.text = strTotal

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		emit_signal("Comment_end")
