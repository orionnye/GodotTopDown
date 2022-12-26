extends Spatial

#Bullet Data
export var bulletSpeed = 20
export var bulletsPerShot = 2
export var accuracy = 1.3
export var shotDelay = 2
var onCooldown = false

export var decay = 0.9
var bulletScene = load('res://Scenes/Prefabs/Bullet.tscn')

onready var map = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var this = $"."

	if Input.is_action_pressed("shoot") && !onCooldown:
		onCooldown = true
		var _timer = Timer.new()
		add_child(_timer)
		_timer.connect("timeout", self, "_on_Timer_timeout")
		_timer.set_one_shot(true)
		_timer.set_wait_time(shotDelay)
		_timer.start()
		
		var globalRotation = this.get_global_rotation()
		for i in bulletsPerShot:
			var random = RandomNumberGenerator.new()
			random.randomize()
			var bullet = bulletScene.instance()
			var rotation = fmod(globalRotation.y, (PI*2)*accuracy)
			var bulletForceRotated = Vector3(0, 0, -bulletSpeed).rotated(Vector3.UP, rotation)
			
			bullet.transform.origin = this.get_global_transform().origin
			bullet.apply_central_impulse(bulletForceRotated)
			map.add_child(bullet)

func _on_Timer_timeout():
	onCooldown = false
