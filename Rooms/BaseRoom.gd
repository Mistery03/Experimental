class_name RoomBase
extends Node2D

@export var ID:int = 0

const FLIPVERTICAL = 0b001
const FLIPHORIZONTAL = 0b010
const ROTATECLOCKWISE = 0b100

var specialRule:Array = [FLIPVERTICAL,FLIPHORIZONTAL,ROTATECLOCKWISE]

@export var straightRoom:PackedScene
@export var cornerUpRoom:PackedScene
@export var threeJuncRoom:PackedScene
@export var fourJuncRoom:PackedScene
@export var deadEndRoom:PackedScene

func convertIDDecimalToBinary(IDDecimal:int) -> int:
	if IDDecimal == 0:
		return 0
	var binary_int = 0
	var place = 1
	var n = IDDecimal
	while n > 0:
		binary_int += (n % 2) * place
		n = n / 2
		place *= 10
	return binary_int

# Function to convert a binary string to a decimal number
func convertIDBinaryToDecimal(IDBinary:int) -> int:
	var decimal = 0
	var dec = 0
	var i = 0
	while(IDBinary != 0):
		dec = IDBinary % 10
		decimal = decimal + dec * pow(2, i)
		IDBinary = IDBinary/10
		i += 1
	return decimal

func _ready():
	pass
	"""randomize()
	var IDBinary = convertIDDecimalToBinary(ID)
	print(IDBinary)
	var sRule = specialRule.pick_random()
	print(sRule)
	IDBinary |= sRule
	print(IDBinary)
	print(convertIDBinaryToDecimal(IDBinary))"""
