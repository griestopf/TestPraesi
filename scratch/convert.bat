"C:\Program Files\Blender Foundation\Blender 4.0\blender.exe" --background --python ./export_glb.py -- --input Hausi.blend --output Hausi.glb
copy Hausi.glb ..\godot_viewer\model\model.glb
"C:\Users\chris\Documents\_DEV\Godot\v4.2.1\Godot_v4.2.1-stable_win64.exe" ..\godot_viewer\project.godot --export-release Web ..\godot_viewer\Export\Web\index.html --headless