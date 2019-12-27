extends ItemList

onready var BUTTONS = {
	"START": get_node('Start'),
}

func _on_Button_pressed():
	print(get_node('Start'))
	if(BUTTONS.START.pressed):
		print('Pressed')
		UTILS.goto_scene(SCENES.LEVEL_1.FILE)
		return
	pass
