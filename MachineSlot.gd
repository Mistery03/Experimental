extends Panel

@export var player_inventory:Control
@onready var label = $Label
@onready var texture_rect = $Border/TextureRect
@export var item:ItemData = null
@export var amount:int = 1
var drag_offset: Vector2
var original_position: Vector2  
var original_label_position: Vector2
var isDragging:bool =false
@onready var machine = $".."
var mouse_pressed = false
@onready var border = $Border

signal dropped(dropped_item)
signal droppedOnExistingItem(dropped_item)


# Called when the node enters the scene tree for the first time.
func _ready():
	#original_position = border.global_position
	#original_label_position = border.global_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(item)
	if item:
		texture_rect.texture = item.texture
		texture_rect.visible = true
		label.visible = true
		label.text = str(amount)

		
	else:
		texture_rect.visible = false
		label.visible = false
		
	if !machine.isDragging:
		texture_rect.global_position =  border.global_position + Vector2(10,10)
		label.global_position = border.global_position + Vector2(75,75)

		

	
func handle_item_drop():
	if player_inventory:
		if player_inventory.isDragging:
			emit_signal("droppedOnExistingItem",player_inventory.currSlot.item)
			

func handle_drop():		
	if player_inventory:
		if player_inventory.isDragging:
			emit_signal("dropped",player_inventory.currSlot)
		


func _on_border_mouse_entered():
	if mouse_pressed:
		print('Mouse Entered')
		if item:
			handle_item_drop()
		else:
			handle_drop()


func _on_border_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				machine.isDragging = true
				drag_offset = get_global_mouse_position() - get_global_position()
				texture_rect.set_z_index(100)
				machine.currItemFromMachine = self
			else:
				machine.isDragging = false
				texture_rect.set_z_index(1)
				#machine.currItemFromMachine = null

					
	elif event is InputEventMouseMotion and machine.isDragging:
		texture_rect.set_global_position(get_global_mouse_position() - drag_offset + Vector2(65,65))
		label.set_global_position(get_global_mouse_position() - drag_offset + Vector2(75,70))

func reset_dragging_state():
	mouse_pressed = false
	isDragging = false
	machine.currItemFromMachine = null
	texture_rect.set_z_index(1)


func _on_dropped(dropped_slot):
	if item ==  null:
		item = dropped_slot.item
		amount = dropped_slot.amount
		machine.isDragging = false
		texture_rect.global_position =  border.global_position + Vector2(10,10)
		label.global_position = border.global_position + Vector2(75,70)
		player_inventory.isDragging = false
		player_inventory.currSlot = null
		player_inventory.removeAll(item)
	
	
		


func _on_dropped_on_existing_item(dropped_item) -> void:
	if amount >= 99:
		return	
	
	if item == dropped_item:
		amount += player_inventory.currSlot.amount
		amount = clamp(amount,1,99)
		player_inventory.currSlot = null
		player_inventory.isDragging = false
		player_inventory.removeAll(item)


func getSlotPosition()->Vector2i:
	var gridSlotPos:Vector2i
	gridSlotPos = Vector2i(position/custom_minimum_size)
	return gridSlotPos
