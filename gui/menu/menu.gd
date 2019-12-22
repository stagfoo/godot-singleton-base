extends ItemList

onready var BUTTONS = {
	"START": get_node('Start Game'),
	"END": get_node('End Game'),
}

func _on_Button_pressed():
	if(BUTTONS.START.pressed):
		UTILS.goto_scene(LEVELS.LEVEL_1.FILE)
		return
	if(BUTTONS.END.pressed):
		get_tree().quit()
		return
	pass
