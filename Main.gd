extends Node

export (PackedScene) var Mission

# Called when the node enters the scene tree for the first time.
func _ready():
	$IntroEnd.new_game()

func start_scenario():
	$Office.show()
	var mission = create_mission_1()
	add_child(mission)
	mission.connect("mission_accepte", $Office, "mission_validated")
	$Office.new_mission()
	$Office/HUDLayer/HUDOffice.connect("see_missionIntro", mission, "show_intro_mission")
	$Office/HUDLayer/HUDOffice.connect("see_mission", mission, "show_text_mission")
	$Office/HUDLayer/HUDOffice.connect("see_system", self, "go_to_system")
	$System/HUDLayer/HUDSystem.connect("mission_finished", self, "go_to_office")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission.queue_free()
	
	mission = create_mission_2()
	add_child(mission)
	mission.connect("mission_accepte", $Office, "mission_validated")
	$Office.new_mission()
	$Office/HUDLayer/HUDOffice.connect("see_missionIntro", mission, "show_intro_mission")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission.queue_free()
	
	mission = create_mission_3()
	add_child(mission)
	mission.connect("mission_accepte", $Office, "mission_validated")
	$Office.new_mission()
	$Office/HUDLayer/HUDOffice.connect("see_missionIntro", mission, "show_intro_mission")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission.queue_free()
	end_game()



func go_to_system():
	$Office.hide_buttons()
	$System.show()
	
func go_to_office():
	$System.hide()
	$Office.show()
	$EntreMissions.start()
	$Office/HUDLayer/HUDOffice.objectif_hide()

func end_game():
	$System.hide()
	$Office.hide()
	$IntroEnd.end_game()

func _on_HUD_start_game():
	$Office.start_game()
	start_scenario()

func startTimer():
	$EntreMissions.start()

func _on_Office_mission_finished():
	$EntreMissions.start()


func _on_HUDSystem_mission_finished():
	$EntreMissions.start()
	$System.hide()

func create_mission_1():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "bliblibloblo blubli blio"
	mission.update_descr(descri)
	mission.update_values(0, 40, "oxygene", 150, "res://assets/aliens/alien_mars.png")
	return mission
	
func create_mission_2():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "ceci est la deuxieme mission"
	mission.update_descr(descri)
	mission.update_values(-20, 10, "azote", 400, "res://assets/aliens/alien_mars.png")
	return mission
	
func create_mission_3():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "au secours c'est la fin"
	mission.update_descr(descri)
	mission.update_values(20, 55, "zemon", 1000,  "res://assets/aliens/alien_mars.png")
	return mission


