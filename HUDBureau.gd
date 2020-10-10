extends Node2D

export (PackedScene) var Mission

signal mission_finished


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
	$AcceptMission.hide()
	$DescMission.hide()
	$FinishMissionButton.hide()
	$Fin.hide()
	$RefuseMission.hide()
	
#func miniature_mission():
	#$RecapMission.text = str($Mission.max_temperature)
	#comment construir le text ???
#affiche aussi le pourcentage de finition de la mission

func start_game():
	var cpt

func end_game():
	$Fin.show()

func show_intro_mission():
	$AcceptMission.show()
	#$DescMission.text = mission.getDescr()
	$DescMission.show()
	$RefuseMission.show()

func update_description_mission(text):
	$DescMission.text = text


func _on_AcceptMission_pressed():
	$RecapMission.show()
	$AcceptMission.hide()
	$DescMission.hide()
	$FinishMissionButton.show()
	$RefuseMission.hide()
	#ajouter budget à Money


func _on_FinishMissionButton_pressed():
	$FinishMissionButton.hide()
	$RecapMission.hide()
	emit_signal("mission_finished")


func _on_RefuseMission_pressed():
	$AcceptMission.hide()
	$RefuseMission.hide()
	$DescMission.hide()
	emit_signal("mission_finished")
