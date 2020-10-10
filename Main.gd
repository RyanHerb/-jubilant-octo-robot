extends Node

export (PackedScene) var Mission

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.new_game()
	$HUDBureau.hide_all()
	

func start_scenario():
	$HUDBureau.show_interface()
	var mission = create_mission_1()
	add_child(mission)
	mission.connect("mission_accepte", $HUDBureau, "mission_validated")
	$HUDBureau.new_mission()
	yield($HUDBureau, "see_missionIntro")
	mission.show_intro_mission()
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	
	mission = create_mission_2()
	add_child(mission)
	mission.connect("mission_accepte", $HUDBureau, "mission_validated")
	$HUDBureau.new_mission()
	yield($HUDBureau, "see_missionIntro")
	mission.show_intro_mission()
	mission.connect("mission_accepte", $HUDBureau, "mission_validated")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	
	mission = create_mission_3()
	add_child(mission)
	mission.connect("mission_accepte", $HUDBureau, "mission_validated")
	$HUDBureau.new_mission()
	yield($HUDBureau, "see_missionIntro")
	mission.show_intro_mission()
	mission.connect("mission_accepte", $HUDBureau, "mission_validated")
	yield($EntreMissions, "timeout")
	$HUDBureau.end_game()




func _on_HUD_start_game():
	$HUDBureau.start_game()
	start_scenario()

func startTimer():
	$EntreMissions.start()

func _on_HUDBureau_mission_finished():
	$EntreMissions.start()


func create_mission_1():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "bliblibloblo blubli blio"
	mission.update_descr(descri)
	mission.update_values(0, 40, "oxygene", 150)
	return mission
	
func create_mission_2():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "ceci est la deuxieme mission"
	mission.update_descr(descri)
	mission.update_values(-20, 10, "azote", 400)
	return mission
	
func create_mission_3():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "au secours c'est la fin"
	mission.update_descr(descri)
	mission.update_values(20, 55, "zemon", 1000)
	return mission


