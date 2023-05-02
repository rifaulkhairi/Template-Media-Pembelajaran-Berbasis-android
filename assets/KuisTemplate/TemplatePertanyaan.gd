extends MarginContainer
tool
class_name Pertanyaan

enum PilihanJawaban {
	A,
	B,
	C,
	D
}

enum Kolom {
	satu, dua, empat
}

export(String) var pertanyaanString setget setPertanyaanString
export(StreamTexture) var gambarPertanyaan setget setGambarPertanyaan
export(PilihanJawaban) var JawabanBetul = 1 setget setJawabanBetul
export(Kolom) var jumlahKolom = Kolom.satu setget setjumlahKolom
export(StreamTexture) var jawabanA setget setTextureJA
export(StreamTexture) var jawabanB setget setTextureJB
export(StreamTexture) var jawabanC setget setTextureJC
export(StreamTexture) var jawabanD setget setTextureJD

onready var optionContainerMC : MarginContainer = $VBoxContainer/OptionConteinerMC
onready var optionContainerGC : GridContainer = $VBoxContainer/OptionConteinerMC/GridContainer
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var tween : Tween = $Tween



onready var pilihanAPB = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanA/ProgressBar
onready var pilihanBPB = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanB/ProgressBar
onready var pilihanCPB = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanC/ProgressBar
onready var pilihanDPB = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanD/ProgressBar

onready var pertanyaanLB = $VBoxContainer/MarginContainer/VBoxContainer/Label

onready var pertanyaanTR : TextureRect = $VBoxContainer/MarginContainer/VBoxContainer/TextureRect
onready var pilihanATR : TextureRect = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanA/HBoxContainer/TextureRect
onready var pilihanBTR : TextureRect = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanB/HBoxContainer/TextureRect
onready var pilihanCTR : TextureRect = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanC/HBoxContainer/TextureRect
onready var pilihanDTR : TextureRect = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanD/HBoxContainer/TextureRect


var pilihanJawabanUser = null
var optionContainerSkala = 0
var currentPilihanNode = null
var skor = 0

var parent = null
var nodeIndikator = null

signal pertanyaanDijawab(nilai)

func _ready() -> void:
	self.rect_pivot_offset = rect_size/2
	self.rect_scale = Vector2(0.8, 0.8)
	connect("resized", self, "_on_TemplatePertanyaan_resized")
	if parent:
		connect("pertanyaanDijawab", parent, "pertanyaanDijawab")
		
		
	pilihanATR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanA/HBoxContainer/TextureRect
	pilihanBTR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanB/HBoxContainer/TextureRect
	pilihanCTR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanC/HBoxContainer/TextureRect
	pilihanDTR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanD/HBoxContainer/TextureRect

	
	optionContainerSkala = optionContainerMC.rect_size.y/optionContainerMC.rect_size.x
	show()
	
func show():
	$tweenShow.interpolate_property(self, "rect_scale", Vector2(0.8, 0.8), Vector2(1, 1), 0.3, Tween.TRANS_BACK, Tween.EASE_OUT)
	$tweenShow.start()
func setjumlahKolom(kolom):
	jumlahKolom = kolom

func setGambarPertanyaan(newGambar):
	gambarPertanyaan = newGambar
	if pertanyaanTR != null:
		pertanyaanTR.texture = gambarPertanyaan
	
func setJawabanBetul(newJawaban):
	JawabanBetul = newJawaban

func setTextureJA(texture) -> void:
	pilihanATR =  $VBoxContainer/OptionConteinerMC/GridContainer/PilihanA/HBoxContainer/TextureRect
	pilihanATR.texture = texture

func setTextureJB(texture) -> void:
	pilihanBTR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanB/HBoxContainer/TextureRect
	pilihanBTR.texture = texture

func setTextureJC(texture) -> void:
	pilihanCTR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanC/HBoxContainer/TextureRect
	pilihanCTR.texture = texture

func setTextureJD(texture) -> void:
	pilihanDTR = $VBoxContainer/OptionConteinerMC/GridContainer/PilihanD/HBoxContainer/TextureRect
	pilihanDTR.texture = texture
	
func setPertanyaanString(newPertanyaan):
	pertanyaanString = newPertanyaan
	if pertanyaanLB != null:
		pertanyaanLB.text = pertanyaanString

	

func cekJawaban() -> void:
	skor = 0
	#sembunyikan jawaban selain jawaban yang dipilih
	for i in optionContainerGC.get_children():
		if i.get_index() == pilihanJawabanUser:
			currentPilihanNode = i
			i.modulate = Color(1, 1, 1, 1)
			var progressBarNode = i.get_node("ProgressBar")
			progressBarNode.visible = true
			animasiCekJawaban(progressBarNode)
			if pilihanJawabanUser == JawabanBetul:
				skor = 1
			else:
				skor = 0
		
		else:
			i.modulate = Color(1, 1, 1, 0)
			var progressBarNode = i.get_node("ProgressBar")
			i.get_child(0).disabled = true
			progressBarNode. visible = false
			animasiCekJawaban(progressBarNode)
			
func animasiCekJawaban(progressBar : ProgressBar):
	tween.interpolate_property(progressBar, "value", 0, 100, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	pass
	

func _on_ButtonA_pressed() -> void:
	pilihanJawabanUser = PilihanJawaban.A
	cekJawaban()
	pass # Replace with function body.


func _on_ButtonB_pressed() -> void:
	pilihanJawabanUser = PilihanJawaban.B
	cekJawaban()
	pass # Replace with function body.


func _on_ButtonC_pressed() -> void:
	pilihanJawabanUser = PilihanJawaban.C
	cekJawaban()
	pass # Replace with function body.


func _on_ButtonD_pressed() -> void:
	pilihanJawabanUser = PilihanJawaban.D
	cekJawaban()
	pass # Replace with function body.


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	pass
		
	


func _on_TemplatePertanyaan_resized() -> void:
	yield(get_tree(), "idle_frame")
	optionContainerSkala = optionContainerMC.rect_size.y/optionContainerMC.rect_size.x
	if jumlahKolom == Kolom.satu:
		optionContainerGC.columns = 1
	elif jumlahKolom > Kolom.satu and jumlahKolom <= Kolom.dua:
		if optionContainerSkala < 0.4:
			optionContainerGC.columns = 2
		else:
			optionContainerGC.columns = 1
	else:
		if optionContainerSkala > 0.25  and optionContainerSkala < 0.4:
			optionContainerGC.columns = 2
		elif optionContainerSkala > 0.1 and optionContainerSkala < 0.25:
			optionContainerGC.columns = 4
		else:
			optionContainerGC.columns = 1
			
	rect_pivot_offset = rect_size/2
	



func _on_Tween_tween_all_completed():
	if pilihanJawabanUser == JawabanBetul:
		currentPilihanNode.get_node("Benar").visible = true
		animationPlayer.play("benar")
	else:
		currentPilihanNode.get_node("Salah").visible = true
		animationPlayer.play("salah")
	emit_signal("pertanyaanDijawab", skor)
	pass # Replace with function body.
