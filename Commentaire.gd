extends Area2D

signal Comment_end

var nul = "Did your mama forced you to chose this job?"
var moyen = "You did the minimum expected"
var good = "Nice job!"

var nulMoney = "Did you expect us to do charity?"
var midMoney = "Today is not a promotion day."
var goodMoney = "You served your office well."

func choose_comments(prestige, prestige_max):
	if (prestige < (prestige_max/2)):
		$Comment.text = nul
	elif (prestige > (prestige_max*3/4)):
		$Comment.text = good
	else:
		$Comment.text = moyen
	var strTotal = "Customers' reviews: %s" %[str(prestige)]
	$TotalRes.text = strTotal

func choose_comments_money(money, money_max):
	if (money < (money_max/3)):
		$CommentMoney.text = nulMoney
	elif (money > (money_max/2)):
		$CommentMoney.text = goodMoney
	else:
		$CommentMoney.text = midMoney
	var strTotal = "Your day's earnings: %s $" %[str(money)]
	$TotalMoney.text = strTotal


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		emit_signal("Comment_end")
