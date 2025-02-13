extends RigidBody2D

enum ANIMA_STATE { READY, DRAG, RELEASE }

const DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)
const IMOLUSE_MULT: float = 20.0
const IMOLUSE_MAX: float = 1200.0

@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound

var _state: ANIMA_STATE = ANIMA_STATE.READY

var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _last_dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0

func _ready() -> void:
	_arrow_scale_x = arrow.scale.x
	arrow.hide()
	_start = position

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	update(delta)
	var content = "%s\n" % ANIMA_STATE.keys()[_state] + "%.1f,%.1f" % [_dragged_vector.x, _dragged_vector.y]
	label.text = content

func get_impulse() -> Vector2:
	return _dragged_vector * -1 * IMOLUSE_MULT

func set_drag_state() -> void:
	_drag_start = get_global_mouse_position()
	arrow.show()

func set_release_state() -> void:
	arrow.hide()
	freeze = false
	apply_central_impulse(get_impulse())
	launch_sound.play()

func set_new_state(new_state: ANIMA_STATE) -> void:
	_state = new_state
	if _state == ANIMA_STATE.RELEASE:
		set_release_state()
	elif _state == ANIMA_STATE.DRAG:
		set_drag_state()

func detect_release() -> bool:
	if _state == ANIMA_STATE.DRAG:
		if Input.is_action_just_released("drag"):
			set_new_state(ANIMA_STATE.RELEASE)
			return true
	return false

func scale_arrow() -> void:
	var imp_len = get_impulse().length()
	var perc = imp_len / IMOLUSE_MAX
	
	arrow.scale.x = (_arrow_scale_x * perc) + _arrow_scale_x
	
	arrow.rotation = (_start - position).angle()

func play_stretch_sound() -> void:
	if(_last_dragged_vector - _dragged_vector).length() > 0:
		if !stretch_sound.playing:
			stretch_sound.play()

func get_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - _drag_start

func drag_in_limits() -> void:
	
	_last_dragged_vector = _dragged_vector
	
	_dragged_vector.x = clampf(
		_dragged_vector.x,
		DRAG_LIM_MIN.x,
		DRAG_LIM_MAX.x
	)
	_dragged_vector.y = clampf(
		_dragged_vector.y,
		DRAG_LIM_MIN.y,
		DRAG_LIM_MAX.y
	)
	position = _start + _dragged_vector

func update_drag() -> void:
	if detect_release():
		return

	var gmp = get_global_mouse_position()
	_dragged_vector = get_dragged_vector(gmp)
	play_stretch_sound()
	drag_in_limits()
	scale_arrow()

func update(delta: float) -> void:
	match _state:
		ANIMA_STATE.DRAG:
			update_drag()

func die() -> void:
	SignalManager.on_animal_die.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _state == ANIMA_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANIMA_STATE.DRAG)
