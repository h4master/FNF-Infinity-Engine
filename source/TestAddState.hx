package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class TestAddState extends MusicBeatAddState
{
    public function new() {
        super();
    }

    override function create()
    {
        var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(bg);
    }
}