class_name RoomGeneration
extends TreeGeneration

const FLIPVERTICAL = 0b001
const FLIPHORIZONTAL = 0b011
const ROTATECLOCKWISE = 0b111

@export var straightRoom:PackedScene
@export var cornerUpRoom:PackedScene
@export var threeJuncRoom:PackedScene
@export var fourJuncRoom:PackedScene
@export var deadEndRoom:PackedScene

@onready var room_holder = $RoomHolder

var mapSize:Vector2 = Vector2(100,100)

var posList:Array[Vector2] = []

# Function to check the first three bits from the right
func check_first_three_bits(number: int) -> Array:
	# Extract the first three bits (starting from right)
	var first_bit = (number >> 0) & 1
	var second_bit = (number >> 1) & 1
	var third_bit = (number >> 2) & 1

	return [first_bit, second_bit, third_bit]

func _ready():
	randomize()
	create_spanning_tree(maxNodes)
	#print_adjacency_list()
	var degreeList = getAdjacencyDegreeList()
	
	print(getFirstNode())
	print(getAdjacencyDegree(getFirstNode()))
	var degreeSize = getAdjacencyDegree(getFirstNode())
	
	match degreeSize:
		1:
			var test = deadEndRoom.instantiate()
			test.position = Vector2.ZERO
			room_holder.add_child(test)
		2:
			var test = straightRoom.instantiate()
			test.position = Vector2.ZERO
			room_holder.add_child(test)
		3:
			var test = threeJuncRoom.instantiate()
			test.position =  Vector2.ZERO
			room_holder.add_child(test)
		4:
			var test = fourJuncRoom.instantiate()
			test.position = Vector2.ZERO
			room_holder.add_child(test)
			
	"""for node in degreeList.keys():
		if degreeList.get(node)[0] == 1:
			var test = deadEndRoom.instantiate()
			test.position = Vector2(randf_range(0,5),randf_range(0,5))
			room_holder.add_child(test)
		elif degreeList.get(node)[0] == 2:
			var test = straightRoom.instantiate()
			test.position = Vector2(randf_range(100,105),randf_range(100,105))
			room_holder.add_child(test)
		elif degreeList.get(node)[0] == 3:
			var test = threeJuncRoom.instantiate()
			test.position = Vector2(randf_range(200,205),randf_range(200,205))
			room_holder.add_child(test)
		elif degreeList.get(node)[0] == 4:
			var test = fourJuncRoom.instantiate()
			test.position = Vector2(randf_range(300,305),randf_range(300,305))
			room_holder.add_child(test)"""
			
	

	#var example_number = 10 # Binary representation of 65
	#var bits = check_first_three_bits(example_number)

	#print("First three bits from the right: ", bits)
	# Output will be [1, 0, 0] for the number 65 (0b1000001)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
