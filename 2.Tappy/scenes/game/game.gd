extends Node2D

const PIPES = preload("res://scenes/pipes/pipes.tscn")

@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL

@onready var spawn_timer: Timer = $SpawnTimer

@onready var pipes_holder: Node = $PipesHolder

func _ready() -> void:
	ScoreManager.set_score(0)
	SignalManager.on_plane_died.connect(_on_plane_died)
	spawn_pipes()

func _process(delta: float) -> void:
	pass

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var yp: float = randf_range(spawn_u.position.y, spawn_l.position.y)
	
	pipes_holder.add_child(new_pipes)
	new_pipes.global_position = Vector2(spawn_l.position.x, yp)

#func stop_pipes() -> void:
	#spawn_timer.stop()

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func _on_plane_died() -> void:
	spawn_timer.stop()
