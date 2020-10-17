extends Node2D

signal see_missionIntro
signal animation_finished


func _ready():
	hide()

func enter_office():
	$HUDLayer/HUDOffice.start_game()

func init_HUD():
	$HUDLayer/HUDOffice.hide()
	
func new_mission():
	$Lamp.hide()
	$GreenLampNode2D.show()
	$HUDLayer/HUDOffice.new_mission()

# =============
# =  Display  =
# =============

func hide():
	.hide()
	$HUDLayer/HUDOffice.hide()

func hide_buttons():
	.hide()
	$HUDLayer/HUDOffice.hide_buttons()
	
func show():
	.show()
	$HUDLayer/HUDOffice.show()

# =============
# = Callbacks =
# =============

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

func _on_HUDOffice_animation_finished():
	emit_signal("animation_finished")
