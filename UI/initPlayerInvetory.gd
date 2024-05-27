class_name InitInventory
extends Node

@export var inventoryList:Array[ItemData]
@export var maxInventorySize:int
var playerInventory:Array



func initPlayerInventory():
	for index in range(maxInventorySize):
		playerInventory.append(null)

func storeItem(itemList:Array):
	var itemIndex = 0
	var inventoryList = itemList
	for slot in range(len(playerInventory)):
		if playerInventory[slot] == null:
			playerInventory[slot] = itemList[itemIndex]
			itemIndex += 1
		else:#Add function to check if same item add to stack
			pass

		if itemIndex >= len(itemList):
			break

func insertItem(item:ItemData,index:int=-1):
	pass
		

func getItemIndex(item:ItemData) -> int:
	for slot in range(len(playerInventory)):
		if playerInventory[slot] == item:
			return slot
	return -1
		
		
			
