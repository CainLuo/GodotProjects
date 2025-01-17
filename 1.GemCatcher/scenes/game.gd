extends Node2D

const EXPLODE = preload("res://assets/explode.wav")

@export var gem_scene: PackedScene

@onready var label: Label = $Label
@onready var gameOverLabel: Label = $Label2

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var timer: Timer = $Timer

var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.z_index = 1
	gameOverLabel.z_index = 1
	gameOverLabel.visible = false
	_spawn_gem()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	var xpos: float = randf_range(70, 1050)
	new_gem.on_gem_off_screen.connect(game_over)
	new_gem.position = Vector2(xpos, -70)
	add_child(new_gem)

func game_over() -> void:
	stop_all()
	play_dead()
	gameOverLabel.visible = true

func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func play_dead() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()

func _on_timer_timeout() -> void:
	_spawn_gem()

func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	# 第一种方法：可以通过这种方式获取到控件，但如果该控件多
	# $Label.text = ""
	#label.text = str(_score)
	label.text = "%04d" % _score
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	area.queue_free()
