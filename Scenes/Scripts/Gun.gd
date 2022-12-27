extends Spatial
#Bullet Data
var bulletList = []
export var bulletSpeed = 100.0
export var bulletDistance = 1000
export var decay = 0.9
export var bulletPerShot = 1
export var spread = PI/4
export var reloadTime = 1.0
var reloading = 0
export var bulletTimeAlive = 2.0
export var automatic = true
var bulletScene = load('res://Scenes/Prefabs/Bullet.tscn')

onready var map = $"../.."

func _process(delta):
	var this = $"."
	if reloading <= 0:
		if automatic:
			if Input.is_action_pressed("shoot"):
				fire()
		else:
			if Input.is_action_just_pressed("shoot"):
				fire()
	elif reloading > 0:
		reloading -= delta

func fire():
	for i in bulletPerShot:
		var random = RandomNumberGenerator.new()
		random.randomize()
		var direction = randf()*spread - spread/2
		fire_bullet(bulletSpeed, direction)
	reloading = reloadTime

func fire_bullet(speed, direction):
#	direction is measured in radians from straight forward of gun(ie: -PI/6, PI/8)
	var this = $"."
	var bullet = bulletScene.instance()
	var globalRotation = this.get_global_rotation()
	
	var rotation = fmod(globalRotation.y, PI)
	var bulletForceRotated = Vector3(0, 0, -speed).rotated(Vector3.UP, rotation+direction)
	
	bullet.transform.origin = this.get_global_transform().origin
	bullet.apply_central_impulse(bulletForceRotated)
	map.add_child(bullet)
