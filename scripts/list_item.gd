extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_text(text: String):
	%Text.text= text

func _on_button_up():
	if get_parent().get_parent().name.to_lower() == "scrollcategory":
		get_parent().get_parent().get_parent()._on_category_text_changed(%Text.text)
	elif get_parent().get_parent().name.to_lower() == "scrollplace":
		get_parent().get_parent().get_parent()._on_place_text_changed(%Text.text)


func _on_delete_button_up():
	if get_parent().get_parent().name.to_lower() == "scrollcategory":
		g.categories.erase(%Text.text)
		queue_free()
	elif get_parent().get_parent().name.to_lower() == "scrollplace":
		g.places.erase(%Text.text)
		queue_free()
