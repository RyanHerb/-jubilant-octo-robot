extends Node2D

signal thanks_ended

var min_temperature = 0
var max_temperature = 1
var atmosphere = "oxygen"
var budget = 1500
var repartition_point = [50, 50] #temperature, gaz

func check_atmosphere(atm):
	print(atm == atmosphere)
	return atm == atmosphere
	
func check_temp(min_temp_planet, max_temp_planet):
	var moy_pl = (max_temp_planet + min_temp_planet) / 2
	print("moy_pl < min_m", moy_pl < min_temperature)
	print("moy_pl > max_m", moy_pl > max_temperature)
	if (moy_pl < min_temperature
	or moy_pl > max_temperature):
		return 0
	
	var moy_m = (min_temperature + max_temperature) / 2
	return (repartition_point[0] - (abs(max_temperature - moy_pl) / repartition_point[0]) * abs(moy_m - moy_pl))
	
func check_if_done(min_temp, max_temp, atm):
	var progress = 0
	if (check_atmosphere(atm)):
		progress += repartition_point[1]
	progress += check_temp(min_temp, max_temp)
	return progress
	

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func hide():
	$Description.hide()
	$Alien.hide()
	$ThanksCools.hide()
	$ThanksNuls.hide()
	$CloseThanks.hide()
	

func show():
	$Description.show()
	$Alien.show()

func show_intro_mission():
	self.show()

func show_ending_mission(min_temp, max_temp, atm):
	$Alien.show()
	var prestige = check_if_done(min_temp, max_temp, atm)
	if (prestige > 70):
		$ThanksCools.show()
	else:
		$ThanksNuls.show()
	$CloseThanks.show()

func show_text_mission(text):
	if text == "hide":
		$Description.show()
	else:
		$Description.hide()
		
func update_descr(text):
	$Description.text = text

func update_thank(cools, nuls):
	$ThanksCools.text = cools
	$ThanksNuls.text = nuls


func get_buget():
	return budget

func update_values(min_tmp, max_tmp, gaz, money, file):
	min_temperature = min_tmp
	max_temperature = max_tmp
	atmosphere = gaz
	budget = money
	var sprite = load(file)
	$Alien.texture = sprite

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

# =============
# = Callbacks =
# =============

func _on_CloseThanks_pressed():
	hide()
	emit_signal("thanks_ended")
