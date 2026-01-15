extends StateMachine


func _ready():
	for s in ["CHASE", "STUN"]:
		add_state(s)
	
	Global.connect("key_collect", key_collect)
	Global.connect("door_unlock", door_unlock)
	
	call_deferred("set_state", states.CHASE)


func _state_logic(delta):
	match state:
		states.CHASE:
			parent.move()
		states.STUN:
			parent.stop()


func _enter_state(new_state, old_state):
	pass


func key_collect():
	state = states.STUN


func door_unlock():
	state = states.CHASE
