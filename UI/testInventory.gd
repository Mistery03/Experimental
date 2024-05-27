extends Control

@export var item:ItemData
@export var item2:ItemData
@onready var player_inventory = $PlayerInventory
@onready var machine_slot = $MachineSlot

var isDragging:bool = false
var currItemFromMachine:Panel
var tempCurrItem:Panel
var gridMousePos

var mouse_pressed:bool

func _process(delta):
	if !isDragging:
		gridMousePos = Vector2i(get_global_mouse_position()/115)
		if gridMousePos in player_inventory.getSlotPositions():
			tempCurrItem = currItemFromMachine
		else:
			currItemFromMachine = null
			tempCurrItem = null
		
		if gridMousePos == machine_slot.getSlotPosition():
				if machine_slot.item ==  null:
					machine_slot.item = player_inventory.currSlot.item
					machine_slot.amount = player_inventory.currSlot.amount
					machine_slot.machine.isDragging = false
					machine_slot.texture_rect.global_position = machine_slot. border.global_position + Vector2(10,10)
					machine_slot.label.global_position =machine_slot. border.global_position + Vector2(75,70)
					player_inventory.isDragging = false
					player_inventory.currSlot = null
					player_inventory.removeItem(machine_slot.item,machine_slot.amount,gridMousePos)

	
	if tempCurrItem:
		if player_inventory.insertItem(tempCurrItem.item,tempCurrItem.amount,gridMousePos):
			currItemFromMachine.item = null
			currItemFromMachine = null
				
			
		if player_inventory.addStack(tempCurrItem.item,tempCurrItem.amount,gridMousePos):
			currItemFromMachine.item = null
			currItemFromMachine = null
		
		
		pass	
		#machine_slot.texture_rect.position =  Vector2i(machine_slot.original_position/machine_slot.custom_minimum_size) - Vector2i(5,5)
		##machine_slot.label.position = Vector2i(machine_slot.original_label_position/machine_slot.custom_minimum_size) + Vector2i(75,70)

func _input(event):
	if event is InputEventKey:
		if event.is_action("MOVERIGHT"):
			player_inventory.insert(item)
		if event.is_action_pressed("MOVELEFT"):
			player_inventory.remove(item)
		
		if event.is_action_pressed("ui_right"):
			player_inventory.insert(item2)
		if event.is_action_pressed("ui_left"):
			player_inventory.remove(item2)
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_pressed = true
		else:
			mouse_pressed = false
	


	
	



