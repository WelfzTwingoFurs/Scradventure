extends KinematicBody2D
## 480x360 ##
var WX = 480
var WY = 360

var SX = 1
var SY = 1

var motion = Vector2()
var movespeed = 200

enum STATES {IDLE,ATTACK}
export(int) var state = STATES.IDLE

var direction

func change_state(new_state):
	state = new_state

func _physics_process(delta):
	Globalls.player = self
	motion = move_and_slide(motion, Vector2(0,-1))
	
	match state:
		STATES.IDLE:
			idle()
		STATES.ATTACK:
			attack()
	
	if Input.is_action_pressed("ply_down"):
		direction = "down"
	elif Input.is_action_pressed("ply_up"):
		direction = "up"

	if Input.is_action_pressed("ply_right"):
		direction = "right"
	elif Input.is_action_pressed("ply_left"):
		direction = "left"


	if direction == "down":
		$SpriteSword.position.y = 16
		$SpriteSword.position.x = 0
		$SpriteSword.rotation_degrees = 0
		$HitEmArea/HitEmCol.position.y = 16
		$HitEmArea/HitEmCol.position.x = 0
	elif direction == "up":
		$SpriteSword.position.y = -16
		$SpriteSword.position.x = 0
		$SpriteSword.rotation_degrees = 180
		$HitEmArea/HitEmCol.position.y = -16
		$HitEmArea/HitEmCol.position.x = 0

	if direction == "right":
		$SpriteSword.position.y = 0
		$SpriteSword.position.x = 16
		$SpriteSword.rotation_degrees = -90
		$HitEmArea/HitEmCol.position.y = 0
		$HitEmArea/HitEmCol.position.x = 16
	elif direction == "left":
		$SpriteSword.position.y = 0
		$SpriteSword.position.x = -16
		$SpriteSword.rotation_degrees = 90
		$HitEmArea/HitEmCol.position.y = 0
		$HitEmArea/HitEmCol.position.x = -16

func idle():
	$HitEmArea/HitEmCol.disabled = 1
	$SpriteSword.visible = 0
	if Input.is_action_pressed("ply_down"):
		motion.y = movespeed
	elif Input.is_action_pressed("ply_up"):
		motion.y = -movespeed
	else:
		motion.y = 0
	
	if Input.is_action_pressed("ply_right"):
		motion.x = movespeed
	elif Input.is_action_pressed("ply_left"):
		motion.x = -movespeed
	else:
		motion.x = 0
	
	if is_on_wall():
		if Input.is_action_pressed("ply_right"):
			position.x -= movespeed/20
			$SndBump.play()
		elif Input.is_action_pressed("ply_left"):
			position.x += movespeed/20
			$SndBump.play()
	elif is_on_floor():
		if Input.is_action_pressed("ply_down"):
			position.y -= movespeed/20
			$SndBump.play()
	elif is_on_ceiling():
		if Input.is_action_pressed("ply_up"):
			position.y += movespeed/20
			$SndBump.play()
	
	if Input.is_action_pressed("ply_attack"):
		change_state(STATES.ATTACK)

func attack():
	if !Input.is_action_pressed("ply_attack"):
		change_state(STATES.IDLE)
	$HitEmArea/HitEmCol.disabled = 0
	$SpriteSword.visible = 1
	motion.x = 0
	motion.y = 0

func _on_HitEmArea_body_entered(body):
	pass # Replace with function body.
