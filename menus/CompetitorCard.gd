extends Control

signal challenge_pressed
signal main_menu_pressed

const DIFFICULTY_IMAGE_WIDTH : = 20
const DIFFICULTY_IMAGE_HEIGHT : = 8

var data

onready var nameLabel = $VBoxContainer/CardDataWrap/DataWrap/DescriptionWrap/NameLabel
onready var flavorLabel = $VBoxContainer/CardDataWrap/DataWrap/DescriptionWrap/FlavorLabel
onready var diverImage = $VBoxContainer/CardDataWrap/ImageWrap/DiverImage
onready var difficultyImageWrap = $VBoxContainer/CardDataWrap/DataWrap/DifficultyWrap/DifficultyImageWrap
onready var difficultyImage = $VBoxContainer/CardDataWrap/DataWrap/DifficultyWrap/DifficultyImageWrap/DifficultyImage


func initCard() -> void:
	nameLabel.text = data.name
	flavorLabel.text = data.description
	diverImage.texture = data.image
	for i in range(data.difficulty - 1):
		var inst = difficultyImage.duplicate()
		difficultyImageWrap.add_child(inst)


func _on_MainMenuButton_pressed() -> void:
	emit_signal("main_menu_pressed")


func _on_ChallengeButton_pressed() -> void:
	emit_signal("challenge_pressed")
