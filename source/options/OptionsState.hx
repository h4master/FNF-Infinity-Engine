package options;

import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;

class OptionsState extends MusicBeatState
{
    public function new()
    {
        super();

        var bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        openSubState(new options.OptionsSubState());
    }
}
