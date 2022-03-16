extends Spatial

export var actorName = "NPC"
export var actorKey = "npc"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play("idle");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	PLAYER_STATE.hasInteraction = true
	if(PLAYER_STATE.isTalking):
		PLAYER_STATE.currentSpeaker.name = actorName
		PLAYER_STATE.currentSpeaker.key = actorKey
	pass # Replace with function body.
