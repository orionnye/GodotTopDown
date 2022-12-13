extends KinematicBody

#Player Movement
export var speed = 5
export var maxSpeed = 10
var decay = 0.9
var velocity = Vector3()

#Global tools
onready var map = $"../."
onready var this= $"."
onready var cam = $"Camera"

func _ready():
	var _timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.start()
func _process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("ui_right") && velocity.length() < maxSpeed:
		velocity.x -= speed
	if Input.is_action_pressed("ui_left") && velocity.length() < maxSpeed:
		velocity.x += speed
	if Input.is_action_pressed("ui_down") && velocity.length() < maxSpeed:
		velocity.z -= speed
	if Input.is_action_pressed("ui_up") && velocity.length() < maxSpeed:
		velocity.z += speed

	velocity = move_and_slide(velocity, Vector3.UP)
	velocity = velocity*decay
	
	var screenDimensions = get_viewport().get_visible_rect().size
	var midScreen = screenDimensions/2
	var _mousePos = get_viewport().get_mouse_position()
	
	var _playerPos = this.get_global_transform().origin
	var playerPos = cam.unproject_position(_playerPos)
	
	var mousePos = playerPos - _mousePos
	
	#this.look_at(Vector3(mouseDirection.x, 0, mouseDirection.y), Vector3(0, 1, 0))
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
	print("Mouse pos: ", _mousePos, "\nPlayer pos: ", playerPos)


