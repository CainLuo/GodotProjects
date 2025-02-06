extends Control

@onready var highscore_label: Label = $MarginContainer/HighscoreLabel

func _ready() -> void:
	highscore_label.text = str(ScoreManager.get_hight_score())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()
