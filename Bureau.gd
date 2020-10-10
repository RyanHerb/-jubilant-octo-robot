extends Node2D

export (PackedScene) var Mission


func _ready():
	$AffichMissionButton.show()
	$Money.show()
	$Prestige.show()
	start_game()

#func miniature_mission():
	#$RecapMission.text = str($Mission.max_temperature)
	#comment construir ele text ???
#affiche aussi le pourcentage de finition de la mission



func start_game():
	var cpt
	#var mission = create_mission_1()
	#$NewMission.show()
	# comment faire le scénario ???

#func show_mission():
 #	pass


func create_mission_1():
	var mission = Mission.instance()
	mission.description = "blubliblablop bliblbubla blablabloublou"
	mission.min_temperature = 0
	mission.max_temperature = 40
	mission.atmosphere = "oxygene"
	return mission
	
func create_mission_2():
	var mission = Mission.instance()
	mission.description = "blubliblablop bliblbubla blablabloublou"
	mission.min_temperature = -20
	mission.max_temperature = 10
	mission.atmosphere = "azote"
	return mission
	
func create_mission_3():
	var mission = Mission.instance()
	mission.description = "blubliblablop bliblbubla blablabloublou"
	mission.min_temperature = 20
	mission.max_temperature = 55
	mission.atmosphere = "zemon"
	return mission


