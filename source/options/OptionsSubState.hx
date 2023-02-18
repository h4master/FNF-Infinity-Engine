package options;

import flixel.FlxSprite;

class OptionsSubState extends MusicBeatSubstate
{
    public static var inCatas:Bool = true;
    public static var inPause:Bool = false;

    public function new(pause:Bool = false)
    {
        super();
        inPause = pause;
    }

    override function create()
    {
    }
}