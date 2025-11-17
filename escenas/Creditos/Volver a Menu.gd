extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_Button_pressed():
	get_tree().change_scene("res://escenas/menu.tscn")
func _on_Volver_a_Menu_pressed():
	get_tree().change_scene("res://escenas/menu.tscn")

