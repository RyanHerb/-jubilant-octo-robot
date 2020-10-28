extends CanvasLayer

signal start_game
signal start_new_game

func _ready():
	$Area2D.hide()
	$Commentaire.hide()
	$ThanksForPlaying.hide()
	$Area2D/Lore.text = tr("KEY_LORE")
	$PlayAgain.hide()
	$Credits.hide()
	$Credits.text = tr("KEY_CREDITS")

func show_message(text):
	$Titre.text = text
	$Titre.show()
	
func show_game_over():
	$ThanksForPlaying.show()
	$Credits.show()
	$PlayAgain.show()

func update_money(value):
	$Money.text = str(int($Money.text)+value)

func new_game():
	$ASS.show()
	$Area2D.hide()
	$Zone2D.show()
	$Mute.show()

func comment_result(prestige, prestige_max, money, money_max):
	$Commentaire.show()
	$Commentaire.choose_comments(prestige, prestige_max)
	$Commentaire.choose_comments_money(money, money_max)

# =============
# = Callbacks =
# =============

func _on_Zone2D_enter():
	$ASS.hide()
	$Area2D.show()
	$LanguageFr.hide()
	$LanguageUK.hide()
	$clic.play()
	$lore_val.play()

func _on_Area2D_loreEnd():
	$lore_val.stop()
	$Area2D.hide()
	$Background.hide()
	$clic.play()
	$Mute.hide()
	emit_signal("start_game")

func _on_Commentaire_Comment_end():
	$Commentaire.hide()
	$clic.play()
	show_game_over()

func _on_PlayAgain_pressed():
	$ThanksForPlaying.hide()
	$PlayAgain.hide()
	$Credits.hide()
	$clic.play()
	emit_signal("start_new_game")
