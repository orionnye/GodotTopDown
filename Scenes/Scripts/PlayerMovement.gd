extends "res://Scenes/Scripts/Player.gd"

# -----------------Mobility Functions------------------------
func move(character):
	var direction = Vector3.ZERO
	var acceleration = Vector3(0, 0, 0)
	if !jumping:
		if Input.is_action_pressed("ui_right"):
			acceleration.x -= speed
		if Input.is_action_pressed("ui_left"):
			acceleration.x += speed
		if Input.is_action_pressed("ui_down"):
			acceleration.z -= speed
		if Input.is_action_pressed("ui_up"):
			acceleration.z += speed
		if Input.is_action_just_pressed("ui_jump"):
			jump(character)
	
	acceleration = acceleration.normalized() * maxSpeed
	character.apply_central_impulse(acceleration)
	
	if jumping:
		character.set_linear_damp(airDamp)
	else:
		character.set_linear_damp(groundDamp)

func jump(character):
	jumping = true
	character.apply_central_impulse(Vector3(0, character.jumpForce, 0))
	print("starting Jump")
	var _timer = Timer.new()
	character.add_child(_timer)
	
	_timer.connect("timeout", self, "jump_timeout")
	_timer.set_one_shot(true)
	_timer.set_wait_time(jumpTime)
	_timer.start()
	
func jump_timeout():
	jumping = false
	print("ending Jump")
# ---------------Aim Functions---------------------------
func look_follow(state, current_transform, target_position):
	var up_dir = Vector3(0, 1, 0)
	var cur_dir = current_transform.basis.xform(Vector3(0, 0, 1))
	var target_dir = target_position.normalized()
	
	var cur_angle = Vector2(cur_dir.x, cur_dir.z).angle()
	var target_angle = Vector2(target_dir.x, target_dir.z).angle()
	var rotation_angle = cur_angle - target_angle
	if (abs(rotation_angle) <= PI):
		state.set_angular_velocity(up_dir * (rotation_angle / state.get_step()))

func get_mouse_pos() -> Vector2:
	var this = $"."
	var screenDimensions = get_viewport().get_visible_rect().size
	var midScreen = screenDimensions/2
	var _mousePos = get_viewport().get_mouse_position()
	var _playerPos = this.get_global_transform().origin
	var playerPos = cam.unproject_position(_playerPos)
	
	var mousePos = _mousePos - playerPos
	return mousePos

# ----------------Exit--(i dunno, everything is called from these functions before leaving)
func ready():
	pass
#processes called every frame
func _process(delta):
	var this = $"."
#	Character movement controller
	move(this)

#physics function overload that is called during the physics process
func _integrate_forces(state):
#	Character Aim Controller
	var mouse = get_mouse_pos()
	var target_position = Vector3(mouse.x, 0, mouse.y)
	look_follow(state, get_global_transform(), target_position)
