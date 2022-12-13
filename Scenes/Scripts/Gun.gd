extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#Bullet Data
var bulletList = []
export var bulletSpeed = 100.0
export var bulletDistance = 1000
export var decay = 0.9
export var bulletTimeAlive = 2.0
export var bulletPerShot = 1
export var reloading = 0.25
export var reloadTime = 1.0
export var automatic = 1
var bulletScene = load('res://Scenes/Prefabs/Bullet.tscn')

onready var map = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var this = $"."
	if automatic == 1:
		if Input.is_action_pressed("shoot"):
			auto_fire(this)
			reloading -= delta
	elif automatic == 0:
		if Input.is_action_just_pressed("shoot"):
			semi_fire(this)
			reloading -= delta

func auto_fire(this):
	if reloading <= 0.0:
		for i in bulletPerShot:
			var bullet = bulletScene.instance()
			var globalRotation = this.get_global_rotation()
			var rotation = fmod(globalRotation.y, PI*2)
			#		print("rotation:", rotation)
			var bulletForceRotated = Vector3(0, 0, -bulletSpeed).rotated(Vector3.UP, rotation)
			bullet.transform.origin = this.get_global_transform().origin + Vector3(0, 0, 0).rotated(Vector3.UP, rotation)
			bullet.apply_central_impulse(bulletForceRotated)
			map.add_child(bullet)
		reloading = reloadTime

func semi_fire(this):
	for i in bulletPerShot:
		var bullet = bulletScene.instance()
		var globalRotation = this.get_global_rotation()
		var rotation = fmod(globalRotation.y, PI*2)
	#		print("rotation:", rotation)
		var bulletForceRotated = Vector3(0, 0, -bulletSpeed).rotated(Vector3.UP, rotation)
		bullet.transform.origin = this.get_global_transform().origin + Vector3(0, 0, 0).rotated(Vector3.UP, rotation)
		bullet.apply_central_impulse(bulletForceRotated)
		map.add_child(bullet)
	reloading = reloadTime
