extends Node2D

var array_stars_icons = []

var prestigeFull = preload('res://assets/icons_ui/prestige.png')
var prestigeHalf = preload('res://assets/icons_ui/prestige_half.png')
var prestigeNone = preload('res://assets/icons_ui/prestige_empty.png')

func _ready():
	array_stars_icons = [$Prestige1, $Prestige2, $Prestige3, $Prestige4, $Prestige5]


func compute_stars(val): # int, valeur sur 100
	var prestige = round(val/10)
	var higher_star = prestige/2
	var val_higher_star = int(prestige)%2
	
	if prestige == 0 :
		array_stars_icons[0].texture = prestigeNone
	
	for i in range(0, higher_star):
		array_stars_icons[i].texture = prestigeFull
	
	for i in range(higher_star, 5):
		array_stars_icons[i].texture = prestigeNone
	
	if prestige > 0 and prestige < 10:
		if val_higher_star == 0:
			array_stars_icons[higher_star].texture = prestigeFull
		else :
			array_stars_icons[higher_star].texture = prestigeHalf

	if prestige == 10:
		array_stars_icons[4].texture = prestigeFull
