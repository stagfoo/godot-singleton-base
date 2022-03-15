extends KinematicBody

# uses code from Jayanam
# https://www.youtube.com/watch?v=kc-zJnRvPUY

var facing_direction = Vector3(0,0,0)
var velocity = Vector3()
var gravity = -35
var camera
onready var player = get_node('.')
onready var player_animation = get_node("character/player-mesh/AnimationPlayer")
onready var effects_sound = {
	"run": get_node("character/run"),
	"jump": get_node("character/jump"),
	"death": get_node("character/death"),
	"attack": get_node("character/attack")
}
onready var effect_run = get_node("character/effect-run")
onready var traction = get_node("Traction")
export var SPEED = 14
export var ACCELERATION = 20
export var DECELERATION = 10
export var JUMP_HEIGHT = 15
var lifecycle = 0
export var is_moving = false
export var is_attacking = false
export var can_jump = false

var animationPlayer


func _ready():
	pass
func _physics_process(delta):
	PLAYER_STATE.lifecycle = lifecycle
	
	camera = get_node("target/Camera").get_global_transform()
	get_node("target/Camera").player = self
	
	loop_controls()
	
	#jump logic
	facing_direction.y = 0
	facing_direction = facing_direction.normalized()
	velocity.y += delta * gravity
	gravity = lerp(gravity, -35, 0.1)
	
	# horizontal velocity
	var hv = velocity
	hv.y = 0
	
	var new_pos = facing_direction * lerp(0, SPEED, 1)
	var accel = DECELERATION
	
	if facing_direction.dot(hv) > 0:
		accel = ACCELERATION
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x 
	velocity.z = hv.z
	
	if(is_moving && is_on_floor()):
		character_run()
	if(!is_moving && can_jump):
		character_idle()
	# move charater
	if traction.is_colliding():
		velocity = move_and_slide_with_snap(velocity, traction.get_collision_normal(), Vector3(0,1,0), false, 4, 1)
		gravity = -35
	else:
		
		velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	#camera return
	if is_moving && !Input.is_key_pressed(KEY_SHIFT):
		var angle = atan2(hv.x, hv.z)
		var char_rot = get_rotation()
		char_rot.y = angle
		set_rotation(char_rot)
	# jump
	if is_on_floor():
			can_jump = true
			gravity = -35
			SPEED = 14
			return
	else:
		character_jump()
		can_jump = false
	if is_on_wall():
		can_jump = false
		return
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("Collided with: ", collision.collider.name)
	return



func loop_controls():
	facing_direction = Vector3(0,0,0)
	is_moving = false
	if(Input.is_action_pressed("ui_up")):
		facing_direction += -camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("ui_down")):
		facing_direction += camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("ui_left")):
		facing_direction += -camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("ui_right")):
		facing_direction += camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("jump") && can_jump):
		player_animation.play("jump")
		velocity.y = JUMP_HEIGHT
	if(Input.is_action_pressed("ui_accept") && can_jump):
		character_attack()

func _on_Coin_body_entered(body):
	var name = body.get_name()
	print("from player")
	print(name)
	if(name == 'player'):
		
		return
	pass # Replace with function body.

func stop_all_sounds():
	for sound in effects_sound:
		effects_sound[sound].stop()

func character_run():
	if(player_animation.current_animation != "run"):
		player_animation.play('run')
		effect_run.emitting = true
	if(!effects_sound.run.playing):
		effects_sound.run.play()
	if(effects_sound.jump.playing):
		effects_sound.run.stop()
func character_idle():
	if(!effects_sound.attack.playing):
		stop_all_sounds()
	if(player_animation.current_animation != "attack"):
		player_animation.play("idle")
	effect_run.emitting = false		
func character_jump():
	effects_sound.run.stop()
	if(!effects_sound.jump.playing && can_jump):
		effects_sound.jump.play()
	player_animation.play("jump")
	player_animation.seek(0.5)
	effect_run.emitting = false
func character_attack():
	player_animation.play("attack")
	effects_sound.attack.play()
	pass
