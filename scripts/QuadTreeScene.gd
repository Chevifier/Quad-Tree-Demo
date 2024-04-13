extends Node2D
#old and new position of mouse
var last_mp = Vector2()
var mp = Vector2()
#the root instance of the quadtree
@export var qtree:PackedScene;
var qt
var insert_timer = 0
#the search rectangle
var qrec
var qu_points = []
var total = 0
var drag_mode = false
func _ready():
	qrec = Rectangle.new()
	qrec.setRect(300,300,500,500)
	qt = qtree.instantiate()
	var rec = Rectangle.new()
	rec.setRect(1920/2,1080/2,1024,1024)
	qt.boundary = rec
	add_child(qt)
	$cap.text = str(QuadTreeGlobals.quad_capacity)

func add_random_points(amount):
	for i in amount:
		total += 1
		var p = Point.new()
		p.x = randf_range(1920/2-1024/2,1024*2)
		p.y = randf_range(1080/2-1024/2,1024*2)
		qt.insert(p)

func add_points():
	var p = Point.new()
	p.x = mp.x
	p.y = mp.y
	qt.insert(p)
	
		
func _process(_delta):
	$fps.text = "FPS: " + str(Engine.get_frames_per_second())
	qrec.x = mp.x
	qrec.y = mp.y
	qu_points = qt.query(qrec,[])
	#for p in qu_points:
		#p.move()
	$points.text = "Points_Highlighted: "+ str(qu_points.size())+"\nTotal Points: "+ str(QuadTreeGlobals.total)
	if last_mp != mp:
		queue_redraw()
		last_mp = mp

func _draw():
	draw_rect(get_viewport_rect(),Color.BLACK)
	var r2 = Rect2(qrec.x-qrec.w/2,qrec.y-qrec.h/2,qrec.w,qrec.h)
	draw_rect(r2,Color.GREEN,false,2)
	for p in qu_points:
		var v = Vector2(p.x,p.y)
		draw_circle(v,5,Color.GREEN)
	draw_circle(mp,2,Color.WHITE)
	

func _input(event):
	if event is InputEventMouseMotion:
		mp = event.position
		#simple timer to decrease the rapidness of spawn on drag
		if insert_timer <= 0 and drag_mode:
			add_points()
			insert_timer = 5
		insert_timer -=1
		#print(mp)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			add_points()
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			get_tree().reload_current_scene()

func _on_HSlider_value_changed(value):
	qrec.set_size(value,value)

#Enable moving the move to constantly create points
func _on_drag_mode_toggled(button_pressed):
	drag_mode = button_pressed

func _on_Clear_reset_pressed():
	QuadTreeGlobals.points_to_spawn = 0
	get_tree().reload_current_scene()

#Increase the amount of children each cell should contain before passing them on to subdivisions
func _on_cellcap_slider_value_changed(value):
	QuadTreeGlobals.quad_capacity = value
	$cap.text = str(QuadTreeGlobals.quad_capacity)

#WARNING These functions is recursive i.e add to whats already in the scene
func _on_spawn_10k_pressed():
	add_random_points(10000)

func _on_spawn_50k_pressed():
	add_random_points(50000)

func _on_spawn_5k_pressed():
	add_random_points(5000)
