extends Node


func _ready():
	var root = get_tree().get_root()
	STORE.CURRENT_SCENE = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	_deferred_goto_scene(path)
	print(STORE.CURRENT_SCENE.get_name())
	get_node("/root/MENU").free()


func _deferred_goto_scene(path):
	STORE.CURRENT_SCENE.free()
	var s = ResourceLoader.load(path)
	STORE.CURRENT_SCENE = s.instance()
	get_tree().get_root().add_child(STORE.CURRENT_SCENE)
	get_tree().set_current_scene(STORE.CURRENT_SCENE)