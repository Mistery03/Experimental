# jump.gd
extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State

@export
var jump_force: float = 700.0


func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state
	
	parent.velocity.x = move_component.get_movement_direction().x * move_speed * delta
	
	if move_component.get_movement_direction():
		parent.sprite.flip_h = move_component.axis.x < 0
	parent.velocity.x = clamp(parent.velocity.x,-move_speed,move_speed)
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if  move_component.get_movement_direction():
			return move_state
		return idle_state
	
	return null
