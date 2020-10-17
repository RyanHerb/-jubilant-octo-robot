extends Node2D

signal mission_finished(cost, tmp_min, tmp_max, gas)
signal atmo_changed
signal reinit_system

var current_money

# Called when the node enters the scene tree for the first time.
func _ready():
	show_tips()
	
func entrer_system():
	show()

func update_temp(min_tmp, max_tmp):
	$TempMin.text = str(min_tmp)
	$TempMax.text = str(max_tmp)

func update_gaz(gaz):
	$SwitchTo.show()
	$Currentgaz.text = gaz
	$ChangeGaz1.show()
	$ChangeGaz2.show()
	$ChangeGaz3.show()
	if gaz == "Oxygen":
		$ChangeGaz1.disabled = true
		$ChangeGaz1.modulate = Color(0.5, 0.5, 0.5, 1)
		$ChangeGaz2.disabled = false
		$ChangeGaz2.modulate = Color(1, 1, 1, 1)
		$ChangeGaz3.disabled = false
		$ChangeGaz3.modulate = Color(1, 1, 1, 1)
	elif gaz == "Nitrogen":
		$ChangeGaz1.disabled = false
		$ChangeGaz1.modulate = Color(1, 1, 1, 1)
		$ChangeGaz2.disabled = true
		$ChangeGaz2.modulate = Color(0.5, 0.5, 0.5, 1)
		$ChangeGaz3.disabled = false
		$ChangeGaz3.modulate = Color(1, 1, 1, 1)
	else:
		$ChangeGaz1.disabled = false
		$ChangeGaz1.modulate = Color(1, 1, 1, 1)
		$ChangeGaz2.disabled = false
		$ChangeGaz2.modulate = Color(1, 1, 1, 1)
		$ChangeGaz3.disabled = true
		$ChangeGaz3.modulate = Color(0.5, 0.5, 0.5, 1)
	
func add_to_total_cout(val):
	$CoutChanges.text = str(int($CoutChanges.text) + val)
	check_cost_to_money()

func update_total_cost(val):
	$CoutChanges.text = str(val)
	check_cost_to_money()

func give_money_value(val):
	current_money = val

func check_cost_to_money():
	if int($CoutChanges.text) <= current_money:
		$Valider.disabled = false
		$Valider.modulate = Color(1, 1, 1, 1)
		$CoutChanges.modulate = Color(1, 1, 1, 1)
	else:
		$Valider.disabled = true
		$Valider.modulate = Color(0.5, 0.5, 0.5, 1)
		$CoutChanges.modulate = Color(1, 0, 0, 1)

# =============
# =  Display  =
# =============
	
func show():
	.show()
	$Tips.hide()
	$ReinitPlanet.show()
	$CoutChanges.show()
	$AtmoLabel.show()
	$TempLabel.show()
	$Total.show()
	$TempLabel.show()
	$TempMax.show()
	$TempMin.show()
	$MoneySprite.show()
	$Valider.show()
	$Currentgaz.show()
	$Atmosphere.show()
	$Lazer.show()
	$SpriteTemp.show()
	$HighLow.show()

func show_tips():
	.show()
	$ReinitPlanet.hide()
	$ChangeGaz1.hide()
	$ChangeGaz2.hide()
	$ChangeGaz3.hide()
	$SwitchTo.hide()
	$AtmoLabel.hide()
	$TempLabel.hide()
	$TempLabel.hide()
	$TempMax.hide()
	$TempMin.hide()
	$Valider.hide()
	$Currentgaz.hide()
	$Atmosphere.hide()
	$SpriteTemp.hide()
	$HighLow.hide()

# =============
# = Callbacks =
# =============

func _on_Valider_pressed():
	hide()
	emit_signal("mission_finished", int($CoutChanges.text), int($TempMin.text), int($TempMax.text), $Currentgaz.text)
	$CoutChanges.text = str(0)

func _on_ChangeGaz1_pressed():
	$Currentgaz.text = $ChangeGaz1.text
	update_gaz($Currentgaz.text)
	emit_signal("atmo_changed", $Currentgaz.text)

func _on_ChangeGaz2_pressed():
	$Currentgaz.text = $ChangeGaz2.text
	update_gaz($Currentgaz.text)
	emit_signal("atmo_changed", $Currentgaz.text)

func _on_ChangeGaz3_pressed():
	$Currentgaz.text = $ChangeGaz3.text
	update_gaz($Currentgaz.text)
	emit_signal("atmo_changed", $Currentgaz.text)

func _on_ReinitPlanet_pressed():
	$CoutChanges.text = str(0)
	$TempMin.text = "-1000"
	$TempMax.text = "-1000"
	$Currentgaz.text = "Aze"
	emit_signal("reinit_system")
