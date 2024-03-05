# Tutorial 4 - Basic 2D Level Design

Name : Felix Tjahyadi

NPM : 2106638614

Godot version : 3.5

# Latihan Mandiri
## Level 2: Slime Rain

Untuk latihan mandiri, saya membuat sebuah level baru yang mana bertemakan sebuah planet yang selalu berada dalam hujan Slime. Dikarenakan level 1 Player memiliki goal untuk menuju roket, pada level 2 goal adalah menuju sebuah safe spot yang telah ditandai dengan sebuah bendera oleh astronot yang datang sebelumnya.

### Langkah Awal
- Buat sebuah scene baru dan save dengan nama Level2
- Set up sebuah Node2D untuk level tersebut
- Kemudian tambahkan player yang sudah dibuat untuk level 1

### Langkah 1: TileMap dan Level Building
- Saya membuat TileMap seperti pada level 1 tetapi untuk level 2 saya menggunakan Snow sebagai ground.
- Saya membuat TileSet lalu satu per satu menambahkan bagian yang diinginkan
- Kemudian saya menambahkan Collision untuk setiap Tile
- Terakhir dalam TileMap saya menyusun level 2 secara sederhana terlebih dahulu dengan jurang
- Berikutnya dilanjutkan dengan pemberian area kemenangan dan kekalahan menggunakan script Area yang sama dengan level 1
- Untuk Area kemenangan saya menggunakan Sprite Bendera dan menandai sekitar bendera tersebut dengan area kemenangan
- Kemudian untuk bagian bawah dari jurang diberi area kekalahan

### Langkah 2: Pembuatan Rintangan
- Untuk rintangan tambahan saya akan menggunakan Slime
- Saya membuat dua jenis Slime untuk level ini, Slime Hijau yang akan menyebabkan Player lose, dan Slime biru yang akan me-reset Player ke awal level 2
- Untuk kedua Slime saya menggunakan RigidBody2D, berikut script untuk kedua slime.

#### Slime Hijau:

```
extends RigidBody2D

export var sceneName = "LoseScreen"

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene(str("res://scenes/" + sceneName + ".tscn"))
```

#### Slime Biru
```
extends RigidBody2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene("res://scenes/Level2.tscn")
```

### Langkah 3: Spawner Set Up
- Langkah terakhir adalah pembuatan spawner pada level tersebut yang mana saya membuat dua jenis spawner. 
- Spawner pertama untuk Slime biru yang akan melakukan spawn secara random dan spawner kedua yang akan spawn di satu tempat untuk Slime Hijau.

#### Spawn 1: Random
```
extends Node2D

export (PackedScene) var obstacle

func _ready():
	repeat()

func spawn():
	var spawned = obstacle.instance()
	get_parent().add_child(spawned)

	var spawn_pos = global_position
	spawn_pos.x = spawn_pos.x + rand_range(-1000, 1000)

	spawned.global_position = spawn_pos

func repeat():
	spawn()
	yield(get_tree().create_timer(1), "timeout")
	repeat()
```
#### Spawn 2: One Place
```
extends Node2D

export (PackedScene) var obstacle

func _ready():
	repeat()

func spawn():
	var spawned = obstacle.instance()
	get_parent().add_child(spawned)

	var spawn_pos = global_position
	spawn_pos.x = spawn_pos.x

	spawned.global_position = spawn_pos

func repeat():
	spawn()
	yield(get_tree().create_timer(4), "timeout")
	repeat()
```
- Kemudian saya men-assign obstacle sesuai spawner dan menaruhnya pada level

Dengan begitu, pembuatan level telah selesai untuk Level 2: Slime Rain