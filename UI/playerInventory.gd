
extends Control

@export var maxInventorySize:int
@export var inventorySlot:PackedScene
@export var inventoryList:Array[ItemData]
@export var parentMachine:Control
@onready var grid_container = $GridContainer

@export var testItem:ItemData

var itemList:Array = []
var slotList:Array = []
var gridList:Array = []
var debugList:Array = []

var itemIndex = 0

var currSlot:Panel
var tempCurrSlot:Panel
var isDragging:bool = false
var slotSize:Vector2
var isSwapped:bool =  false

var gridMousePos:Vector2i

func _ready():
	for child in grid_container.get_children():
		child.queue_free()
		
	for index in range(maxInventorySize):
		var slot = inventorySlot.instantiate()
		grid_container.add_child(slot)
		slot.item = null
		slot.playerInventory = self
		slot.connect("dropped",on_item_dropped)
		slotList.append(slot)
		slotSize = slot.custom_minimum_size
	
	for item in inventoryList:
		if itemList.size() < maxInventorySize:
			item.amount = 1
			itemList.push_back(item)
			update_slots()
	

func _process(delta):
	#@NOTE This is for debug purposes
	#showDebugList()
	if !isDragging:
		gridMousePos = Vector2i(get_global_mouse_position()/115)
		if gridMousePos in getSlotPositions():
			tempCurrSlot= currSlot
			
		else:
			if currSlot:
				currSlot.texture_rect.global_position = currSlot.original_position
				currSlot.label.global_position = currSlot.original_label_position
			isDragging = false
			currSlot = null
			tempCurrSlot= null
	
			
	if tempCurrSlot and !isSwapped:
		if addStack(tempCurrSlot.item,tempCurrSlot.amount,gridMousePos):
			tempCurrSlot.item = null
			tempCurrSlot = null
			pass
	pass
	

##NOTE there a slight bug or can be a feature where items added resort themselves how they originally added 
func insert(item:ItemData)->void:
	for slot in slotList:
		if slot.amount < 99:
			if slot.item == item:
				slot.amount += 1
				update_slots()
			else:
				if itemList.size() < maxInventorySize:
					item.amount = 1
					itemList.push_back(item)
					update_slots()
			return
			
	"""if itemList.size() < maxInventorySize:
		item.amount = 1
		itemList.push_back(item)
		update_slots()
		for slot in slotList:
			if slot.item == item:
				slot.amount = 1
				
				var slotGridPos = Vector2i(slot.position/slotSize)
				slot.texture_rect.position = slotGridPos + Vector2i(2,2)
				slot.label.position = slotGridPos + Vector2i(75,75)
	else:
		print("Inventory is full")"""

func insertAll(item:ItemData, currAmount:int):
	if itemList.size() < maxInventorySize:
		item.amount = 1
		itemList.push_back(item)
		update_slots()
		for slot in slotList:
			if slot.item == item:
				slot.amount = currAmount
				
				var slotGridPos = Vector2i(slot.position/slotSize)
				slot.texture_rect.position = slotGridPos + Vector2i(2,2)
				slot.label.position = slotGridPos + Vector2i(75,75)
	else:
		print("Inventory is full")
		
func insertItem(item:ItemData,currAmount,droppedPosition:Vector2i) -> bool:
	for slot in slotList:
		var GridSlotPos = Vector2i(slot.position/slotSize)
		if GridSlotPos == droppedPosition:
			if slot.item == null:
				slot.item = item
				slot.amount = currAmount
				slot.texture_rect.position = GridSlotPos + Vector2i(2,2)
				slot.label.position = GridSlotPos+ Vector2i(75,75)
				itemList.append(slot.item)
				return true
	return false
				

func addStack(item:ItemData,currAmount,droppedPosition:Vector2i) -> bool:
	for slot in slotList:
		var GridSlotPos = Vector2i(slot.position/slotSize)
		if GridSlotPos == droppedPosition:
			if slot.item == item:
				if slot.amount < 99:
					slot.amount += currAmount
					return true
	return false
		
func remove(item:ItemData):
	for slot in slotList:
		if slot.item == item:
			if slot.amount <= 1:
				itemList.erase(item)
				slot.amount =0
				update_slots()
			else:
				slot.amount -= 1
				print(item.amount)
		#else:
			#print("Item not in inventory")
	
	#print(slotList)
	#print(itemList)


"""NOTE Not to be confused with remove where it only remove one item at a time
"""

func removeItem(item:ItemData,currAmount,droppedPosition:Vector2i) -> bool:
	for slot in slotList:
		var GridSlotPos = Vector2i(slot.position/slotSize)
		if slot.item == item:
			slot.item = null
			itemList.erase(item)
			return true
	return false

func removeAll(item:ItemData):
	if item in itemList:
		itemList.erase(item)
		update_slots()
	else:
		print("Item not in inventory")
	
func update_slots():
	for i in range(maxInventorySize):
		if i < len(itemList):
			var GridSlotPos = Vector2i(slotList[i].position/slotSize)
			slotList[i].item = itemList[i]
			slotList[i].texture_rect.position = GridSlotPos + Vector2i(2,2)
			slotList[i].label.position = GridSlotPos + Vector2i(75,75)
		else:
			slotList[i].item = null
		
		
##NOTE This does not remove item from inventoy			
func on_item_dropped(dropped_slot,dropped_item, amount, itemPos):
	for slot in slotList:
		var GridSlotPos = Vector2i(slot.position/slotSize)
		if GridSlotPos == itemPos:
			if slot.item == null:
				for s in slotList:
					if s.item == dropped_item:
						s.item = null
						slot.item = dropped_item
						slot.amount = amount
						slot.texture_rect.position = GridSlotPos + Vector2i(2,2)
						slot.label.position = GridSlotPos + Vector2i(75,75)
						break
			else:
				if slot.item !=  dropped_item:
					isSwapped = swapSlotsWithinInventory(slot.item,dropped_item)
				else:
					isSwapped = false
	
func swapSlotsWithinInventory(oldItem:ItemData, newItem:ItemData) ->bool:
	var index1 = getItemIndex(oldItem)
	var index2 = getItemIndex(newItem)
	
	var temp_item = slotList[index1].item
	var temp_amount = slotList[index1].amount
	
	slotList[index1].item = slotList[index2].item
	slotList[index1].amount = slotList[index2].amount
	slotList[index2].item = temp_item
	slotList[index2].amount = temp_amount
	
	return true
	
	#update_slots()		

func swapSlotsOutsideInventory(oldItem:ItemData, newItem:ItemData):
	var index1 = getItemIndex(oldItem)
	var index2 = getItemIndex(newItem)
	
	var temp_item = slotList[index1].item
	var temp_amount = slotList[index1].amount
	
	slotList[index1].item = newItem.item
	slotList[index1].amount = newItem.amount
	#slotList[index2].item = temp_item
	#slotList[index2].amount = temp_amount
	
	#update_slots()		

func getItemIndex(item:ItemData) -> int:
	for slot in range(maxInventorySize):
		if slotList[slot].item == item:
			return slot
	return -1

func getSlotPositions()->Array[Vector2i]:
	var gridSlotPos:Vector2i
	var gridSlotPosList:Array[Vector2i]
	gridSlotPosList.clear()
	for slot in slotList:
		gridSlotPos = Vector2i(slot.position/slotSize)
		gridSlotPosList.append(gridSlotPos)
	return gridSlotPosList

func showDebugList():
	debugList.clear()
	for i in range(maxInventorySize):
		debugList.append(slotList[i].item)
	print(debugList)
