class_name CornerUpRoom
extends RoomBase

@onready var sprite_2d = $Sprite2D

func _ready():
	check_flipV_bit(ID)
	check_flipH_bit(ID)
	


func flipHorizontalBit():
	ID = convertIDDecimalToBinary(ID)
	ID |= 10
	print(ID)

func flipVerticalBit():
	ID = convertIDDecimalToBinary(ID)
	ID |= 1
	print(ID)

func check_flipV_bit(number: int):
	# Extract the first three bits (starting from right)
	var bit = (number >> 0) & 1

	if bit == 1:
		sprite_2d.flip_v = true

func check_flipH_bit(number: int):
	# Extract the first three bits (starting from right)
	var bit = (number >> 1) & 1

	if bit == 1:
		sprite_2d.flip_h = true
