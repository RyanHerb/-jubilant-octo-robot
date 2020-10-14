extends Node2D

signal see_missionIntro
signal see_system

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func hide():
	.hide()
	$HUDLayer/HUDOffice.hide()

func hide_buttons():
	.hide()
	$HUDLayer/HUDOffice.hide_buttons()
func show():
	.show()
	$HUDLayer/HUDOffice.show()

func enter_office():
	$HUDLayer/HUDOffice.start_game()

func init_HUD():
	$HUDLayer/HUDOffice.hide()
	
func new_mission():
	$Lamp.hide()
	$GreenLampNode2D.show()
	$HUDLayer/HUDOffice.new_mission()

func start_game():
	$HUDLayer/HUDOffice.start_game()

func mission_validated(mission):
	$HUDLayer/HUDOffice.mission_validated(mission)

func _on_HUDOffice_see_missionIntro():
	$GreenLampNode2D.hide()
	$Lamp.show()
	$HUDLayer/HUDOffice.hide_mission_descr()
	emit_signal("see_missionIntro")

func _on_GreenLampNode2D_click_lamp():
	$GreenLampNode2D.hide()
	$Lamp.show()
	$HUDLayer/HUDOffice.hide_mission_descr()
	emit_signal("see_missionIntro")
