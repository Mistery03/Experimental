extends Node2D

@export var isStartingRoom:bool
@export var roomID:int

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if !isStartingRoom:
		roomID  = randi_range(128,129)
	

	for room in get_children():
		if room.ID != roomID:
			room.queue_free()
		



