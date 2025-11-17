extends CanvasLayer

var Live1
var Live2
var Live3
var Live4
var Live5

var a_save

func _ready():
	Live1 = get_node("TextureRect/V1")
	Live2 = get_node("TextureRect/V2")
	Live3 = get_node("TextureRect/V3")
	Live4 = get_node("TextureRect/V4")
	Live5 = get_node("TextureRect/V5")
	
	a_save = get_node("TextureRect/aliado_salvado")
	a_save.visible = false

func lives_out(var vidas_del_p):
	
	if vidas_del_p == 0:
		Live1.visible = false
		Live2.visible = false
		Live3.visible = false
		Live4.visible = false
		Live5.visible = false
	
	if vidas_del_p == 1:
		Live2.visible = false
		Live3.visible = false
		Live4.visible = false
		Live5.visible = false
	
	if vidas_del_p == 2:
		Live3.visible = false
		Live4.visible = false
		Live5.visible = false
	
	if vidas_del_p == 3:
		Live4.visible = false
		Live5.visible = false
	
	if vidas_del_p == 4:
		Live5.visible = false
	pass

func save(var jugador_cerca):
	
	if jugador_cerca == true:
		a_save.visible = true
