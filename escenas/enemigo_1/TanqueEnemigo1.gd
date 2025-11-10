extends KinematicBody2D

const proyectil_enemigo = preload("res://escenas/enemigo_1/proyectil_enemigo.tscn")

var jugador = null

var movimiento = Vector2.ZERO
var velocidad = 100


func _physics_process(delta):
	movimiento = Vector2.ZERO
	
	if jugador != null:
		movimiento = position.direction_to(jugador.position)
	else:
		movimiento = Vector2.ZERO
	movimiento = movimiento.normalized() * velocidad
	
	#Rotacion del sprite
	
	if movimiento.length() > 0.1 and $Sprite:
		# Calcula el ángulo hacia donde se mueve
		var angulo = movimiento.angle() + PI/2 # Ajustá el offset si tu sprite mira hacia arriba 
		
		$Sprite.rotation = angulo
		
	move_and_slide(movimiento)

func _on_Area2D_body_entered(body): #Con este puede perseguir al tanque del jugador, falta ajustar direccion del sprite
	if body != self:
		jugador = body


func _on_Area2D_body_exited(body):
	jugador = null

func _on_Area_de_comenzar_a_disparar_body_entered(body):
	if body.is_in_group("Tanque"): #Falta crear un grupo de jugadores
		jugador = body
		$tiempo_prev_al_disparo.start()


func _on_Area_de_comenzar_a_disparar_body_exited(body):
	if body == jugador:
		jugador = null
		#Detener el disparo
		$tiempo_prev_al_disparo.stop()


func _on_tiempo_prev_al_disparo_timeout():
	if jugador != null: #De esta forma refornzamos que solo suceda si hay un jugador
		disparar()

func disparar():
	var proyectil = proyectil_enemigo.instance()
	proyectil.position = $PosicionDelDisparo.global_position
	proyectil.rotation = $Sprite.rotation
	
	get_parent().add_child(proyectil)


""""
	var proyectil = proyectil_enemigo.instance() #quizas deba renombrar la var de aca
	proyectil.position = self.position
	get_parent().add_child(proyectil)
"""
