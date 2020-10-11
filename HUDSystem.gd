extends Node2D

signal mission_finished

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_all()
	
func entrer_system():
	show_all()



func hide_all():
	$ReinitPlanet.hide()
	$ChangeGaz1.hide()
	$ChangeGaz2.hide()
	$CoutChanges.hide()
	$AtmoLabel.hide()
	$TempLabel.hide()
	$TotalLabel.hide()
	$TempLabel.hide()
	$TempMax.hide()
	$TempMin.hide()
	$Money.hide()
	$MoneySprite.hide()
	$IconeTmp.hide()
	$Valider.hide()
	
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
	$Money.show()
	$MoneySprite.show()
	$IconeTmp.show()
	$Valider.show()



func _on_Valider_pressed():
	hide_all()
	emit_signal("mission_finished")
