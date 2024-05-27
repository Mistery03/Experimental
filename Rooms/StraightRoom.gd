class_name StraightRoom
extends RoomBase

@onready var door_up = $DoorUp
@onready var door_down = $DoorDown

func _ready():
	randomize()
	if randi_range(0,1) == 1:
		ID |= ROTATECLOCKWISE
	check_rotation_bit(ID)
	
	"""if door_up.ID > 0:
		var test = cornerUpRoom.instantiate()
		test.position = Vector2(0,-16)
		test.scale = Vector2(1,1)
		add_child(test)
	if door_down.ID > 0:
		var test = cornerUpRoom.instantiate()
		test.flipVerticalBit()
		if randi_range(0,1) == 1:
			test.flipHorizontalBit()
		test.position = Vector2(0,16)
		test.scale = Vector2(1,1)
		add_child(test)"""
# Called when the node enters the scene tree for the first time.

# Function to check the first three bits from the right
func check_rotation_bit(number: int):
	# Extract the first three bits (starting from right)
	var bit = (number >> 2) & 1

	if bit == 1:
		rotate(1.5708)
	
