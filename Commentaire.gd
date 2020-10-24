extends Area2D

signal Comment_end


var nulPres = "Did your mama forced you to chose this job?"
var moyenPres = "You did the minimum expected."
var goodPres = "Nice job! You are a real friend to Asylum Seekers from Space!"
var perfectPres = "Well played! A new cult is spreading all around the universe, with you as their idol!"
var tab_val_pres = [0.5, 0.75, 0.92, 1]
var comment_prest = [nulPres, moyenPres, goodPres, perfectPres]

var negMoney = "Where did you find that extra cash? You're Fired!"
var nulMoney = "Did you expect us to do charity?"
var midMoney = "Today is not a promotion day."
var goodMoney = "You served your office well!"
var perfectMoney = "Great news! Your boss' position is suddenly available!"
var tab_val_money = [0, 0.3, 0.5, 0.92, 1]
var comment_money = [negMoney, nulMoney, midMoney, goodMoney, perfectMoney]

func choose_comments(prestige, prestige_max):
	var i = 0
	while (prestige > prestige_max * tab_val_pres[i] and i < 3) :
		i += 1
	$Comment.text = comment_prest[i]
	var strTotal = "Customers' reviews: %s/5" %[str(prestige)]
	$TotalRes.text = strTotal

func choose_comments_money(money, money_max):
	var i = 0
	while money > money_max * tab_val_money[i] and i < 4 :
		i += 1
	$CommentMoney.text = comment_money[i]
	var strTotal = "Your day's earnings: %s $" %[str(money)]
	$TotalMoney.text = strTotal


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		emit_signal("Comment_end")
