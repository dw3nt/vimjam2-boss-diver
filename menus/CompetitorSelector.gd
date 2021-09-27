extends Control

signal competitor_challenge_pressed
signal competitor_menu_pressed

const SLIDE_LEFT_POS = Vector2(-320, 33)
const SLIDE_RIGHT_POS = Vector2(320, 33)
const SLIDE_MIDDLE_POS = Vector2(39, 33)

var currentCard
var hiddenCard

onready var tween = $Tween
onready var cardWrap = $CardWrap
onready var cardWrapCenter = $CardWrap/CenterContainer
onready var card1 = $CardWrap/CenterContainer/CompetitorCard
onready var card2 = $CardWrap/CenterContainer/CompetitorCard2

onready var leftButton = $CardWrap/LeftButton
onready var rightButton = $CardWrap/RightButton


func _ready() -> void:
	currentCard = card1
	hiddenCard = card2
	
	updateButtonActive()
	
	
func initCardPos() -> void:
	currentCard.rect_position = SLIDE_MIDDLE_POS
	hiddenCard.rect_position = SLIDE_LEFT_POS
	
	
func flipLeftButton() -> void:
	leftButton.rect_pivot_offset = Vector2(8, 8)
	leftButton.rect_rotation = 180
	
	
func updateButtonActive() -> void:
	leftButton.disabled = ChallengerTracker.currentChallengerKey == 0
	rightButton.disabled = ChallengerTracker.currentChallengerData[ChallengerTracker.currentChallengerKey + 1] == null


func previousChallenger() -> void:
	ChallengerTracker.currentChallengerKey = max(0, ChallengerTracker.currentChallengerKey - 1)
	hiddenCard.data = ChallengerTracker.getCurrentChallenger()
	hiddenCard.initCard()
	
	tween.interpolate_property(currentCard, "rect_position", currentCard.rect_position, SLIDE_LEFT_POS, 0.6)
	tween.interpolate_property(hiddenCard, "rect_position", SLIDE_RIGHT_POS, SLIDE_MIDDLE_POS, 0.6)
	tween.start()
	
	
func nextChallenger() -> void:
	if ChallengerTracker.currentChallengerData[ChallengerTracker.currentChallengerKey + 1] == null:
		return
	
	ChallengerTracker.currentChallengerKey = min(ChallengerTracker.currentChallengerData.size() - 1, ChallengerTracker.currentChallengerKey + 1)
	hiddenCard.data = ChallengerTracker.getCurrentChallenger()
	hiddenCard.initCard()
	
	tween.interpolate_property(currentCard, "rect_position", currentCard.rect_position, SLIDE_RIGHT_POS, 0.6)
	tween.interpolate_property(hiddenCard, "rect_position", SLIDE_LEFT_POS, SLIDE_MIDDLE_POS, 0.6)
	tween.start()


func _on_Tween_tween_all_completed() -> void:
	var tempCard = currentCard
	currentCard = hiddenCard
	hiddenCard = tempCard
	updateButtonActive()


func _on_LeftButton_pressed() -> void:
	previousChallenger()


func _on_RightButton_pressed() -> void:
	nextChallenger()


func _on_CompetitorCard_challenge_pressed():
	emit_signal("competitor_challenge_pressed")


func _on_CompetitorCard_main_menu_pressed():
	emit_signal("competitor_menu_pressed")
