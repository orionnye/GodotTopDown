extends RigidBody

export var velocity: Vector3
export var birthTime: float
export var decay = 0.9
# Called when the node enters the scene tree for the first time.
func _ready():
	birthTime = Time.get_ticks_msec()
	var this = $"."
	var bulletPosition = this.get_global_transform().origin
#	this.apply_impulse(velocity, bulletPosition)
#	this.velocity = this.velocity*decay

func _integrate_forces(state):
	pass
