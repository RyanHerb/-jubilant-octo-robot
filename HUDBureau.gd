extends Node2D

export (PackedScene) var Mission


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
	
#func miniature_mission():
	#$RecapMission.text = str($Mission.max_temperature)
	#comment construir le text ???
#affiche aussi le pourcentage de finition de la mission

func start_game():
	var cpt


func show_intro_mission():
	$AcceptMission.show()
	$DescMission.show()


func _on_AcceptMission_pressed():
	$RecapMission.show()
	$AcceptMission.hide()
	$DescMission.hide()
