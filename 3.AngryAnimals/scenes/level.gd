extends Node2D

const ANIMAL = preload("res://scenes/animal.tscn")

@onready var animal_start: Marker2D = $AnimalStart

func _ready() -> void:
	SignalManager.on_animal_die.connect(add_animal)
	add_animal()

func add_animal() -> void:
	var animal = ANIMAL.instantiate()
	animal.position = animal_start.position
	add_child(animal)
