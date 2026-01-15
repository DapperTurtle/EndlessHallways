extends StateMachine


func _ready():
	for s in ["IDLE", "RUN", "JUMP", "FALL"]: add_state(s)
	
	call_deferred("set_state", states.IDLE)


func _state_logic(delta):
	match state:
		states.IDLE, states.RUN: 
			parent.move()
			
		states.JUMP, states.FALL: 
			parent.move()
			parent.apply_gravity(delta)
			parent.jump_sustain()


func _get_transition(delta):
	match state:
		states.IDLE, states.RUN:
			if parent.velocity.x == 0 and state == states.RUN: 
				state = states.IDLE
				
			if parent.velocity.x != 0 and state == states.IDLE: 
				state = states.RUN
				
			if Input.is_action_just_pressed("jump"): 
				state = states.JUMP
				
			if parent.jump_pressed == true: 
				state = states.JUMP
				
			if not parent.is_on_floor(): 
				state = states.FALL
			
		states.JUMP: 
			if parent.velocity.y > 0: state = states.FALL
			
		states.FALL: 
			if parent.is_on_floor(): state = states.IDLE
			
			if Input.is_action_just_pressed("jump"):
				parent.jump_pressed = true
				parent.jump_buffered = true
				parent.jump_buffer()
				
				if parent.can_jump == true: 
					state = states.JUMP


func _enter_state(new_state, old_state):
	match state:
		states.IDLE:
			parent.animation.play("idle")
			if Global.cursed == true:
				parent.spawn_curse()
			
		states.RUN: 
			parent.animation.play("run")
			
		states.JUMP: 
			parent.animation.play("jump"); parent.jump()
			
		states.FALL: 
			parent.animation.play("fall")
