extends KinematicBody

#Player Movement
export var speed = 5
export var maxSpeed = 10
var decay = 0.9
var velocity = Vector3()

#Global tools
onready var this = $"."
onready var map = $"../."
onready var cam = $"Camera"
onready var gun = $"./Shotgun"

func _ready():
	pass
func _process(delta):
	var recoil = Vector3()
	if gun.automatic:
		if Input.is_action_pressed("shoot"):
			gun.fire()
#			this.apply_impulse(this.get_global_transform().origin, gun.get_recoil())
	else:
		if Input.is_action_just_pressed("shoot"):
			gun.fire()
