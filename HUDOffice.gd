extends Node2D

export (PackedScene) var Mission

signal see_mission(text)
signal see_system
signal start_game
signal mission_accepted
signal animation_finished
signal thanks_ended
signal see_missionIntro

var prestige = 0
var coef_prestige = 0


func _ready():
	$AffichMissionButton.hide()
	$Objectifs.hide()
	$MissionWaitingLabel.hide()
	$ToSystem.hide()
	$OrdiIdle.hide()
	$OrdiAllumage.hide()
	$Accept.hide()
	show_money_prestige()
	$OrdiFerme.show()
	$CloseMission.hide()
	$MicSimple.show()
	$Mic.hide()
	
func new_mission():
	$MissionWaitingLabel.show()
	$Mic.show()
	$Mic/ButtonLightUp.play()
	$MicSimple.hide()
	
func mission_accepted(mission):
	$OrdiFerme.hide()
	$OrdiIdle.hide()
	$ToSystem.show()
	$Objectifs.show()
	$AffichMissionButton.show()
	add_to_money(mission.get_budget())
	var string = "Objectives:\n%s °C\n %s" %[str(mission.get_asked_tmp()), mission.get_gaz()]
	$Objectifs.text = string
	color_descr(0)
	$Objectifs.show()
	$OrdiIdle.hide()
	$ToSystem.show()
	$MicSimple.show()

func mission_validated(money, prestige, coef_prestige):
	add_to_money(-money)
	objectif_hide()
	$OrdiIdle.show()
	color_descr(1)
	update_prestige(prestige, coef_prestige)
	show_thank()
	show_prestige()

func add_to_money(somme):
	$Money.text = str(int($Money.text) + somme)
	$Accept/cash.play()

func update_prestige(prest_m, coef_prest_m):
	var sum_coeff_prestige = coef_prest_m + coef_prestige
	var up_prest = (float(prestige * coef_prestige) + float(prest_m * coef_prest_m)) / sum_coeff_prestige
	prestige = up_prest
	coef_prestige += int(coef_prest_m)
	$Prestige.text = str(stepify(prestige/20, 0.1))

func start_anim_ordi():
	$OrdiAllumage.show()
	$OrdiAllumage.play()
	$OrdiFerme.hide()
	$OrdiPower_sound.play()

func start_timer_intro():
	$Timer.start()

func color_descr(val):
	if (val == 0): # office in black
		$Objectifs.modulate = Color(0, 0, 0, 1)
	else: # system in white
		$Objectifs.modulate = Color(1, 1, 1, 1)


func endgame():
	$OrdiIdle.hide()
	$OrdiFerme.show()
	$Prestige.text = "0"
	$Money.text = "0"
	prestige = 0
	coef_prestige = 0

# =============
# =  Display  =
# =============

func show_ordi_accept():
	.hide()
	.show()
	$Accept.show()
	$OrdiIdle.hide()

func show_thank():
	$CloseMission.show()
	$ToSystem.hide()
	$MicSimple.show()

func show_money_prestige():
	$Money.show()
	$SymboleMoney.show()

func show_prestige():
	$Prestige.show()
	$SymbolePrestige.show()
	
func hide_money_prestige():
	$Money.hide()
	$SymboleMoney.hide()
	hide_prestige()

func hide_prestige():
	$Prestige.hide()
	$SymbolePrestige.hide()
	
func objectif_hide():
	$Objectifs.hide()
	$AffichMissionButton.hide()
	
func objectif_show():
	$Objectifs.show()
	$AffichMissionButton.show()

func hide_buttons():
	$AffichMissionButton.hide()
	$MissionWaitingLabel.hide()
	$MicSimple.hide()

func show_interface():
	show_money_prestige()

# =============
# = Callbacks =
# =============

func _on_AffichMissionButton_pressed():
	if $AffichMissionButton.text == "details":
		$AffichMissionButton.text = "hide"
	else:
		$AffichMissionButton.text = "details"
	emit_signal("see_mission", $AffichMissionButton.text)

func hide_mission_descr():
	$MissionWaitingLabel.hide()

func _on_OrdiAllumage_animation_finished():
	$OrdiAllumage.hide()
	$OrdiAllumage.stop()
	$OrdiIdle.show()
	emit_signal("animation_finished")

func _on_Timer_timeout():
	$Timer.stop()
	start_anim_ordi()
	show_money_prestige()
	emit_signal("start_game")

func _on_ToSystem_click_to_system():
	$ToSystem.hide()
	color_descr(1)
	emit_signal("see_system")

func _on_Accept_accept_mission():
	$Accept.hide()
	$ToSystem.show()
	emit_signal("mission_accepted")

func _on_CloseMission_thanks_ended():
	$CloseMission.hide()
	$OrdiIdle.show()
	emit_signal("thanks_ended")

func _on_Mic_click_lamp():
	$Mic.hide()
	$MicSimple.show()
	hide_mission_descr()
	emit_signal("see_missionIntro")

# =========
# = Utils =
# =========

func get_money():
	return int($Money.text)
	
func get_prestige():
	return float($Prestige.text)
