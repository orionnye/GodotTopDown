extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#Bullet Data
var bulletList = []
export var bulletSpeed = 50
export var bulletDistance = 1000
export var gunLength = 1
export var gunHeight = 1
export var decay = 0.9
var bulletScene = load('./Scenes/Bullet.tscn') 

onready var map = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var this = $"."
	if Input.is_action_pressed("shoot"):
		var bullet = bulletScene.instance()
		var globalRotation = this.get_global_rotation()
		var rotation = fmod(globalRotation.y, PI*2)
		print("rotation:", rotation)
		var bulletForceRotated = Vector3(0, 0, -bulletSpeed).rotated(Vector3.UP, rotation)
		
		bullet.transform.origin = this.get_global_transform().origin + Vector3(0, gunHeight, -gunLength).rotated(Vector3.UP, rotation)
		
		bullet.apply_central_impulse(bulletForceRotated)
		map.add_child(bullet)
