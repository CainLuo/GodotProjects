extends Node

const SCORES_PATH = "user://tappy.dat"

var _score: int = 0
var _high_score: int = 0

func _ready() -> void:
	load_high_score()

func set_score(score: int) -> void:
	_score = score
	if _score > _high_score:
		_high_score = _score
	SignalManager.on_score_updated.emit(_score)

func get_score() -> int:
	return _score

func get_hight_score() -> int:
	return _high_score

func increment_score() -> void:
	set_score(_score + 1)

func load_high_score() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			_high_score = file.get_as_text().to_int()
			print("✅✅✅ Loaded High Score:", file.get_path_absolute())
		else:
			print("🚫🚫🚫 Nothing in file")
		file.close()
	else:
		print("🚫🚫🚫 FAILED to load file")

func save_high_score_to_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	if file:
		file.store_string(str(_high_score))
		file.close()
