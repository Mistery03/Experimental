class_name UserController
extends Node

var movementCommand:MoveEntityCommand 
var player:Player
func _init(player:Player)->void:
	self.player = player
	movementCommand = MoveEntityCommand.new()
	
func _ready():
	movementCommand.moveEntityCommand(player)

func _physics_process(delta)->void:
	var movementInput = Input.get_action_strength("MOVERIGHT") - Input.get_action_strength("MOVELEFT")
	movementCommand.execute(movementInput)
