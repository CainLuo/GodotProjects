extends TextureRect

const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_NORMAL: Vector2 = Vector2(1.0, 1.0)
const SPIN_TIME_RANGE: Vector2 = Vector2(1.0, 2.0)
const SCALE_TIME: float = 1

func _ready() -> void:
	set_random_image()
	run_me()

func _process(delta: float) -> void:
	pass

func set_random_image() -> void:
	texture = ImageManager.get_random_item_image().get_item_texture()

func get_random_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE.x, SPIN_TIME_RANGE.y)

func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))

# 1.make tween
# 2.scale -> SMALL
# 3.set_random_image
# 4.scale -> BIG
# 5.rotation rand amount, random time
# 6.run_me
func run_me() -> void:
	# 1.
	var tween: Tween = get_tree().create_tween()
	# 2.
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME)
	# 3.
	tween.tween_callback(set_random_image)
	# 4.
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_TIME)
	# 5.
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	# 6.
	tween.tween_callback(run_me)
	
