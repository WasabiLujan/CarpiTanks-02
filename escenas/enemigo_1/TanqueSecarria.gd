extends KinematicBody2D
""""
var movimiento = Vector2()
var velocidad = 80
#Usar un escalador para que cuando le disparen una vez a los más fuertes, se hagan más chiquito

var arriba
var abajo 
var derecha
var izquierda 

var arriba_a_la_derecha 
var arriba_a_la_izquierda 
var abajo_a_la_derecha 
var abajo_a_la_izquierda 

var detenerce = Vector2(0,0)


func _ready():
	randomize()
	
	arriba = Vector2(0,-1)
	abajo = Vector2(0,1)
	derecha = Vector2(1,0)
	izquierda = Vector2(-1,0)
	
	arriba_a_la_derecha = Vector2(1,-1).normalized()
	arriba_a_la_izquierda = Vector2(-1,-1).normalized()
	abajo_a_la_derecha = Vector2(1,1).normalized()
	abajo_a_la_izquierda = Vector2(-1,1).normalized()

	
	$Timer.start()


func _physics_process(delta):
	move_and_slide(movimiento * velocidad)


func obtener_dierccion_random():
	var rango = randi() % 9
	match rango:
		0: return arriba
		1: return abajo
		2: return derecha
		3: return izquierda
		4: return arriba_a_la_derecha
		5: return arriba_a_la_izquierda
		6: return abajo_a_la_derecha
		7: return abajo_a_la_izquierda
		8: return detenerce


func _on_Timer_timeout():
	movimiento = obtener_dierccion_random()
	rotar()
	var tiempo_de_cambios = randf() * 4 + 0.5
	$Timer.wait_time = tiempo_de_cambios
	$Timer.start()

func rotar():
	if movimiento == arriba:
		rotation_degrees = 0
	elif movimiento == abajo:
		rotation_degrees = 180
	elif movimiento == derecha:
		rotation_degrees = 90
	elif movimiento == izquierda:
		rotation_degrees = 270
	elif movimiento == arriba_a_la_derecha:
		rotation_degrees = 45
	elif movimiento == abajo_a_la_derecha:
		rotation_degrees = 135
	elif movimiento == abajo_a_la_izquierda:
		rotation_degrees = 225
	elif movimiento == arriba_a_la_izquierda:
		rotation_degrees = 315


func _on_NPC_frame_changed():
	pass # Replace with function body.



func _on_Area2D_body_entered(body):
	if body.is_in_group("obstaculos y limites"):
		movimiento = obtener_dierccion_random()
		rotar()
	pass # Replace with function body.
"""
#Nope este
""""
var jugador = null

movimiento = Vector2.ZERO
var velocidad = 200

func _physics_process(delta):
	movimiento = Vector2.ZERO
	
	if jugador != null:
		movimiento = position.direction_to(jugador.position)
	else:
		movimiento = Vector2.ZERO
	movimiento = movimiento.normalized() * velocidad
	movimiento = move_and_slide(movimiento)

func _on_Area2D_body_entered(body):
	if body != self:
		jugador = body
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	jugador = null
	pass # Replace with function body.

"""

var velocidad = 25
var seguir_al_jugador = false
var jugador = null

func _physics_process(delta):
	if seguir_al_jugador:
		position += (jugador.position + position)/velocidad
		#agregar animaciones despues


func _on_Area_deteccion_enemigo_body_entered(body):
	jugador = body
	seguir_al_jugador = true

func _on_Area_deteccion_enemigo_body_exited(body):
	jugador = null
	seguir_al_jugador = false
