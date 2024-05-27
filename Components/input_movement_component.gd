class_name IMovementInputs
extends Node

@onready var axis:Vector2 = Vector2.ZERO

@export var MoveInputs: Dictionary = {
	"MoveLeft":"",
	"MoveRight":"",
	"Jump":"",
	"Crouch":""
}
# Return the desired direction of movement for the character
# in the range [-1, 1], where positive values indicate a desire
# to move to the right and negative values to the left.
func get_movement_direction() -> Vector2:
	axis.x = Input.get_axis(MoveInputs.find_key("MoveLeft").to_upper(), MoveInputs.find_key("MoveRight").to_upper())
	return axis.normalized()

# Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return Input.is_action_just_pressed(MoveInputs.find_key("Jump").to_upper())
