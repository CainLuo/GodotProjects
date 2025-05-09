@tool
extends Node

const PATH: String = "res://assets/glitch/"
const RESOURCE_PATH = "res://resources/image_files_list1.tres"

func _ready() -> void:
	var dir: DirAccess = DirAccess.open(PATH)
	
	var ifl: ImageFilesList = ImageFilesList.new()

	if dir:
		var files: PackedStringArray = dir.get_files()

		for fn in files:
			ifl.add_filename(PATH + fn)
	ResourceSaver.save(ifl, RESOURCE_PATH)
