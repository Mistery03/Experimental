extends State

@export
var idle_state: State
@export
var move_state: State



func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement = move_component.get_movement_direction() * move_speed * delta
	
	if move_component.get_movement_direction():
		parent.sprite.flip_h = movement < 0
	parent.velocity.x = movement.x
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if move_component.get_movement_direction():
			return move_state
		return idle_state
	return null
