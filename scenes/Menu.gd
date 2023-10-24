extends Control

enum Anchors {
	LEFT,
	TOP,
	RIGHT,
	BOTTOM
}
# Хрянятся только Left и Top якоря, так как размер кнопок определяется их Margin,
# и, соответственно, Left = Right и Top = Bottom.
const POSITIONS_ANCHOR: Dictionary = {
	0: [0.25, 0.25],
	1: [0.75, 0.25],
	2: [0.25, 0.75],
	3: [0.75, 0.75]
}
export var move_time: float = 1.0
# Целевое/текущее положение кнопок.
export var buttons_position: Array = [1, 3, 2, 0]
var is_buttons_move: bool = false
var buttons_move_vector: PoolVector2Array = [
	Vector2.ZERO,
	Vector2.ZERO,
	Vector2.ZERO,
	Vector2.ZERO
]


func _ready():
	set_process(false)
	randomize()


func _process(delta):
	var i: int = 0
	for button in $Buttons.get_children():
		button.anchor_left += buttons_move_vector[i].x * delta / move_time
		button.anchor_right = button.anchor_left
		button.anchor_top += buttons_move_vector[i].y * delta / move_time
		button.anchor_bottom = button.anchor_top
		i += 1


func show_change_scene_dialog() -> void:
	$CustomWindowDialog.popup_centered_ratio(0.5)


func process_dialog_output(value: int) -> void:
	match value:
		0:
			change_scene()
		1:
			pass


func change_scene() -> void:
	get_tree().change_scene("res://scenes/CampfireScene.tscn")


func do_some_effect() -> void:
	$AnimationPlayer.play("thanos_things")


func shuffle_buttons() -> void:
	if not is_buttons_move:
		is_buttons_move = true
		# Исключение повторений
		var temp_range = range(4)
		temp_range.shuffle()
		while temp_range == buttons_position:
			temp_range.shuffle()
		#___
		buttons_position = temp_range.duplicate()
		var i: int = 0
		for button in $Buttons.get_children():
			buttons_move_vector[i] = Vector2(POSITIONS_ANCHOR[buttons_position[i]][Anchors.LEFT] - button.anchor_left, POSITIONS_ANCHOR[buttons_position[i]][Anchors.TOP] - button.anchor_top)
			i += 1
		set_process(true)
		yield(get_tree().create_timer(move_time), "timeout")
		set_process(false)
		# На всякий случай устанавливаю ровно значения якорей после завершения анимации.
		i = 0
		for button in $Buttons.get_children():
			button.anchor_left = POSITIONS_ANCHOR[buttons_position[i]][Anchors.LEFT]
			button.anchor_right = button.anchor_left
			button.anchor_top = POSITIONS_ANCHOR[buttons_position[i]][Anchors.TOP]
			button.anchor_bottom = button.anchor_top
			i += 1
		is_buttons_move = false


func shuffle_button_text() -> void:
	$Buttons/Button1.text = shuffle_string($Buttons/Button1.text)
	$Buttons/Button3.text = shuffle_string($Buttons/Button3.text)
	$Buttons/Button4.text = shuffle_string($Buttons/Button4.text)


func shuffle_string(string: String) -> String:
	var new_string: Array
	for single_char in string:
		new_string.append(single_char)
	new_string.shuffle()
	string = ""
	for single_char in new_string:
		string += single_char
	return string


func show_exit_dialog() -> void:
	$YesNoPopup.popup_centered_ratio(0.3)


func exit() -> void:
	get_tree().quit()
