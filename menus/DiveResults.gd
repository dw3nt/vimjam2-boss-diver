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
	finalScoreLabel.rect_pivot_offset = finalScoreLabel.rect_size / 2
	
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
	setLabelsViaScore(totalPoints)
	finalScoreWrap.modulate = Color(1, 1, 1, 1)
	buttonsWrap.modulate = Color(1, 1, 1, 1)
	
	
func setLabelsViaScore(score : float) -> void:
	if score >= 24.0:
		finalScoreLabel.text = "BOSS!"
	elif score >= 20.0:
		finalScoreLabel.text = "Manager"
	elif score >= 16.0:
		finalScoreLabel.text = "Employee"
	elif score >= 14.0:
		finalScoreLabel.text = "Intern"
	else:
		finalScoreLabel.text = "FIRED!"
		
	finalScoreWrap.modulate = Color(1, 1, 1, 1)
	anim.play("score_zoom_out")


func _on_RetryButton_pressed():
	emit_signal("retry_button_pressed")


func _on_MainMenuButton_pressed():
	emit_signal("main_menu_button_pressed")
