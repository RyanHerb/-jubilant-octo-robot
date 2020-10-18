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
	$System.init()
	add_child(mission)
	$Office.new_mission()
	$Office/HUDLayer/HUDOffice.connect("see_missionIntro", self, "mission_intro", [mission])
	$Office/HUDLayer/HUDOffice.connect("mission_accepted", self, "mission_accepte", [mission])
	$Office/HUDLayer/HUDOffice.connect("see_mission", mission, "show_text_mission")
	$Office/HUDLayer/HUDOffice.connect("see_system", self, "go_to_system", [mission])
	$System/HUDLayer/HUDSystem.connect("mission_finished", self, "mission_validated", [mission])
	$Office/HUDLayer/HUDOffice.connect("thanks_ended", self, "mission_finished", [mission])
	#mission.connect("thanks_ended", self, "startTimer")
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	
	create_mission_2()
	$System.reinit()
	$Office.new_mission()
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	
	create_mission_3()
	$System.reinit()
	$Office.new_mission()
	yield($EntreMissions, "timeout")
	$EntreMissions.stop()
	mission.queue_free()
	end_game()

func go_to_system(_mission):
	var money = int($Office/HUDLayer/HUDOffice.get_money())
	$System/HUDLayer/HUDSystem.give_money_value(money)
	$Office.hide_buttons()
	$Office/HUDLayer/HUDOffice.hide_prestige()
	$System.show()
	_mission.hide()
	
	
func mission_intro(_mission):
	_mission.show_intro_mission()
	_mission.get_node('IntroSound').play()
	$Office/HUDLayer/HUDOffice.show_ordi_accept()
	
func mission_accepte(_mission):
	_mission.hide()
	$Office/HUDLayer/HUDOffice.mission_validated(mission)
	
func mission_validated(text, tmp_min, tmp_max, gas, _mission):
	$Office/HUDLayer/HUDOffice.add_to_money(-text)
	$System.hide()
	$Office.show()
	$Office/HUDLayer/HUDOffice.objectif_hide()
	$Office/HUDLayer/HUDOffice/OrdiIdle.show()
	$Office/HUDLayer/HUDOffice.color_descr(1)
	var prestige = _mission.show_ending_mission(tmp_min, tmp_max, gas)
	$Office/HUDLayer/HUDOffice.add_to_prestige(prestige)
	$Office/HUDLayer/HUDOffice.show_thank()
	$Office/HUDLayer/HUDOffice.show_prestige()

func mission_finished(_mission):
	_mission.hide()
	startTimer()

func end_game():
	$System.hide()
	$Office.hide()
	var pres = $Office/HUDLayer/HUDOffice.get_prestige()
	$IntroEnd.comment_result(pres, 600)

func startTimer():
	$EntreMissions.start()

# =============
# = Callbacks =
# =============

func _on_Office_animation_finished():
	start_scenario()

func _on_BeforeAnimOrdi_timeout():
	$BeforeAnimOrdi.stop()
	$Office/HUDLayer/HUDOffice.start_anim_ordi()

func _on_HUD_start_game():
	$Office.show()
	$BeforeAnimOrdi.start()

# ====================
# = List of missions =
# ====================

func create_mission_1():
	var descri = "bliblibloblo blubli blio\n \n aze\n jzef"
	mission.update_descr(descri)
	var thanksBien = "My thanks"
	var thanksNuls = "Hum... well, I may asked too much."
	mission.update_thank(thanksBien, thanksNuls)
	mission.update_values(-60, 100, 20, "Oxygen", 1000, 1, "res://assets/aliens/alien_ET.png")
	mission.set_intro_sound("res://assets/sounds/ET.wav")
	
func create_mission_2():
	var descri = "ceci est la deuxieme mission"
	mission.update_descr(descri)
	var thanksBien = "Thank you"
	var thanksNuls = "Just asking for a friend... how important is your army?"
	mission.update_thank(thanksBien, thanksNuls)
	mission.update_values(-50, 20, -10, "Nitrogen", 700, 2, "res://assets/aliens/alien_mars_double.png")
	mission.set_intro_sound("res://assets/sounds/martian.wav")
	
func create_mission_3():
	var descri = "au secours c'est la fin"
	mission.update_descr(descri)
	var thanksBien = "... let's go"
	var thanksNuls = "You will die!"
	mission.update_thank(thanksBien, thanksNuls)
	mission.update_values(-70,-30, -50, "Xenon", 500, 3,  "res://assets/aliens/alien_xenomorph_half.png")
	mission.set_intro_sound("res://assets/sounds/xenomorph.wav")
