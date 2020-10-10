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
	#mission.show()
	# comment faire le scénario ???

func create_mission_1():
	var mission = preload("res://Mission.tscn").instance()
	mission.update_descr("blubliblablop bliblbubla blablabloublou")
	mission.update_values(0, 40, "oxygene")
	return mission
	
func create_mission_2():
	var mission = Mission.instance()
	mission.update_descr("blubliblablop bliblbubla blablabloublou")
	mission.update_values(-20, 10, "azote")
	return mission
	
func create_mission_3():
	var mission = Mission.instance()
	mission.update_descr("blubliblablop bliblbubla blablabloublou")
	mission.update_values(20, 55, "zemon")
	return mission
