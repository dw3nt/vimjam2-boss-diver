extends Control

signal update_labels_requested(nameLabel, roundLabel, pointsLabel)

onready var nameLabel = $MarginContainer/VBoxContainer/ChallengerNameLabel
onready var roundLabel = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/RoundLabel
onready var pointsLabel = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/ChallengerPointsLabel


func _ready() -> void:
	updateLabels()


func updateLabels() -> void:
	emit_signal("update_labels_requested", nameLabel, roundLabel, pointsLabel)
