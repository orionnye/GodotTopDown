extends Camera3D

# Called when the node enters the scene tree for the first time.
@export var cameraRotation = Vector3(-PI/3, PI, 0)
@export var cameraOffset = Vector3(0, 15, 10)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var this = $"."
	var player = $"./.."
	var playerOffset = player.rotation
#	this.global_transform.origin = Vector3(0, 40, 0)
	this.set_global_rotation(cameraRotation)
	this.rotation = cameraRotation - playerOffset
	this.transform.origin = cameraOffset.rotated(Vector3(0, 1, 0), - (player.rotation.y + 3))
