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
