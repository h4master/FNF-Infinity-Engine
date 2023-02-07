package editors;

import flixel.FlxG;
import flixel.FlxPointer;
import flixel.FlxCamera;

// I'm too lazy for that

class StageEditorState extends MusicBeatState
{
    var mouse:FlxPointer;

    var camStage:FlxCamera;
    var camEditor:FlxCamera;

    override function create()
    {
        camEditor = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camMenu = new FlxCamera();
		camMenu.bgColor.alpha = 0;

		FlxG.cameras.reset(camEditor);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camMenu, false);
		FlxG.cameras.setDefaultDrawTarget(camEditor, true);

        camStage = new FlxCamera();
        camEditor = new FlxCamera();
        camEditor.bgColor.alpha = 0;
        FlxG.cameras.reset(camStage);
        FlxG.cameras.add(camEditor, false);
        FlxG.cameras/setDefaultDrawTarget(camStage, true);
    }
    
    override function update(elapsed:Float)
    {
        mouse.x = 
    }
}