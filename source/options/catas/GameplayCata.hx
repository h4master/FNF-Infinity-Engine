package options.catas;

import options.OptionCata;
import options.Option;
import options.OptionsMenu;

class GameplayCata extends OptionCata
{
    public function new(x:Float)
    {
        title = "Gameplay";
        
        options = [
            new DownScrollOption("Toggle making the notes scroll down rather than up."),
            new GhostTapOption("Toggle counting pressing a directional input when no arrow is there as a miss."),
            new HitSoundOption("Change sound volume on note hit."),
            new CamZoomOption("Toggle the camera zoom in-game."),
            new ResetButtonOption("Toggle pressing " + Std.string(ClientPrefs.keyBinds['reset'][0]) + " / " + Std.string(ClientPrefs.keyBinds['reset'][1]) + " to gameover.")
        ];

        super(x, 40);
    }
}

class DownScrollOption extends Option
{
    public function new(desc:String) {
        super();
        if (OptionsMenu.isInPause)
            description = "This option cannot be toggled in the pause menu.";
        else
            description = desc;
    }

    override function press():Bool {
        if (OptionsMenu.isInPause)
            return false;
        ClientPrefs.downScroll = !ClientPrefs.downScroll;
        return true;
    }

    override function updateDisplay():String {
        return 'Down Scroll: ${ClientPrefs.downScroll ? 'Enabled' : 'Disabled'}';
    }
}

class GhostTapOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc;
    }

    override function press():Bool {
        ClientPrefs.ghostTapping = !ClientPrefs.ghostTapping;
        return true;
    }

    override function updateDisplay():String {
        return 'Ghost Tapping: ${ClientPrefs.ghostTapping ? 'Enabled' : 'Disabled'}';
    }
}

class HitSoundOption extends Option
{
    var value:Float;
    
    public function new(desc:String) {
        super();
        description = desc;

        value = ClientPrefs.hitsoundVolume * 100;
    }

    override function left():Bool {
        if (value <= 10 || value < 20)
            value = 0;
        else if (value > 100)
            value = 100;
        else
            value -= 10;

        ClientPrefs.hitsoundVolume = value / 100;
        return true;
    }

    override function right():Bool {
        if (value >= 90 || value > 80)
            value = 100;
        else if (value < 0)
            value = 0;
        else
            value += 10;

        ClientPrefs.hitsoundVolume = value / 100;
        return true;
    }

    override function updateDisplay():String {
        return 'Hit Sound Volume: ${value}%';
    }
}

class CamZoomOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc;
    }

    override function press():Bool {
        ClientPrefs.camZooms = !ClientPrefs.camZooms;
        return true;
    }

    override function updateDisplay():String {
        return 'Camera Zooming: ${ClientPrefs.camZooms ? 'Enabled' : 'Disabled'}';
    }
}

class ResetButtonOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc;
    }

    override function press():Bool {
        ClientPrefs.noReset = !ClientPrefs.noReset;
        return true;
    }

    override function updateDisplay():String {
        return 'Reset Button: ${!ClientPrefs.noReset ? 'Enabled' : 'Disabled'}';
    }
}