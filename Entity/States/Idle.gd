extends State

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State

var lerp_timer: Timer



func enter() -> void:
	super()
	lerp_to_zero()
	await parent.get_tree().create_timer(0.2).timeout
	parent.velocity.x = 0.0
	
func lerp_to_zero():
	# Gradually lerp the velocity to 0
	parent.velocity.x = lerp(parent.velocity.x, 0.0, 0.2)

# Check if the velocity is close enough to 0
	if abs(parent.velocity.x) < 0.01:
		parent.velocity.x = 0.0

func process_input(event: InputEvent) -> State:
	move_component.axis = move_component.get_movement_direction()
	if Input.is_action_just_pressed(move_component.MoveInputs.find_key("Jump").to_upper()) and parent.is_on_floor():
		return jump_state
	if move_component.axis:
		return move_state

	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
