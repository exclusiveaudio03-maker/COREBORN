[gd_scene load_steps=3 format=3]
[node name="PauseMenu" type="CanvasLayer"]
[node name="Resume" type="Button" parent="."]
text = "Resume"
[node name="Settings" type="Button" parent="."]
text = "Settings"
[connection signal="pressed" from="Resume" to="." method="_on_Resume_pressed"]
[connection signal signal="pressed" from="Settings" to="." method="_on_Settings_pressed"]
