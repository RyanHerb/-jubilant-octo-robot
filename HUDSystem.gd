extends Node2D

signal mission_finished(cost, tmp_min, tmp_max, gaz)
signal atmo_changed
signal reinit_system
signal find_new_system
signal release_target

var current_money
var current_gaz

# Called when the node enters the scene tree for the first time.
func _ready():
	show_tips()
			
func _process(_delta):
	var system = get_parent().get_parent()
	if !system.valid and !$Valider.disabled:
		$Valider.disabled = true
		$Valider.modulate = Color(0.5, 0.5, 0.5, 1)
	elif system.valid and $Valider.disabled:
		$Valider.disabled = false
		$Valider.modulate = Color(1, 1, 1, 1)

func entrer_system():
	show()

func reinit():
	$CoutChanges.text = "0"
	check_cost_to_money()

func update_maxi_planet(val):
	$MaxiPlanet.animation = str(val)

func update_temp(min_tmp, max_tmp):
	$TempMin.text = str(min_tmp)
	$TempMax.text = str(max_tmp)

func update_gaz(gaz):
	current_gaz = gaz
	$ChangeGaz1.show()
	$ChangeGaz2.show()
	$ChangeGaz3.show()
	if gaz == tr("KEY_OXYGEN"):
		$ChangeGaz1.modulate = Color(1, 1, 1, 1)
		$ChangeGaz2.modulate = Color(0.5, 0.5, 0.5, 1)
		$ChangeGaz3.modulate = Color(0.5, 0.5, 0.5, 1)
	elif gaz == tr("KEY_NITROGEN"):
		$ChangeGaz1.modulate = Color(0.5, 0.5, 0.5, 1)
		$ChangeGaz2.modulate = Color(1, 1, 1, 1)
		$ChangeGaz3.modulate = Color(0.5, 0.5, 0.5, 1)
	else:
		$ChangeGaz1.modulate = Color(0.5, 0.5, 0.5, 1)
		$ChangeGaz2.modulate = Color(0.5, 0.5, 0.5, 1)
		$ChangeGaz3.modulate = Color(1, 1, 1, 1)
	
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
	$Help.show()
	$RightClick.show()
	$ReinitPlanet.show()
	$CoutChanges.show()
	$Total.show()
	$TempMax.show()
	$TempMin.show()
	$MoneySprite.show()
	$Valider.show()
	$TempLabel.show()
	#$Currentgaz.show()
	$Atmosphere.show()
	$Lazer.show()
	$SpriteTemp.show()
	$HighLow.show()
	$NewSystem.show()
	$MaxiPlanet.show()

func show_tips():
	.show()
	$Tips.show()
	$Help.hide()
	$RightClick.hide()
	$ReinitPlanet.hide()
	$ChangeGaz1.hide()
	$ChangeGaz2.hide()
	$ChangeGaz3.hide()
	$TempLabel.hide()
	$TempLabel.hide()
	$TempMax.hide()
	$TempMin.hide()
	$Valider.hide()
	$Atmosphere.hide()
	$SpriteTemp.hide()
	$HighLow.hide()
	$NewSystem.show()
	$MaxiPlanet.hide()

func hide_maxi_planet():
	$MaxiPlanet.hide()

# =============
# = Callbacks =
# =============

func _on_Valider_pressed():
	hide()
	$Valider/SystemClose.play()
	emit_signal("mission_finished", int($CoutChanges.text), int($TempMin.text), int($TempMax.text), current_gaz)
	$CoutChanges.text = str(0)

func _on_ChangeGaz1_pressed():
	$ChangeGaz1/clic.play()
	update_gaz(tr($ChangeGaz1.text))
	emit_signal("atmo_changed", $ChangeGaz1.text)

func _on_ChangeGaz2_pressed():
	$ChangeGaz1/clic.play()
	update_gaz(tr($ChangeGaz2.text))
	emit_signal("atmo_changed", $ChangeGaz2.text)

func _on_ChangeGaz3_pressed():
	$ChangeGaz1/clic.play()
	update_gaz(tr($ChangeGaz3.text))
	emit_signal("atmo_changed", $ChangeGaz3.text)

func _on_ReinitPlanet_pressed():
	$CoutChanges.text = str(0)
	check_cost_to_money()
	emit_signal("reinit_system")

func _on_NewSystem_pressed():
	$NewSystem/new_system.play()
	show_tips()
	reinit()
	emit_signal("find_new_system")

func _on_Help_pressed():
	$ChangeGaz1/clic.play()
	emit_signal("release_target")
