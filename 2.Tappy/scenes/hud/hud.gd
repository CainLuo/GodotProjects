extends Control

@onready var score_label: Label = $scoreLabel

func _ready() -> void:
	SignalManager.on_score_updated.connect(_on_score_updated)

func _on_score_updated(score: int) -> void:
	score_label.text = str(score)
