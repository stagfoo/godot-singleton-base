extends Node


func show_dialogue_balloon(title: String, resource: DialogueResource = null) -> void:
	var dialogue = yield(DialogueManager.get_next_dialogue_line(title, resource), "completed")
	if dialogue != null:
		var balloon = preload("res://components/gui/dialog-ballon/example_balloon.tscn").instance()
		balloon.dialogue = dialogue
		get_tree().current_scene.add_child(balloon)
		show_dialogue_balloon(yield(balloon, "actioned"), resource)
	
