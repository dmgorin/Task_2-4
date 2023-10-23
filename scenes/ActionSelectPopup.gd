extends PopupDialog

signal yes_selected
signal no_selected
export var text: String


func _ready():
	$ButtonsContainer.add_constant_override("separation", 10)
	$RichTextLabel.set_text(text)


func button_pressed() -> void:
	if $ButtonsContainer/ButtonYes.pressed:
		emit_signal("yes_selected")
	elif $ButtonsContainer/ButtonNo.pressed:
		emit_signal("no_selected")
	hide()
