extends Node2D

signal mission_accepte
signal mission_refuse

var min_temperature = 0
var max_temperature = 1
var atmosphere = "oxygen"
var budget = 1500


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func check_atmosphere(atm):
	return atm == atmosphere
	
func check_temp(min_temp_planet, max_temp_planet):
	var progress = 50
	if (min_temp_planet < min_temperature):
		progress -= abs(min_temperature - min_temp_planet)
	if (max_temp_planet > max_temperature):
		progress -= abs(max_temp_planet - max_temperature)
	if progress < 0:
		progress = 0
	return progress
	
func check_if_done(min_temp, max_temp, atm):
	var progress = 0
	if (check_atmosphere(atm)):
		progress += 50
	progress += check_temp(min_temp, max_temp)
	return progress
	

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_all()
	
func hide_all():
	$Accepter.hide()
	$Refuser.hide()
	$Description.hide()

func show_intro_mission():
	$Accepter.show()
	$Description.show()
	#$Refuser.show()


func update_descr(text):
	$Description.text = text


func get_buget():
	return budget

func update_values(min_tmp, max_tmp, gaz, money):
	min_temperature = min_tmp
	max_temperature = max_tmp
	atmosphere = gaz
	budget = money

func get_desc():
	return $Description.text
	
func get_min_tmp():
	return min_temperature

func get_max_tmp():
	return max_temperature
	
func get_gaz():
	return atmosphere
	
func get_budget():
	return budget



func _on_Accepter_pressed():
	emit_signal("mission_accepte", self)
	$Accepter.hide()
	$Refuser.hide()
	$Description.hide()


func _on_Refuser_pressed():
	$Accepter.hide()
	$Refuser.hide()
	$Description.hide()
	emit_signal("mission_refuse")
