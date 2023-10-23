extends WindowDialog

signal action_selected(button_num)
export var title: String
export var text: String
export var buttons_list: Array


func _ready():
	window_title = title
	$RichTextLabel.set_text(text)
	$ButtonsContainer.add_constant_override("separation", 10)
	for button in buttons_list:
		var button_instance = Button.new()
		button_instance.text = button
		button_instance.size_flags_horizontal = SIZE_EXPAND_FILL
		$ButtonsContainer.add_child(button_instance)
		button_instance.connect("pressed", self, "button_pressed")


func button_pressed() -> void:
	for button in $ButtonsContainer.get_children():
		if button.pressed:
			# Возвращает номер нажатой кнопки из списка, переданного в диалоговое окно.
			emit_signal("action_selected", buttons_list.find(button.text))
			hide()
