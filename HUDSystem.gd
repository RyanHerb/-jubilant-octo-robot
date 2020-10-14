extends Node2D

signal mission_finished
signal atmo_changed
signal reinit_system
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show_tips()
	
func entrer_system():
	show()

func update_temp(min_tmp, max_tmp):
	$TempMin.text = str(min_tmp)
	$TempMax.text = str(max_tmp)

func update_gaz(gaz):
	$Currentgaz.text = gaz
	if $Currentgaz.text == "oxygen":
		$ChangeGaz1.text = "nitrogen"
		$ChangeGaz2.text = "xenon"
	elif $Currentgaz.text == "nitrogen":
		$ChangeGaz1.text = "oxygen"
		$ChangeGaz2.text = "xenon"
	else:
		$ChangeGaz1.text = "oxygen"
		$ChangeGaz2.text = "nitrogen"
	
	
func show_tips():
	$Tips.show()
	$ReinitPlanet.hide()
	$ChangeGaz1.hide()
	$ChangeGaz2.hide()
	$CoutChanges.hide()
	$AtmoLabel.hide()
	$TempLabel.hide()
	$Total.show()
	$TempLabel.hide()
	$TempMax.hide()
	$TempMin.hide()
	$MoneySprite.show()
	$IconeTmp.hide()
	$Valider.hide()
	$Currentgaz.hide()
	$Atmosphere.hide()
	$Lazer.show()
	
func show():
	.show()
	$Tips.hide()
	$ReinitPlanet.show()
	$ChangeGaz1.show()
	$ChangeGaz2.show()
	$CoutChanges.show()
	$AtmoLabel.show()
	$TempLabel.show()
	$Total.show()
	$TempLabel.show()
	$TempMax.show()
	$TempMin.show()
	$MoneySprite.show()
	$IconeTmp.show()
	$Valider.show()
	$Currentgaz.show()
	$Atmosphere.show()
	$Lazer.show()


func add_to_total_cout(val):
	$CoutChanges.text = str(int($CoutChanges.text) + val)

func update_total_cost(val):
	$CoutChanges.text = str(val)

func _on_Valider_pressed():
	hide()
	emit_signal("mission_finished", int($CoutChanges.text))
	$CoutChanges.text = str(0)

func _on_ChangeGaz1_pressed():
	$Currentgaz.text = $ChangeGaz1.text
	update_gaz($Currentgaz.text)
	emit_signal("atmo_changed", $Currentgaz.text)

func _on_ChangeGaz2_pressed():
	$Currentgaz.text = $ChangeGaz2.text
	update_gaz($Currentgaz.text)
	emit_signal("atmo_changed", $Currentgaz.text)

func _on_ReinitPlanet_pressed():
	$CoutChanges.text = str(0)
	emit_signal("reinit_system")
