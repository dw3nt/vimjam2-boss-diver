extends Control

signal main_menu_pressed


func _on_MainMenuButton_pressed():
	emit_signal("main_menu_pressed")


func _on_Applause_SoundPackLink_pressed():
	OS.shell_open("https://opengameart.org/content/applause-in-a-large-hall-or-church")


func _on_Applause_AuthorLink_pressed():
	OS.shell_open("https://opengameart.org/users/expl0it3r")


func _on_Applause_LicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/publicdomain/zero/1.0/legalcode")


func _on_Splash_SoundPackLink_pressed():
	OS.shell_open("https://opengameart.org/content/water-splashes")


func _on_Splash_AuthorLink_pressed():
	OS.shell_open("https://freesound.org/people/Michel88/")


func _on_Splash_LicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/licenses/by/3.0/legalcode")


func _on_WaterSplashSlime_SoundPackLink_pressed():
	OS.shell_open("https://opengameart.org/content/40-cc0-water-splash-slime-sfx")


func _on_WaterSplashSlime_AuthorLink_pressed():
	OS.shell_open("https://opengameart.org/users/rubberduck")


func _on_WaterSplashSlime_LicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/publicdomain/zero/1.0/legalcode")


func _on_Swoosh_SoundPackLink_pressed():
	OS.shell_open("https://opengameart.org/content/swish-bamboo-stick-weapon-swhoshes")


func _on_Swoosh_AuthorLink_pressed():
	OS.shell_open("https://opengameart.org/users/qubodup")


func _on_Swoosh_LicenseLink_pressed():
	OS.shell_open("https://creativecommons.org/publicdomain/zero/1.0/legalcode")
