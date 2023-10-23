extends Spatial

export var blink: bool = true
export var blink_power: float = 0.1
var light_power: float


func _ready():
	light_power = $CampfireLight.omni_range


func _physics_process(delta):
	if blink:
		$CampfireLight.omni_range = light_power + randf() * blink_power
