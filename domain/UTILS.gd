extends Node


func _ready():
	set_process(true)
	var root = get_tree().get_root()
	STORE.CURRENT_SCENE = get_parent().get_node("Menu")
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		UTILS.goto_scene(SCENES.MAIN_MENU.FILE)
	
func goto_scene(path):
	_deferred_goto_scene(path)
	


func _deferred_goto_scene(path):
	STORE.CURRENT_SCENE.free()
	var s = ResourceLoader.load(path)
	STORE.CURRENT_SCENE = s.instance()
	get_tree().get_root().add_child(STORE.CURRENT_SCENE)
	get_tree().set_current_scene(STORE.CURRENT_SCENE)