extends Node

export (PackedScene) var Mission

var mission = preload("res://Mission.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	$BeforeAnimOrdi.stop()
	$IntroEnd.new_game()
	$System.hide()
	$Office.hide()

func start_scenario():
	create_mission_1()
	add_child(mission)
	$Office.new_mission()
	$Office.connect("see_missionIntro", self, "mission_intro", [mission])
	$Office/HUDLayer/HUDOffice.connect("mission_accepted", self, "mission_accepte", [mission])
	$Office/HUDLayer/HUDOffice.connect("see_mission", mission, "show_text_mission")
	$Office/HUDLayer/HUDOffice.connect("see_system", self, "go_to_system")
	$System/HUDLayer/HUDSystem.connect("mission_finished", self, "mission_finished", [mission])
	mission.connect("thanks_ended", self, "startTimer")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	
	create_mission_2()
	add_child(mission)
	$Office.new_mission()
	$Office.connect("see_missionIntro", self, "mission_intro", [mission])
	mission.connect("thanks_ended", self, "startTimer")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	
	create_mission_3()
	add_child(mission)
	$Office.new_mission()
	$Office.connect("see_missionIntro", mission, "show_intro_mission")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission.queue_free()
	end_game()


func go_to_system():
	var money = int($Office/HUDLayer/HUDOffice.get_money())
	$System/HUDLayer/HUDSystem.give_money_value(money)
	$Office.hide_buttons()
	$System.show()
	
func mission_intro(mission):
	mission.show_intro_mission()
	$Office/HUDLayer/HUDOffice.show_ordi_accept()
	
func mission_accepte(mission):
	mission.hide()
	$Office/HUDLayer/HUDOffice.mission_validated(mission)
	
func mission_finished(text, tmp_min, tmp_max, gas, _mission):
	$Office/HUDLayer/HUDOffice.add_to_money(-text)
	var prestige = _mission.check_if_done(tmp_min, tmp_max, gas)
	#if prestige > 50:
	print(prestige)
	$System.hide()
	$Office.show()
	$Office/HUDLayer/HUDOffice.objectif_hide()
	$Office/HUDLayer/HUDOffice/OrdiIdle.show()
	$EntreMissions.start()

func end_game():
	$System.hide()
	$Office.hide()
	$IntroEnd.end_game()

func _on_HUD_start_game():
	$Office.show()
	$BeforeAnimOrdi.start()

func startTimer():
	$EntreMissions.start()

func _on_BeforeAnimOrdi_timeout():
	$BeforeAnimOrdi.stop()
	$Office/HUDLayer/HUDOffice.start_anim_ordi()
	start_scenario()


func create_mission_1():
	var descri = "bliblibloblo blubli blio\n \n aze\n jzef"
	var thanks = "My thanks"
	mission.update_descr(descri)
	mission.update_thank(thanks)
	mission.update_values(0, 40, "oxygene", 1500, "res://assets/aliens/alien_ET.png")
	
func create_mission_2():
	var descri = "ceci est la deuxieme mission"
	mission.update_descr(descri)
	mission.update_values(-20, 10, "azote", 400, "res://assets/aliens/alien_mars.png")
	
func create_mission_3():
	var descri = "au secours c'est la fin"
	mission.update_descr(descri)
	mission.update_values(20, 55, "zemon", 1000,  "res://assets/aliens/alien_xenomorph_half.png")
