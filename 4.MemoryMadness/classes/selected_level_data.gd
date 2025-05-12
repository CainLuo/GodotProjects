class_name  SelectedLevelData

var _selected_level_images: Array[ItemImage]
var _tartget_pairs: int
var _num_cols: int

func _init(num_cols: int, 
		tartget_pairs: int, 
		selected_level_images: Array[ItemImage]
		) -> void:
	_num_cols = num_cols
	_tartget_pairs = tartget_pairs
	_selected_level_images = selected_level_images

func get_selected_level_images() -> Array[ItemImage]:
	return _selected_level_images

func get_tartget_pairs() -> int:
	return _tartget_pairs

func get_num_cols() -> int:
	return _num_cols
