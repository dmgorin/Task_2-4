extends Spatial

export var sphere_speed: float = 0.1


func _ready():
	$Path/PathFollow.unit_offset = 0


func _process(delta):
	$Path/PathFollow.unit_offset += sphere_speed * delta


func return_to_menu() -> void:
	get_tree().change_scene("res://scenes/Menu.tscn")
