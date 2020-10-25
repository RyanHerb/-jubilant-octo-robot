extends Node2D

var min_temperature
var max_temperature
var temp_asked
var atmosphere = "Oxygen"
var budget
var repartition_point = [50, 50] #temperature, gaz
var prestige_good_job = 60 # au dessus de ce prestige, l'alien est content!
var coef_prestige

func _ready():
	hide()
	hide_alien()
	

func check_atmosphere(atm):
	return atm == atmosphere
	
func check_temp(min_temp_planet, max_temp_planet):
	var moy_pl = (float(max_temp_planet) + float(min_temp_planet)) / 2
	if (moy_pl < min_temperature
	or moy_pl > max_temperature):
		return 0
	
	var moy_m = (float(min_temperature) + float(max_temperature)) / 2
	var point_temp = float(repartition_point[0])
	var res = (point_temp - ((abs(float(max_temperature) -moy_m) / point_temp) * abs(moy_m - moy_pl)))
	if res < 0 :
		res = 0
	return res
	
func check_if_done(min_temp, max_temp, atm):
	var progress = 0
	if (check_atmosphere(atm)):
		progress += repartition_point[1]
	progress += check_temp(min_temp, max_temp)
	#progress /=20
	return progress
	
func show_ending_mission(min_temp, max_temp, atm):
	$Alien.show()
	var prestige = check_if_done(min_temp, max_temp, atm)
	if (prestige >= prestige_good_job):
		$ThanksCools.show()
		$mission_success.play()
	else:
		$ThanksNuls.show()
		$mission_fail.play()
	$Prestige.compute_stars(int(prestige))
	$Prestige.show()
	#prestige *= coef_prestige
	return int(prestige)

func update_descr(text):
	$Description.text = text

func update_thank(cools, nuls):
	$ThanksCools.text = cools
	$ThanksNuls.text = nuls

func update_values(min_tmp, max_tmp, tmp_asked, gaz, money, prestige, file):
	min_temperature = min_tmp
	max_temperature = max_tmp
	atmosphere = gaz
	temp_asked = tmp_asked
	budget = money
	coef_prestige = prestige
	var sprite = load(file)
	$Alien.texture = sprite
	var string = "Budget: %s$" %[money] 
	$Budget.text = string

# =============
# =  Display  =
# =============

func show_intro_mission():
	self.show()
	$IntroSound.play()

func show_text_mission(text_mission):
	if text_mission:
		$Description.show()
	else:
		$Description.hide()

func hide():
	$Description.hide()
	$ThanksCools.hide()
	$ThanksNuls.hide()
	$Prestige.hide()
	$Budget.hide()

func show():
	$Description.show()
	$Alien.show()
	$Budget.show()

func hide_alien():
	$Alien.hide()

# =========
# = Utils =
# =========

func get_min_tmp():
	return min_temperature

func get_max_tmp():
	return max_temperature
	
func get_asked_tmp():
	return temp_asked
	
func get_gaz():
	return atmosphere
	
func get_budget():
	return budget
	
func get_desc():
	return $Description.text
	
func get_buget():
	return budget

func get_coef_prestige():
	return coef_prestige

func set_intro_sound(path):
	$IntroSound.stream = load(path)
