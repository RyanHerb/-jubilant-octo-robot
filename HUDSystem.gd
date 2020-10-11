extends Node2D

signal mission_finished

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show_all()
	
func entrer_system():
	show_all()

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
	
	
func show_all():
	$ReinitPlanet.show()
	$ChangeGaz1.show()
	$ChangeGaz2.show()
	$CoutChanges.show()
	$AtmoLabel.show()
	$TempLabel.show()
	$TotalLabel.show()
	$TempLabel.show()
	$TempMax.show()
	$TempMin.show()
	$MoneySprite.show()
	$IconeTmp.show()
	$Valider.show()
	$Currentgaz.show()
	$Atmosphere.show()
	$Lazer.show()



func _on_Valider_pressed():
	hide()
	emit_signal("mission_finished")

func _on_ChangeGaz1_pressed():
	$CoutChanges.text = str(int($CoutChanges.text) + 1000)
	$Currentgaz.text = $ChangeGaz1.text
	update_gaz($Currentgaz.text)

func _on_ChangeGaz2_pressed():
	$CoutChanges.text = str(int($CoutChanges.text) + 1000)
	$Currentgaz.text = $ChangeGaz2.text
	update_gaz($Currentgaz.text)
