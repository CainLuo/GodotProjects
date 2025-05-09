extends Node

var _item_images: Array[ItemImage] = []

func _ready() -> void:
	var ir: ImageFilesList = load("res://resources/image_files_list.tres")
	
	for file_path in ir.get_file_names():
		add_file_to_list(file_path)

func add_file_to_list(file_path: String) -> void:
	var new_item_image: ItemImage = ItemImage.new(
		file_path.get_file(),
		load(file_path)
	)
	_item_images.append(new_item_image)
