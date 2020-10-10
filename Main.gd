extends Node

export (PackedScene) var Mission

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.new_game()
	$HUDBureau.hide_all()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HUD_start_game():
	$HUDBureau.start_game()
	start_scenario()

func start_scenario():
	var mission = create_mission_1()
	add_child(mission)
	$HUDBureau.show_intro_mission()
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission = create_mission_2()
	$HUDBureau.show_intro_mission()
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission = create_mission_3()
	$HUDBureau.show_intro_mission()
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	$HUDBureau.end_game()

func create_mission_1():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "bliblibloblo blubli blio"
	mission.update_descr(descri)
	$HUDBureau.update_description_mission(descri)
	mission.update_values(0, 40, "oxygene", 150)
	return mission
	
func create_mission_2():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "ceci est la deuxieme mission"
	mission.update_descr(descri)
	$HUDBureau.update_description_mission(descri)
	mission.update_values(-20, 10, "azote", 400)
	return mission
	
func create_mission_3():
	var mission = preload("res://Mission.tscn").instance()
	var descri = "au secours c'est la fin"
	mission.update_descr(descri)
	$HUDBureau.update_description_mission(descri)
	mission.update_values(20, 55, "zemon", 1000)
	return mission


func _on_HUDBureau_mission_finished():
	$EntreMissions.start()
