class_name TestEnum

enum PlayerState {
	IDLE,
	WALK,
	JUMP,
	ATTACK
}

var _state: PlayerState = PlayerState.IDLE

func changeState(state: PlayerState) -> void:
	_state = state
	match state:
		PlayerState.IDLE:
			print("Player is idle")
		PlayerState.WALK:
			print("Player is walk")
		_:
			print("Player is not known state")
