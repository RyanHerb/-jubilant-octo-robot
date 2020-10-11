extends Node2D

signal see_missionIntro
signal see_system

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter_office():
	$HUDLayer/HUDOffice.start_game()

func init_HUD():
	$HUDLayer/HUDOffice.hide_all()
	
func new_mission():
	$HUDLayer/HUDOffice.new_mission()

func start_game():
	$HUDLayer/HUDOffice.start_game()

func mission_validated(mission):
	$HUDLayer/HUDOffice.mission_validated(mission)

func _on_HUDOffice_see_missionIntro():
	emit_signal("see_missionIntro")


#func _on_HUDOffice_mission_accepted():
#	emit_signal("mission_accepted")


#func _on_HUDOffice_mission_finished():
#	emit_signal("mission_finished")


#func _on_HUDOffice_see_mission():
#	emit_signal("see_mission")


func _on_HUDOffice_see_system():
	emit_signal("see_system")
