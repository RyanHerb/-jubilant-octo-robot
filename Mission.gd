extends Node2D

var descriptif
var min_temperature
var max_temperature
var atmosphere
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
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
