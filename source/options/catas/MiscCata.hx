package options.catas;

import options.OptionCata;
import options.Option;
import options.OptionsMenu;

class MiscCata extends OptionCata
{
    public function new(x:Float)
    {
        title = "Misc";
        
        options = [
            new FPSOption("Toggle the FPS Counter."),
            new MemOption("Toggle the Memory Counter."),
            new WatermarkOption("Toggle the Watermark."),
            new InfoOutlineOption("Toggle the debug info outline.")
        ];

        super(x, 40);
    }
}

class FPSOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc;
    }

    override function press():Bool {
        ClientPrefs.showFPS = !ClientPrefs.showFPS;
        return true;
    }

    override function updateDisplay():String {
        return 'FPS Counter: ${ClientPrefs.showFPS ? 'Enabled' : 'Disabled'}';
    }
}

class MemOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc + " (Cannot be toggled with the Info Outline enabled)";
    }

    override function press():Bool {
        ClientPrefs.showMem = !ClientPrefs.showMem;
        return true;
    }

    override function updateDisplay():String {
        return 'Memory Counter: ${ClientPrefs.showMem ? 'Enabled' : 'Disabled'}';
    }
}

class WatermarkOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc;
    }

    override function press():Bool {
        ClientPrefs.showWM = !ClientPrefs.showWM;
        return true;
    }

    override function updateDisplay():String {
        return 'Watermark: ${ClientPrefs.showWM ? 'Enabled' : 'Disabled'}';
    }
}

class InfoOutlineOption extends Option
{
    public function new(desc:String) {
        super();
        description = desc + " (Cannot be toggled with the Memory Counter enabled)";
    }

    override function press():Bool {
        ClientPrefs.outlineFPS = !ClientPrefs.outlineFPS;
        return true;
    }

    override function updateDisplay():String {
        return 'Info Outline: ${ClientPrefs.outlineFPS ? 'Enabled' : 'Disabled'}';
    }
}