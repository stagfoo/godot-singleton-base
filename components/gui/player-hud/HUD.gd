extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
#	if(get_node("coins").text != str(PlayerVars.points)):
#		get_node("coinSound").play()
#		pass
	get_node("coins").text = str(PLAYER_STATE.points)
	
	if PLAYER_STATE.isTalking:
		get_node("dialog-box").visible = true
		get_node("dialog-box").speakerName = PLAYER_STATE.currentSpeaker.name
		get_node("dialog-box").bodyText = DIALOG.CHARACTER_RESPONSE[PLAYER_STATE.currentSpeaker.key]
	else: 
		get_node("dialog-box").visible = false
	pass
