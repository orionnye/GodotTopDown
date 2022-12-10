extends RigidBody

export var velocity: Vector3
export var birthTime: float
export var decay = 0.9
# Called when the node enters the scene tree for the first time.
func _ready():
	birthTime = Time.get_ticks_msec()
	var this = $"."
	var bulletPosition = this.get_global_transform().origin
	var _timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.start()
#	this.apply_impulse(velocity, bulletPosition)
#	this.velocity = this.velocity*decay

func _on_Timer_timeout():
	var this = $"."
	var parent = get_parent()
	parent.remove_child(this)

func _integrate_forces(state):
	pass
