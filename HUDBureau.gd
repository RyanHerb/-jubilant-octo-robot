extends Node2D

export (PackedScene) var Mission


signal see_mission(text)
signal see_missionIntro
signal see_system

func _ready():
	$AffichMissionButton.hide()
	$ToSystemButton.hide()
	$Objectifs.hide()
	show_money_prestige()
	start_game()

func start_game():
	pass

func new_mission():
	$NewMission.show()

func mission_validated(mission):
	$Objectifs.show()
	$AffichMissionButton.show()
	update_money(mission.get_budget())
	$Objectifs.clear()
	$Objectifs.add_text(str(mission.get_min_tmp()))
	$Objectifs.add_text(" - ")
	$Objectifs.add_text(str(mission.get_max_tmp()))
	$Objectifs.add_text("\n")
	$Objectifs.add_text(mission.get_gaz())
	$ToSystemButton.show()

func update_money(somme):
	$Money.text = str(int($Money.text) + somme)

func update_prestige():
	$Prestige.text = str(int($Prestige.text)+ 1)

func hide_all():
	$AffichMissionButton.hide()
	hide_money_prestige()
	$Objectifs.hide()
	$FinishMissionButton.hide()
	$NewMission.hide()

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


func _on_AffichMissionButton_pressed():
	#$AffichMissionButton.hide()
	if $AffichMissionButton.text == "show":
		$AffichMissionButton.text = "hide"
	else:
		$AffichMissionButton.text = "show"
	emit_signal("see_mission", $AffichMissionButton.text)

func _on_NewMission_pressed():
	$NewMission.hide()
	emit_signal("see_missionIntro")

func _on_ToSystemButton_pressed():
	$ToSystemButton.hide()
	emit_signal("see_system")
