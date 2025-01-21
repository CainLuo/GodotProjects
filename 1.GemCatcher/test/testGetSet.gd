class_name TestGetSet

var _health: int = 100

### --------- 这是下标 get/set 方法 ---------
var height: int = 160:
	get:
		print("💥💥💥 Getting")
		return height
	set(value):
		print("💥💥💥 Setting")
		height = clamp(value, 0, 200)

func _init(h: int) -> void:
	_health = h

### --------- 这是手动 get/set 方法 ---------
func get_health() -> int:
	return _health

# clamp 方法可以限制数值在 min、max 之间
# 示例中 min: 0, max: 100
func set_health(value: int) -> void:
	_health = clamp(value, 0, 100)
