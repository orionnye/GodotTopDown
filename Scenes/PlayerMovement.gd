extends KinematicBody

#Player Movement
export var speed = 5
export var maxSpeed = 10
var decay = 0.9
var velocity = Vector3()

#Global tools
onready var map = $"../."
onready var this= $"."

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
	var mousePos = get_viewport().get_mouse_position()
	
	var mouseDirection = midScreen - mousePos
	var playerPos = this.get_global_transform().origin
	var mousePosInSpace = playerPos + Vector3(mouseDirection.x, 0, mouseDirection.y)
	#this.look_at(Vector3(mouseDirection.x, 0, mouseDirection.y), Vector3(0, 1, 0))
	this.look_at(Vector3(mousePosInSpace.x, 0, mousePosInSpace.y), Vector3(0, 1, 0))
	this.rotation.x = 0
	this.rotation.z = 0
