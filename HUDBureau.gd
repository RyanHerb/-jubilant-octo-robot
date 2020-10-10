extends Node2D

export (PackedScene) var Mission

signal mission_finished
signal see_mission
signal see_missionIntro


func _ready():
	$AffichMissionButton.show()
	$Money.show()
	$Prestige.show()
	start_game()

func hide_all():
	$AffichMissionButton.hide()
	$Money.hide()
	$Prestige.hide()
	$RecapMission.hide()
	$FinishMissionButton.hide()
	$Fin.hide()
	$NewMission.hide()
	
#func miniature_mission():
	#$RecapMission.text = str($Mission.max_temperature)
	#comment construir le text ???
#affiche aussi le pourcentage de finition de la mission

func show_interface():
	$Money.show()
	$Prestige.show()

func start_game():
	pass

func end_game():
	$Fin.show()

func new_mission():
	$NewMission.show()

func update_money(somme):
	$Money.text = str(int($Money.text) + somme)

func mission_validated(mission):
	$RecapMission.show()
	$FinishMissionButton.show()
	update_money(mission.get_budget())
	#ajouter budget à Money


func _on_FinishMissionButton_pressed():
	$FinishMissionButton.hide()
	$RecapMission.hide()
	emit_signal("mission_finished")


func _on_AffichMissionButton_pressed():
	$AffichMissionButton.hide()
	emit_signal("see_mission")


func _on_NewMission_pressed():
	$NewMission.hide()
	emit_signal("see_missionIntro")
