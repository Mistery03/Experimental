extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State

func process_input(event: InputEvent) -> State:
	if move_component.wants_jump() and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:	
	if !move_component.get_movement_direction():
		return idle_state
		
	parent.velocity.x = move_component.get_movement_direction().x * move_speed * delta
	parent.sprite.flip_h = move_component.axis.x < 0
	parent.velocity.x =  clamp(parent.velocity.x,-move_speed,move_speed)
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
