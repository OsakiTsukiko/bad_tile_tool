extends Node

onready var spr = $Sprite

func save_1(content):
	var file = File.new()
	file.open("user://img_arr.dat", File.WRITE)
	file.store_string(content)
	file.close()
	
func save_2(content):
	var file = File.new()
	file.open("user://rule_arr.dat", File.WRITE)
	file.store_string(content)
	file.close()

onready var m_arr = [
	$m_1,
	$m_2,
	$m_3,
	$m_4,
	$m_5,
	$m_6,
	$m_7,
	$m_8,
	$m_9
]

var img_array = []
var url_array = []
var main_array = []
var out_array = []

var txtr_0 = load("res://assets/dirt/tile013.png")
var txtr_1 = load("res://assets/grass/tile013.png")

var global_idx = 0

func do_instance ():
	if ( img_array.size() > global_idx ): 
		spr.texture = img_array[global_idx]
		main_array = [0, 0, 0, 0, 0, 0, 0, 0, 0]
		for m in m_arr:
			m.texture = txtr_0

func update_arr (idx):
	if main_array[idx]:
		main_array[idx] = 0
		m_arr[idx].texture = txtr_0
	else:
		main_array[idx] = 1
		m_arr[idx].texture = txtr_1

func do_next ():
	if global_idx < img_array.size():
		out_array.push_back(main_array)
		global_idx += 1
		do_instance()
	else:
		save_2(JSON.print(out_array))

func _ready():
	for i in range(48):
		var s = "res://assets/dirt/tile0"
		if i >= 0 && i <= 9: s += "0"
		s += String(i)
		s += ".png"
		img_array.push_back(load(s))
	for i in range(48):
		var s = "res://assets/grass/tile0"
		if i >= 0 && i <= 9: s += "0"
		s += String(i)
		s += ".png"
		img_array.push_back(load(s))
		url_array.push_back(s)
	save_1(JSON.print(url_array))
	do_instance()
	pass

func _process(delta):
	if Input.is_action_just_pressed("m1"): update_arr(0)
	if Input.is_action_just_pressed("m2"): update_arr(1)
	if Input.is_action_just_pressed("m3"): update_arr(2)
	if Input.is_action_just_pressed("m4"): update_arr(3)
	if Input.is_action_just_pressed("m5"): update_arr(4)
	if Input.is_action_just_pressed("m6"): update_arr(5)
	if Input.is_action_just_pressed("m7"): update_arr(6)
	if Input.is_action_just_pressed("m8"): update_arr(7)
	if Input.is_action_just_pressed("m9"): update_arr(8)
	
	if Input.is_action_just_pressed("ui_accept"): do_next()
