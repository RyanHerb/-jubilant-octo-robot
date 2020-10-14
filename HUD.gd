extends CanvasLayer

signal start_game

func _ready():
	$NextLoreButton.hide()
	$Lore.hide()


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
	$StartButton.show()
	$Lore.hide()
	$NextLoreButton.hide()

func end_game():
	show_game_over()

# =============
# = Callbacks =
# =============

func _on_Start_pressed():
	$Titre.hide()
	$StartButton.hide()
	$Lore.show()
	$NextLoreButton.show()


func _on_NextLoreButton_pressed():
	$Lore.hide()
	$NextLoreButton.hide()
	$Background.hide()
	emit_signal("start_game")
