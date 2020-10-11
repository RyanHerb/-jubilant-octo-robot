extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_all()

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
