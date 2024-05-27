class_name HumanController
extends PlayerController


func _physics_process(delta)->void:
	var movementInput = Input.get_action_strength("MOVERIGHT") - Input.get_action_strength("MOVELEFT")
	movementCommand.execute(player,MovementCommand.Params.new(movementInput))
