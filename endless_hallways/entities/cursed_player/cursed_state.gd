extends StateMachine


func _ready():
	for s in ["CHASE"]:
		add_state(s)
	
	call_deferred("set_state", states.CHASE)


func _state_logic(delta):
	match state:
		states.CHASE:
			parent.move()


func _enter_state(new_state, old_state):
	pass
