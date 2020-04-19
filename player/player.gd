extends KinematicBody

# uses code from Jayanam
# https://www.youtube.com/watch?v=kc-zJnRvPUY

var facing_direction = Vector3(0,0,0)
var velocity = Vector3()
var gravity = -35
var camera
var character
var ground
var traction
var SPEED = 14
var ACCELERATION = 20
const DECELERATION = 10
var JUMP_HEIGHT = 15
var lifecycle = 0
var is_moving = false
var can_jump = false

var animationPlayer


func _ready():
	character = get_node(".")
	
	
	traction = get_node("Traction")
	
func _physics_process(delta):
	PlayerVars.lifecycle = lifecycle
	
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
			velocity.y = JUMP_HEIGHT

func _on_Coin_body_entered(body):
	var name = body.get_name()
	print("from player")
	print(name)
	if(name == 'player'):
		
		return
	pass # Replace with function body.
