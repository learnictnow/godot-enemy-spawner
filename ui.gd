extends Control

signal spawner_selection(selected_spawner)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_toggled(toggled_on):
	if toggled_on == true:
		print('helloA') # show popup
		spawner_selection.emit("A")
	else:
		print('goodbyeA') # hide popup
	


func _on_button_3_toggled(toggled_on):
	if toggled_on == true:
		print('helloB') # show popup
		spawner_selection.emit("B")
	else:
		print('goodbyeB') # hide popup
	pass # Replace with function body.


func _on_button_2_toggled(toggled_on):
	if toggled_on == true:
		print('helloC') # show popup
		spawner_selection.emit("C")
	else:
		print('goodbyeC') # hide popup
	pass # Replace with function body.
