package options.catas;

import options.OptionCata;
import options.Option;
import options.OptionsMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;

class ControlsCata extends OptionCata
{
    public function new(x:Float)
    {
        title = "Controls";
		middle = true;
        
		options = [
			new LeftBindOption("The left keybind."),
			new DownBindOption("The down keybind."),
			new UpBindOption("The up keybind."),
			new RightBindOption("The right keybind."),

			new ResetBindOption("The reset keybind."),
			new AcceptBindOption("The accept keybind."),
			new BackBindOption("The back keybind."),
			new PauseBindOption("The pause keybind."),

			new VolumeMuteBindOption("The volume mute keybind."),
			new VolumeUpBindOption("The volume up keybind."),
			new VolumeDownBindOption("The volume down keybind."),

			new DebugOneBindOption("The debug 1 keybind."),
			new DebugTwoBindOption("The debug 2 keybind."),
		];

        super(x, 40);
    }
}

class LeftBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['note_left'][!alt ? 0 : 1] = FlxKey.fromString(text);
			ClientPrefs.keyBinds['ui_left'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Left${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['note_left'][!alt ? 0 : 1])}';
		else
			return 'Left${alt ? ' ALT' : ''}: > <';
	}
}

class DownBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['note_down'][!alt ? 0 : 1] = FlxKey.fromString(text);
			ClientPrefs.keyBinds['ui_down'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Down${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['note_down'][!alt ? 0 : 1])}';
		else
			return 'Down${alt ? ' ALT' : ''}: > <';
	}
}

class UpBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['note_up'][!alt ? 0 : 1] = FlxKey.fromString(text);
			ClientPrefs.keyBinds['ui_up'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Up${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['note_up'][!alt ? 0 : 1])}';
		else
			return 'Up${alt ? ' ALT' : ''}: > <';
	}
}

class RightBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['note_right'][!alt ? 0 : 1] = FlxKey.fromString(text);
			ClientPrefs.keyBinds['ui_right'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Right${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['note_right'][!alt ? 0 : 1])}';
		else
			return 'Right${alt ? ' ALT' : ''}: > <';
	}
}

class ResetBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['reset'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Reset${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['reset'][!alt ? 0 : 1])}';
		else
			return 'Reset${alt ? ' ALT' : ''}: > <';
	}
}

class AcceptBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['accept'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Accept${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['accept'][!alt ? 0 : 1])}';
		else
			return 'Accept${alt ? ' ALT' : ''}: > <';
	}
}

class BackBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['back'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Back${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['back'][!alt ? 0 : 1])}';
		else
			return 'Back${alt ? ' ALT' : ''}: > <';
	}
}

class PauseBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['pause'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Pause${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['pause'][!alt ? 0 : 1])}';
		else
			return 'Pause${alt ? ' ALT' : ''}: > <';
	}
}

class VolumeMuteBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['volume_mute'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Volume Mute${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['volume_mute'][!alt ? 0 : 1])}';
		else
			return 'Volume Mute${alt ? ' ALT' : ''}: > <';
	}
}

class VolumeUpBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['volume_up'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Volume Up${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['volume_up'][!alt ? 0 : 1])}';
		else
			return 'Volume Up${alt ? ' ALT' : ''}: > <';
	}
}

class VolumeDownBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['volume_down'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Volume Down${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['volume_down'][!alt ? 0 : 1])}';
		else
			return 'Volume Down${alt ? ' ALT' : ''}: > <';
	}
}

class DebugOneBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['debug_1'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Debug Key 1${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['debug_1'][!alt ? 0 : 1])}';
		else
			return 'Debug Key 1${alt ? ' ALT' : ''}: > <';
	}
}

class DebugTwoBindOption extends Option
{
	var alt:Bool = false;
	
	public function new(desc:String) {
		super();
		description = desc;
		acceptType = true;
	}

	override function press():Bool {
		waitingType = !waitingType;
		return true;
	}

	override function left():Bool {
		if (!waitingType)
			alt = !alt;
		return true;
	}

	override function right():Bool {
		left();
		return true;
	}

	override function onType(text:String) {
		if (waitingType)
		{
			ClientPrefs.keyBinds['debug_2'][!alt ? 0 : 1] = FlxKey.fromString(text);
			waitingType = false;
		}
	}

	override function updateDisplay():String {
		if (!waitingType)
			return 'Debug Key 2${alt ? ' ALT' : ''}: ${Std.string(ClientPrefs.keyBinds['debug_2'][!alt ? 0 : 1])}';
		else
			return 'Debug Key 2${alt ? ' ALT' : ''}: > <';
	}
}