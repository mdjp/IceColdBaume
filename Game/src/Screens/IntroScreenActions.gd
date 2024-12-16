
tool
extends Control

var image1
var starttext
var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var blinkratehole = 0.8;
var blinkratetext = 1;
var timecounthole = 0;
var timecounttext = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.open("/tmp/lightswitch.dat", File.WRITE) != 0:
		print("Error opening file")
		return
	# Save the dictionary as JSON (or whatever you want, JSON is convenient here because it's built-in)
	file.store_line("1")
	file.close()

	image1 = $target_1
	starttext = $RichTextLabel
	_twinkle()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timecounthole += delta
	timecounttext += delta
	if(timecounthole >= blinkratehole):
		timecounthole = 0
		_twinkle()
		
	if(timecounttext >= blinkratetext):
		timecounttext = 0
		starttext.visible = !starttext.visible
		
		
func _twinkle():
	var nodes = [$target_1,$target_2,$target_3,$target_4,$target_5,$target_6,$target_7,$target_8,$target_9,$target_10]
	var random = int(rng.randf_range(0, 9))
	for node in nodes.size():
		nodes[node].visible = false
	nodes[random].visible = true
