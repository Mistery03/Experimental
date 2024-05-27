class_name Player
extends Entity

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION:float = 20.0
const STOP_FORCE:float = 15.0
const MAX_SPEED:float = 12000

@onready var animation = $Animation
@onready var sprite = $Sprite
@onready var controller_container = $ControllerContainer


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var controller:PlayerController
var controller
func _ready():
	setController(UserController.new(self))
	#setController(HumanController.new(self))


func _physics_process(delta:float)->void:
	handleMovement(delta)
	move_and_slide()

func handleMovement(delta:float)->void:
	var input = horizontalInput
	if input:
		animation.play("Walk")
	else:
		animation.play("IdleSide")
	
	if input > 0:
		sprite.flip_h = false
	elif input < 0:
		sprite.flip_h = true
		
	velocity.x = input * MAX_SPEED*delta
	
	velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)


func move(value:float)->void:
	horizontalInput = value

func setController(controller)->void:
	for child in controller_container.get_children():
		child.queue_free()
	self.controller = controller
	if controller != null:
		controller_container.add_child(self.controller)
	
"""func setController(controller:PlayerController) -> void:
	for child in controller_container.get_children():
		child.queue_free()
	self.controller = controller
	controller_container.add_child(self.controller)"""
	
