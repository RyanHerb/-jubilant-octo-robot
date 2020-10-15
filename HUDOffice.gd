extends Node2D

export (PackedScene) var Mission

signal see_mission(text)
signal see_missionIntro
signal see_system

func _ready():
	$AffichMissionButton.hide()
	$Objectifs.hide()
	$MissionWaitingLabel.hide()
	$ToSystem.hide()
	$OrdiIdle.hide()
	$CallClient.hide()
	$OrdiAllumage.hide()
	show_money_prestige()
	start_game()

func start_game():
	pass

func new_mission():
	#$NewMission.show()
	$CallClient.show()
	$MissionWaitingLabel.show()

func mission_validated(mission):
	$Objectifs.show()
	$AffichMissionButton.show()
	update_money(mission.get_budget())
	$Objectifs.clear()
	$Objectifs.add_text(str(mission.get_min_tmp()))
	$Objectifs.add_text(" °C - ")
	$Objectifs.add_text(str(mission.get_max_tmp()))
	$Objectifs.add_text(" °C\n")
	$Objectifs.add_text(mission.get_gaz())
	$OrdiIdle.hide()
	$ToSystem.show()

func update_money(somme):
	$Money.text = str(int($Money.text) + somme)

func update_prestige():
	$Prestige.text = str(int($Prestige.text)+ 1)

func hide_buttons():
	$AffichMissionButton.hide()
	$FinishMissionButton.hide()
	$CallClient.hide()
	$MissionWaitingLabel.hide()

func show_interface():
	show_money_prestige()

func show_money_prestige():
	$Money.show()
	$SymboleMoney.show()
	$Prestige.show()
	$SymbolePrestige.show()

func hide_money_prestige():
	$Money.hide()
	$SymboleMoney.hide()
	$Prestige.hide()
	$SymbolePrestige.hide()

func objectif_hide():
	$Objectifs.hide()
	$AffichMissionButton.hide()
	
func objectif_show():
	$Objectifs.show()
	$AffichMissionButton.show()

func start_anim_ordi():
	$OrdiAllumage.show()
	$OrdiAllumage.play()
	$OrdiFerme.hide()

# =============
# = Callbacks =
# =============

func _on_AffichMissionButton_pressed():
	if $AffichMissionButton.text == "show":
		$AffichMissionButton.text = "hide"
	else:
		$AffichMissionButton.text = "show"
	emit_signal("see_mission", $AffichMissionButton.text)

func hide_mission_descr():
	$CallClient.hide()
	$MissionWaitingLabel.hide()

func _on_OrdiAllumage_animation_finished():
	$OrdiAllumage.hide()
	$OrdiAllumage.stop()
	$OrdiIdle.show()

func _on_Timer_timeout():
	$Timer.stop()
	$OrdiAllumage.show()
	$OrdiAllumage.play()
	$OrdiFerme.hide()
	show_money_prestige()
#	start_game()
	$CallClient.show()
	emit_signal("start_game")


func _on_ToSystem_click_to_system():
	#$OrdiIdle.hide()
	$ToSystem.hide()
	emit_signal("see_system")
