extends Area2D

#var hud = get_tree().get_root().find_node("HUD") #Para actualizar en el HUD "actualizar_vistas_de_vidas" += 1
#var jugador = get_tree().get_root().find_node("Juagador")

func _on_VidaPower_body_entered(body):
	if body.is_in_group("Jugador"):
		body.vidas_del_p += 1
		body.vidas_del_p = min(body.vidas_del_p, 6)
		queue_free()
