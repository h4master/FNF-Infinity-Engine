package options.catas;

import options.OptionCata;
import options.Option;
import options.OptionsMenu;

class AppearanceCata extends OptionCata
{
    public function new(x:Float)
    {
        title = "Appearance";
        
        options = [
            new AntialiasingOption("Toggle antialiasing, improving graphics quality at a slight performance penalty."),
            new LowDetailOption("Toggle same background details."),
            new FlashingOption("Toggle flashing lights that can cause epileptic seizures and strain."),
            new ShadersOption("Toggle visual effects, not recommended for a weak computer."),
            new MiddleScrollOption("Put your lane in the center or on the right."),
            new SongTabOption("Toggle song tab on song starting."),
            new OpponentStrumsOption("Toggle the Opponent Strums visible")
        ];

        super(x, 40);
    }
}

class AntialiasingOption extends Option
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
        ClientPrefs.globalAntialiasing = !ClientPrefs.globalAntialiasing;
        return true;
    }

    override function updateDisplay():String {
        return 'Anti-Aliasing: ${ClientPrefs.globalAntialiasing ? 'Enabled' : 'Disabled'}';
    }
}

class LowDetailOption extends Option
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
        ClientPrefs.lowQuality = !ClientPrefs.lowQuality;
        return true;
    }

    override function updateDisplay():String {
        return 'Low Detail Mode: ${ClientPrefs.lowQuality ? 'Enabled' : 'Disabled'}';
    }
}

class FlashingOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc;
    }

    override function press():Bool {
        ClientPrefs.flashing = !ClientPrefs.flashing;
        return true;
    }

    override function updateDisplay():String {
        return 'Flashing Lights: ${ClientPrefs.flashing ? 'Enabled' : 'Disabled'}';
    }
}

class ShadersOption extends Option
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
        ClientPrefs.lowQuality = !ClientPrefs.lowQuality;
        return true;
    }

    override function updateDisplay():String {
        return 'Shaders: ${ClientPrefs.lowQuality ? 'Enabled' : 'Disabled'}';
    }
}

class MiddleScrollOption extends Option
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
        ClientPrefs.middleScroll = !ClientPrefs.middleScroll;
        return true;
    }

    override function updateDisplay():String {
        return 'Middle Scroll: ${ClientPrefs.middleScroll ? 'Enabled' : 'Disabled'}';
    }
}

class SongTabOption extends Option
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
        ClientPrefs.songTab = !ClientPrefs.songTab;
        return true;
    }

    override function updateDisplay():String {
        return 'Song Tab: ${ClientPrefs.songTab ? 'Enabled' : 'Disabled'}';
    }
}

class OpponentStrumsOption extends Option
{
    public function new(desc:String) {
        super();
        if (OptionsMenu.isInPause)
            description = "This option cannot be toggled in the pause menu.";
        else
            description = desc;
    }

    override function press():Bool {
        ClientPrefs.opponentStrums = !ClientPrefs.opponentStrums;
        return true;
    }

    override function updateDisplay():String {
        return 'Opponent Strums: ${ClientPrefs.opponentStrums ? 'Enabled' : 'Disabled'}';
    }
}