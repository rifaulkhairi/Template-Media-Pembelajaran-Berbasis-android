extends Control


enum tabs {
	Home,
	Materi,
	Kuis
}

var currentTab = 0

#ukuran Graph
var xMin = -5
var xMax = 5
var yMin = -5
var yMax = 5
#ukuran Pixel
var pixelXmin
var pixelXmax
var pixelYmin
var pixelYmax

var dataMateri : Dictionary = {
	"pencerminan":{
		"pencerminanSBX" : {
			"selesai" : false
		}
	}
}

var datKuis : Dictionary = {
	"waktu": "00:00",
	"skor" : 0,
	"jumlahBenar":0,
	"jumlahSalah": 0,
	"statusPengerjaan": "belum",
}

func ubahXcoordTPixel(x, y):
	return Vector2(
			lerp(pixelXmin, pixelXmax, inverse_lerp(xMin, xMax, x)),
			lerp(pixelYmin, pixelYmax, inverse_lerp(yMin, yMax, y))
		)

