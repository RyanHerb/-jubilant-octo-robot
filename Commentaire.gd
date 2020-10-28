extends Area2D

signal Comment_end

func choose_comments(prestige, prestige_max):
	var tab_val_pres = [0.5, 0.75, 0.92, 1]
	var comment_prest = [tr("KEY_PRES_NUL"), tr("KEY_PRES_MID"),
	tr("KEY_PRES_GOOD"), tr("KEY_PRES_PERF")]
	
	var i = 0
	while (prestige > prestige_max * tab_val_pres[i] and i < 3) :
		i += 1
	$Comment.text = comment_prest[i]
	var strTotal = "%s %s/5" %[tr("KEY_PRES_SCORE"), str(prestige)]
	$TotalRes.text = strTotal

func choose_comments_money(money, money_max):
	var tab_val_money = [0, 0.3, 0.5, 0.92, 1]
	var comment_money = [tr("KEY_MONEY_NEG"), tr("KEY_MONEY_NUL"),
	tr("KEY_MONEY_MID"), tr("KEY_MONEY_GOOD"), tr("KEY_MONEY_PERF")]

	var i = 0
	while money > money_max * tab_val_money[i] and i < 4 :
		i += 1
	$CommentMoney.text = comment_money[i]
	var strTotal = "%s %s $" %[tr("KEY_PRES_SCORE"), str(money)]
	$TotalMoney.text = strTotal


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		.hide()
		emit_signal("Comment_end")
