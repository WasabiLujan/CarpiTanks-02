extends Button

# Variables que vamos a configurar desde el editor
export(Texture) var imagen
export(String) var nombre

func _ready():
	$TextureRect.texture = imagen
	$Label.text = nombre


func _on_pj_card_pressed():
	print("¡Seleccionaste a: " + nombre + "!")
	get_tree().change_scene("res://escenas/esenario_del_nivel/Nivel.tscn")


func _on_volver_pressed():
	get_tree().change_scene("res://escenas/menu/menu.tscn")


func _on_volver_t_pressed():
	get_tree().change_scene("res://escenas/menu/seleccion_personaje.tscn")
