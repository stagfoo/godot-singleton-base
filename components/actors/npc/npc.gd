extends Spatial

export var actorName = "NPC"
export var actorKey = "npc"
onready var resource = preload("res://assets/dialog/npc.tres")
var playerInRange = false;
var isTalking = false;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play("idle");

	pass # Replace with function body.

func _physics_process(delta):
	if(Input.is_action_just_released("ui_accept") && playerInRange):
		DIALOG.show_dialogue_balloon('NPC', resource)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_Area_body_entered(body):
	playerInRange = true
	pass # Replace with function body.


func _on_Area_body_exited(body):
	playerInRange = false
	pass # Replace with function body.
