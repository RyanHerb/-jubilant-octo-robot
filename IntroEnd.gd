extends CanvasLayer

signal start_game
var loreText = "Bienvenu au bureau de Asylum Seekers from Space. Votre mission sera d'aider les Aliens venus vous demander de l'aider pour construire leur nouveau foyer. Ecoutez leur requête et créez leur nouvelle planète suivant leur critères."


func _ready():
	$Area2D.hide()
	$Commentaire.hide()
	$ThanksForPlaying.hide()
	$Area2D/Lore.text = loreText


func show_message(text):
	$Titre.text = text
	$Titre.show()
	
func show_game_over():
	$ThanksForPlaying.show()
# Called when the node enters the scene tree for the first time.

func update_money(value):
	$Money.text = str(int($Money.text)+value)

func new_game():
	$ASS.show()
	$Area2D.hide()

func comment_result(prestige, prestige_max):
	$Commentaire.show()
	$Commentaire.choose_comments(prestige, prestige_max)

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
