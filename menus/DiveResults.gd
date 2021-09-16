extends Control

signal retry_button_pressed
signal main_menu_button_pressed

var judgeCards : = []
var points : = []

onready var anim = $AnimationPlayer
onready var finalScoreWrap = $MarginContainer/CenterContainer/VBoxContainer/FinalScoreWrap
onready var finalScoreLabel = $MarginContainer/CenterContainer/VBoxContainer/FinalScoreWrap/FinalScoreLabel
onready var buttonsWrap = $MarginContainer/CenterContainer/VBoxContainer/ButtonsWrap


func _ready() -> void:
	finalScoreWrap.modulate = Color(1, 1, 1, 0)
	buttonsWrap.modulate = Color(1, 1, 1, 0)
	
	judgeCards.append($MarginContainer/CenterContainer/VBoxContainer/JudgeCardsWrap/JudgeCard1)
	judgeCards.append($MarginContainer/CenterContainer/VBoxContainer/JudgeCardsWrap/JudgeCard2)
	judgeCards.append($MarginContainer/CenterContainer/VBoxContainer/JudgeCardsWrap/JudgeCard3)


func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "fade_in":
		for i in range(judgeCards.size()):
			judgeCards[i].score = points[i]
			judgeCards[i].startFlipTimer()
			
		judgeCards[2].anim.connect("animation_finished", self, "_on_Card3Flip_card_flipped")
		

func _on_Card3Flip_card_flipped(anim_name) -> void:
	var totalPoints = points[0] + points[1] + points[2]
	finalScoreLabel.text = str("%.1f" % totalPoints)
	finalScoreWrap.modulate = Color(1, 1, 1, 1)
	buttonsWrap.modulate = Color(1, 1, 1, 1)


func _on_RetryButton_pressed():
	emit_signal("retry_button_pressed")


func _on_MainMenuButton_pressed():
	emit_signal("main_menu_button_pressed")
