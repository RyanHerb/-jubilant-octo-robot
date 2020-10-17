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
	$Desk.hide()
	
func show():
	.show()
	$HUDLayer/HUDOffice.show()
	$Desk.show()

# =============
# = Callbacks =
# =============

func _on_HUDOffice_see_missionIntro():
	$HUDLayer/HUDOffice.hide_mission_descr()
	emit_signal("see_missionIntro")

func _on_HUDOffice_animation_finished():
	emit_signal("animation_finished")
