extends CanvasLayer

signal start_game

func _ready():
	$Area2D.hide()


func show_message(text):
	$Titre.text = text
	$Titre.show()
	
func show_game_over():
	$Background.show()
	show_message("thanks for playing")
# Called when the node enters the scene tree for the first time.

func update_money(value):
	$Money.text = str(int($Money.text)+value)

func new_game():
	$Titre.show()
	$Area2D.hide()

func end_game():
	show_game_over()

# =============
# = Callbacks =
# =============

func _on_NextLoreButton_pressed():
	pass


func _on_Zone2D_enter():
	$Titre.hide()
	$Area2D.show()


func _on_Area2D_loreEnd():
	$Area2D.hide()
	$Background.hide()
	emit_signal("start_game")
