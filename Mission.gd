extends Node2D

var min_temperature
var max_temperature
var temp_asked
var atmosphere = tr("KEY_OXYGEN")
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
	$Prestige/Review.set_text(tr("KEY_MIS_REVIEW"))
	return int(prestige)

func update_descr(text):
	$Description.text = text

func update_thank(cools, nuls):
	$ThanksCools.text = cools
	$ThanksNuls.text = nuls

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

func load_mission_json(fname):
	var file = File.new()
	file.open("res://missions/%s" % fname, file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json)
	file.close()
	return json_result

func load_json(mission_json):
	min_temperature = mission_json['min_temp']
	max_temperature = mission_json['max_temp']
	temp_asked = mission_json['requested_temp']
	atmosphere = mission_json['gas']
	budget = mission_json['money']
	coef_prestige = mission_json['prestige_coef']

	$Budget.text = "%s %s$" %[tr("KEY_BUDGET"), budget]
	$Alien.texture = load('res://asssets/aliens/%s' % mission_json['sprite'])
	set_intro_sound('res://assets/sounds/%s' % mission_json['voice'])
