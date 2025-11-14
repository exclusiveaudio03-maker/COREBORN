[gd_scene load_steps=3 format=3]

[node name="MainMenu" type="CanvasLayer"]
[node name="VBox" type="VBoxContainer" parent="."]
margin_left = 20; margin_top = 20

[node name="Title" type="Label" parent="VBox"]
text = "COREBORN"

[node name="PlayBtn" type="Button" parent="VBox"]
text = "Play"

[node name="SettingsBtn" type="Button" parent="VBox"]
text = "Settings"

[connection signal="pressed" from="VBox/SettingsBtn" to="." method="_on_SettingsBtn_pressed"]
[connection signal="pressed" from="VBox/PlayBtn" to="." method="_on_PlayBtn_pressed"]
