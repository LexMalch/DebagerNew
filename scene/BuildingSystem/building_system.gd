extends Node2D
#@export var walls = preload()
@export var turret = preload("res://scene/turret/turret.tscn")
@export var feeler = preload("res://scene/feeler/feeler.tscn")
@export var tower = preload("res://scene/tower/tower.tscn")
var builds = []
var curr_build
var pointer: = 0
var curr_build_scene
var curr_pos
var building_mode = false
var building_avalible = false
var curr_sprite
func _ready() -> void:
	builds = [turret,feeler,tower]
	curr_build = builds[pointer]
	
func _physics_process(delta: float) -> void:
	
	if %Player.build_mode == true:
		get_pos()
		$Sprite2D.position= curr_pos
		if curr_build == tower:
			$Sprite2D.position= curr_pos + Vector2(0,-16-8)
		$Polygon2D.position= curr_pos
		$Label.position= curr_pos+Vector2(-5,-10)
		check_building_status()
	if %Player.build_mode == false:
		$Sprite2D.visible = false
		$Polygon2D.visible = false
		$Label.visible = false

func _input(event):
	if event.is_action_pressed("build_mode"):
		if %Player.build_mode == false:
			curr_build = builds[pointer]
			curr_build_scene = curr_build.instantiate()
			curr_sprite = curr_build_scene.building_sprite
			$Label.text= str(curr_build_scene.price)
			if curr_build_scene.price <= Globals.dollors:
				$Label.modulate = Color(1,1,1,1)
			else:
				$Label.modulate = Color.BROWN
			$Sprite2D.texture = curr_sprite
			$Sprite2D.show()
			$Label.show()
			%Player.set_mode("3")
		elif %Player.build_mode == true:
			$Polygon2D.hide()
			$Label.hide()
			$Sprite2D.hide()
			%Player.set_mode("0")
	if event.is_action_pressed("switch"):
		if pointer<(builds.size()-1):
			pointer+=1
		else:
			pointer=0
		curr_build = builds[pointer]
		curr_build_scene = curr_build.instantiate()
		curr_sprite = curr_build_scene.building_sprite
		$Sprite2D.texture = curr_sprite
		$Label.text= str(curr_build_scene.price)
		if curr_build_scene.price <= Globals.dollors:
			$Label.modulate = Color(1,1,1,1)
		else:
			$Label.modulate = Color.BROWN
	if event.is_action_pressed("lmb"):
		bild()
func get_pos():
		var mouse_local = %floor.get_local_mouse_position()
		var tile_coords = %floor.local_to_map(mouse_local)
		var curr_data   = %floor.get_cell_atlas_coords(tile_coords)
		var p = %floor.to_global(%floor.map_to_local(tile_coords))
		if curr_data == Vector2i(2,0) or curr_data == Vector2i(0,0) or curr_data == Vector2i(0,2) or curr_data == Vector2i(2,2):
			curr_pos = p 
		elif curr_data == Vector2i(3,0)or curr_data == Vector2i(1,0)or curr_data == Vector2i(1,2)or curr_data == Vector2i(3,2):
			curr_pos = p 
		elif curr_data == Vector2i(2,1)or curr_data == Vector2i(0,1)or curr_data == Vector2i(0,3)or curr_data == Vector2i(2,3):
			curr_pos = p 
		elif curr_data == Vector2i(3,1)or curr_data == Vector2i(1,1)or curr_data == Vector2i(1,3)or curr_data == Vector2i(3,3):
			curr_pos = p 
func check_building_status():
	if %floor.get_cell_tile_data(%floor.local_to_map(%floor.get_local_mouse_position())):
		if %floor.get_cell_tile_data(%floor.local_to_map(%floor.get_local_mouse_position())).get_custom_data("blue") == true and not (curr_pos in Globals.busy_plase):

			$Polygon2D.visible = false
			building_avalible = true
		else:
			$Polygon2D.visible = true
			building_avalible = false
func bild():
	curr_build_scene = curr_build.instantiate()
	if %Player.build_mode == true and building_avalible == true and curr_build_scene.price <= Globals.dollors:
		Globals.dollors -=curr_build_scene.price
		curr_build_scene = curr_build.instantiate()
		if curr_build != tower:
			curr_build_scene.global_position = curr_pos
			Globals.busy_plase.append(curr_build_scene.global_position)
		
		else:
			curr_build_scene.global_position = curr_pos+ Vector2(0,-16-8)
			Globals.busy_plase.append(curr_build_scene.global_position+ Vector2(0,-16-8+348))
		
			
		add_child(curr_build_scene)
	if curr_build_scene.price <= Globals.dollors:
		$Label.modulate = Color(1,1,1,1)
	else:
		$Label.modulate = Color.BROWN

	
