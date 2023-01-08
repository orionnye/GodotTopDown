extends "res://Scenes/Scripts/Player.gd"

func _ready():
	var _timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.start()
func _process(delta):
	var this = $"."
	var direction = Vector3.ZERO
	if Input.is_action_pressed("ui_right") && velocity.length() < maxSpeed:
		velocity.x -= speed
	if Input.is_action_pressed("ui_left") && velocity.length() < maxSpeed:
		velocity.x += speed
	if Input.is_action_pressed("ui_down") && velocity.length() < maxSpeed:
		velocity.z -= speed
	if Input.is_action_pressed("ui_up") && velocity.length() < maxSpeed:
		velocity.z += speed

#	velocity = move_and_slide(velocity, Vector3.UP)
	this.apply_central_impulse(velocity)
	velocity = velocity*decay
#	lookAtMouse()

func look_follow(state, current_transform, target_position):
	var up_dir = Vector3(0, 1, 0)
#	target_position = Vector3(-1, 0, 1)
	var cur_dir = current_transform.basis.xform(Vector3(0, 0, 1))
	var target_dir = target_position.normalized()
	
	var cur_angle = Vector2(cur_dir.x, cur_dir.z).angle()
	var target_angle = Vector2(target_dir.x, target_dir.z).angle()
#	var rotation_angle = acos(cur_dir.z) - acos(target_dir.z)
	var rotation_angle = cur_angle - target_angle

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

func _integrate_forces(state):
	var mouse = get_mouse_pos()
	var target_position = Vector3(mouse.x, 0, mouse.y)
	look_follow(state, get_global_transform(), target_position)

func lookAtMouse():
	var this = $"."
	var screenDimensions = get_viewport().get_visible_rect().size
	var midScreen = screenDimensions/2
	var _mousePos = get_viewport().get_mouse_position()
	var _playerPos = this.get_global_transform().origin
	var playerPos = cam.unproject_position(_playerPos)
	
	var mousePos = playerPos - _mousePos
	this.look_at(Vector3(mousePos.x, 0, mousePos.y), Vector3(0, 1, 0))
	this.rotation.x = 0
	this.rotation.z = 0


func _on_Timer_timeout():
	var cam = $"Camera"
	var sc = get_viewport().get_mouse_position() / 2
	var _playerPos = this.get_global_transform().origin
	var playerPos = cam.unproject_position(_playerPos)
	var _mousePos = get_viewport().get_mouse_position()
	
	var mousePos = Vector2(playerPos.x, playerPos.y) - _mousePos
#	print("Mouse pos: ", _mousePos, "\nPlayer pos: ", playerPos)
