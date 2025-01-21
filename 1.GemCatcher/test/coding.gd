extends Node2D

class_name Coding

var _scroe: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hello")
	var health: int = 100
	
	if health == 0:
		print("dead")
	
	var height = 15.6
	height += 0.1
	print(height)
	print("这是类型", typeof(height))
	print("这是类型", type_string(typeof(height)))

	objcTest()
	intTest()
	stringTest()
	classTest()
	enumTest()
	testGetSet()
	testGetSet()

func objcTest() -> void:
	var world = "world"
	var obj = Vector3(1, 2, 3)

	# 使用 str() 显式转换对象为字符串
	print(world + str(obj))

func intTest() -> void:
	_scroe += 1
	print("The scroe is: ", _scroe)

func stringTest() -> void:
	var lives: int = 10
	var level_name: String = "Rockey"
	var speed: float = 3.1415926
	
	var s: String = "l %d n %s %f" % [lives, level_name, speed]
	print(s)

func classTest() -> void:
	var np1: TestPlayer = TestPlayer.new("Bob", 90)
	np1.say_status()
	print(TestPlayer.player_count)
	
	var np2: TestPlayer = TestPlayer.new("Ka", 89)
	np2.say_status()
	print(TestPlayer.player_count)
	
	TestPlayer.say_how_many()

func enumTest() -> void:
	var eTest = TestEnum.new()
	eTest.changeState(TestEnum.PlayerState.WALK)

# 不要直接给类里面的属性赋值，最好是声明一个 get、set 方法获取或者设置数值
func testGetSet() -> void:
	var test = TestGetSet.new(100)
	print("The health is %d" % test.get_health())
	
	test.set_health(500)
	print("The health is %d" % test.get_health())
	
	test.height = 170
	print("\nThe height is %d" % test.height)
