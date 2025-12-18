extends Node2D

const canvas_enemigo = preload("res://escenas/HUD/HUD.tscn")
var HUDEne

var pausa_ui = preload("res://escenas/UI/Pausa UI.tscn")
var pausa = null

var enemigos_restantes = 0
var enemigos_del_HUD = 4
var aliado_rescatado = false


func _ready():
	
	$Timer.start()
	
	set_pause_mode(Node.PAUSE_MODE_PROCESS)
	
	HUDEne = canvas_enemigo.instance()
	add_child(HUDEne)
	# Contar cuántos tanques enemigos hay al iniciar el nivel
	enemigos_restantes = get_tree().get_nodes_in_group("enemigo").size()
	print("Enemigos en el nivel:", enemigos_restantes)
	
	HUDEne.cuantos_enemigos_restan(enemigos_del_HUD)

#Función para pausar el juego
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		
		if get_tree().paused:
			pausa = pausa_ui.instance()
			add_child(pausa)
		else:
			pausa.queue_free()
			

#Funcion para verificar si los enemigos estan muertos
func enemigo_muerto():
	
	enemigos_restantes -= 1
	enemigos_del_HUD = enemigos_restantes
	
	HUDEne.cuantos_enemigos_restan(enemigos_del_HUD)
	
	print("Enemigos restantes:", enemigos_restantes)
	verificar_victoria()

#Funcion para verificar si el aliado fue rescatado
func aliado_rescatado_func():
	aliado_rescatado = true
	print("Aliado rescatado!")
	verificar_victoria()

#Funcion para verificar victoria
func verificar_victoria():
	if aliado_rescatado and enemigos_restantes <= 0:
		print("GANASTE!")
		var victoria = load("res://escenas/UI/win.tscn").instance()
		get_parent().add_child(victoria)
		



