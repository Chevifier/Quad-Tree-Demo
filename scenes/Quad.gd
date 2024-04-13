class_name QuadTree #None Node version WIP

var boundary = Rectangle.new()
var capacity = QuadTreeGlobals.quad_capacity
var points = []
var divided = false
var northwest
var northeast
var southwest
var southeast

func init():
	pass

func _process(delta):
	if points.size() > 0:
		pass
#create 4 new quadant i.e leaves
func subdivide():
	var r = boundary
	var nw = Rectangle.new()
	nw.setRect(r.x-r.w/4,r.y - r.h/4, r.w/2,r.h/2)
	northwest = QuadTree.new()
	northwest.boundary = nw
	var ne = Rectangle.new() 
	ne.setRect(r.x + r.w/4,r.y + r.h/4, r.w/2,r.h/2)
	northeast = QuadTree.new()
	northeast.boundary = ne
	var sw = Rectangle.new() 
	sw.setRect(r.x - r.w/4,r.y + r.h/4, r.w/2,r.h/2)
	southwest = QuadTree.new()
	southwest.boundary = sw
	var se = Rectangle.new()
	se.setRect(r.x + r.w/4,r.y - r.h/4, r.w/2,r.h/2)
	southeast = QuadTree.new()
	southeast.boundary = se
	divided = true

#Insert a new point to the cell
func insert(point):
	if boundary.contains(point) == false:
		return
	if points.size() < capacity:
		points.append(point)
		#QuadTreeGlobals.total +=1
	else:
		if divided == false:
			subdivide()
			divided = true
		if northeast.insert(point): return true
		if northwest.insert(point): return true
		if southeast.insert(point): return true
		if southwest.insert(point): return true

	return false

#Find points within range
func query(_range:Rectangle,found):
	
	#Abort if the range does not intersect this quad
	if !boundary.intersects(_range):
		return found;
	#check objects at this quad level
	for p in points:
			if _range.contains(p):
				found.append(p)
	
	#Terminate here if there is no children
	if northwest == null:
		return found
	
	#otherwise add points from children
	northwest.query(_range,found)
	northeast.query(_range,found)
	southwest.query(_range,found)
	southeast.query(_range,found)
	return found

func unsubdivide():
	if divided:
		northwest = null
		northeast = null
		southwest = null
		southwest = null
		divided = false

#pass draw objects to a main manager
func send_draw_data():
	var data = {}
	data["rect"] = get_rect()
	data["points"] = get_points()

#convert Rectangles to godot Rects
func get_rect():
	var r0 = Rect2(boundary.x-boundary.w/2,boundary.y-boundary.h/2,boundary.w,boundary.h)
	return r0

#convert points to Godot Vector2s
func get_points():
	var ps = []
	for p in points:
		var v = Vector2(p.x,p.y)
		ps.append(v)
	return ps
