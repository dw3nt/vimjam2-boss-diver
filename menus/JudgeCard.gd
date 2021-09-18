extends TextureRect

export(float) var score
export(float) var flipTime

onready var anim = $AnimationPlayer as AnimationPlayer
onready var scoreLabel = $ScoreLabel as Label
onready var flipTimer = $FlipTimer as Timer


func _ready() -> void:
	rect_pivot_offset.x = rect_size.x / 2
	score = clamp(score, 0.0, 10.0)
	
	
func startFlipTimer() -> void:
	flipTimer.start(flipTime)
	
	
func setScoreText() -> void:
	scoreLabel.text = str("%.1f" % score)


func _on_FlipTimer_timeout():
	anim.play("flip_card")
