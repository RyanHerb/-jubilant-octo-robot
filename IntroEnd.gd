extends CanvasLayer

signal start_game
signal start_new_game
var loreText = "Welcome to your social worker’s space office ! \nYour mission, should you choose to accept it, is to help asylum seekers from space find a new home.\nListen to their requests and build them the perfect planet to meet their needs !"
var credits = "Credits:\nDeveloppers:  Abytron Bananaman Cyanael\nArtwork and sound:  Abytron\nVoices:  Bananaman Valhanya"

func _ready():
	$Area2D.hide()
	$Commentaire.hide()
	$ThanksForPlaying.hide()
	$Area2D/Lore.text = loreText
	$PlayAgain.hide()
	$Credits.hide()
	$Credits.text = credits


func show_message(text):
	$Titre.text = text
	$Titre.show()
	
func show_game_over():
	$ThanksForPlaying.show()
	$Credits.show()
	$PlayAgain.show()
# Called when the node enters the scene tree for the first time.

func update_money(value):
	$Money.text = str(int($Money.text)+value)

func new_game():
	$ASS.show()
	$Area2D.hide()
	$Zone2D.show()

func comment_result(prestige, prestige_max, money, money_max):
	$Commentaire.show()
	$Commentaire.choose_comments(prestige, prestige_max)
	$Commentaire.choose_comments_money(money, money_max)

#func end_game():
	#show_game_over()

# =============
# = Callbacks =
# =============

func _on_Zone2D_enter():
	$ASS.hide()
	$Area2D.show()


func _on_Area2D_loreEnd():
	$Area2D.hide()
	$Background.hide()
	emit_signal("start_game")


func _on_Commentaire_Comment_end():
	$Commentaire.hide()
	show_game_over()


func _on_PlayAgain_pressed():
	$ThanksForPlaying.hide()
	$PlayAgain.hide()
	$Credits.hide()
	emit_signal("start_new_game")
	
