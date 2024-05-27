class_name AiController
extends PlayerController

var initTime:int = 0
var commands: Array = []  # Queue to store movement commands
var index = 0

func _ready():
	initTime = Time.get_ticks_msec()
	commands.push_back({"time": 3000, "params": MovementCommand.Params.new(0.0)})
	commands.push_back({"time": 4000, "params": MovementCommand.Params.new(1.0)})
	commands.push_back({"time": 5000, "params": MovementCommand.Params.new(1.0)})
	commands.push_back({"time": 6000, "params": MovementCommand.Params.new(0.0)})

func _physics_process(delta):
	var currentTime = Time.get_ticks_msec() - initTime
	var commandExecuted = false
	
	for i in range(commands.size()):
		if currentTime < commands[i]["time"]:
			movementCommand.execute(player, commands[i]["params"])
			commandExecuted = true 
			break  # Exit the loop after executing the appropriate command

	if not commandExecuted:
		print("player mode")
		player.setController(HumanController.new(player))
		

