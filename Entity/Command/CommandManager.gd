class_name CommandManager
extends Node


var commands:Array
var parent:Entity

var initTime:int = 0
func init(parent:Entity):
	self.parent = parent
	commands = get_children()
	for child in commands:
		child.parent = parent	
	initTime = Time.get_ticks_msec()
	
#Note to Rinka, the duration must be an increment after each commands, for example command1 have duration 2000 then the next should 3000 or more	
#Duration is milisecs
func _physics_process(delta):
	var currentTime = Time.get_ticks_msec() - initTime
	var commandExecuted = false	
	if parent != null:
		for i in range(commands.size()):
			if currentTime < commands[i].duration:
				commands[i].execute()
				commandExecuted = true
				break
		if not commandExecuted:
			print("player mode")
			parent.setController(UserController.new(parent))
			parent = null
		
	

		

		



