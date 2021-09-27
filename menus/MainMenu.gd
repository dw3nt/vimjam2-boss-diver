extends "res://menus/BaseMenu.gd"

export(String, FILE, "*.tscn") var interviewScene
export(String, FILE, "*.tscn") var practiceScene

onready var menuContainer = $MenuContainer
onready var anim = $AnimationPlayer
onready var storyIntro = $StoryIntro
onready var competitorSelector = $CompetitorSelector


func _ready() -> void:
	ChallengerTracker.chooseChallenger()
	ChallengerTracker.currentChallengerKey += 1
	ChallengerTracker.chooseChallenger()
	ChallengerTracker.currentChallengerKey = 0
	
	print(ChallengerTracker.currentChallengerData)
	print(ChallengerTracker.currentChallengerKey)
	
	yield(get_tree().create_timer(0.1), "timeout")
	competitorSelector.initCardPos()
	competitorSelector.updateButtonActive()
	competitorSelector.flipLeftButton()
	emit_signal("room_ready")


func _on_PlayButton_pressed() -> void:
	competitorSelector.currentCard.data = ChallengerTracker.getCurrentChallenger()
	competitorSelector.currentCard.initCard()
	anim.play("challenger_card_slide_in")


func _on_PracticeButton_pressed() -> void:
	emit_signal("room_change_requested", {
		"scene": practiceScene,
		"transition": transition
	})


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_StoryIntro_scroll_finished():
	emit_signal("room_change_requested", {
		"scene": interviewScene,
		"transition": transition
	})


func _on_HowToButton_pressed():
	anim.play("how_to_slide_in")


func _on_HowToMenu_main_menu_pressed():
	anim.play_backwards("how_to_slide_in")
	
	
func _on_CreditsButton_pressed():
	anim.play("credits_slide_in")


func _on_CreditsMenu_main_menu_pressed():
	anim.play_backwards("credits_slide_in")


func _on_CompetitorSelector_competitor_challenge_pressed():
	emit_signal("room_change_requested", {
		"scene": interviewScene,
		"transition": transition
	})


func _on_CompetitorSelector_competitor_menu_pressed():
	anim.play_backwards("challenger_card_slide_in")
