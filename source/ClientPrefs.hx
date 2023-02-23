package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs {
	public static var downScroll:Bool = false;
	public static var middleScroll:Bool = false;
	public static var opponentStrums:Bool = true;
	public static var showFPS:Bool = true;
	public static var showMem:Bool = true;
	public static var showWM:Bool = false;
	public static var outlineFPS:Bool = false;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = true;
	public static var lowQuality:Bool = false;
	public static var shaders:Bool = true;
	public static var framerate:Int = 60;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var ghostTapping:Bool = true;
	public static var timeBarType:String = 'Time Left';
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var songTab:Bool = true;
	public static var controllerMode:Bool = false;
	public static var hitsoundVolume:Float = 0;
	public static var pauseMusic:String = 'Tea Time';
	public static var checkForUpdates:Bool = true;
	public static var comboStacking = true;
	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false
	];

	public static var comboOffset:Array<Int> = [0, 0, 0, 0];
	public static var ratingOffset:Int = 0;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;
	public static var safeFrames:Float = 10;

	//Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],
		
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
		//trace(defaultKeys);
	}

	public static function saveSettings() {
		Paths.save.data.downScroll = downScroll;
		Paths.save.data.middleScroll = middleScroll;
		Paths.save.data.opponentStrums = opponentStrums;
		Paths.save.data.showFPS = showFPS;
		Paths.save.data.showMem = showMem;
		Paths.save.data.showWM = showWM;
		Paths.save.data.outlineFPS = outlineFPS;
		Paths.save.data.flashing = flashing;
		Paths.save.data.globalAntialiasing = globalAntialiasing;
		Paths.save.data.noteSplashes = noteSplashes;
		Paths.save.data.lowQuality = lowQuality;
		Paths.save.data.shaders = shaders;
		Paths.save.data.framerate = framerate;
		//Paths.save.data.cursing = cursing;
		//Paths.save.data.violence = violence;
		Paths.save.data.camZooms = camZooms;
		Paths.save.data.noteOffset = noteOffset;
		Paths.save.data.hideHud = hideHud;
		Paths.save.data.arrowHSV = arrowHSV;
		Paths.save.data.ghostTapping = ghostTapping;
		Paths.save.data.timeBarType = timeBarType;
		Paths.save.data.scoreZoom = scoreZoom;
		Paths.save.data.noReset = noReset;
		Paths.save.data.healthBarAlpha = healthBarAlpha;
		Paths.save.data.songTab = songTab;
		Paths.save.data.comboOffset = comboOffset;
		Paths.save.data.achievementsMap = Achievements.achievementsMap;
		Paths.save.data.henchmenDeath = Achievements.henchmenDeath;

		Paths.save.data.ratingOffset = ratingOffset;
		Paths.save.data.sickWindow = sickWindow;
		Paths.save.data.goodWindow = goodWindow;
		Paths.save.data.badWindow = badWindow;
		Paths.save.data.safeFrames = safeFrames;
		Paths.save.data.gameplaySettings = gameplaySettings;
		Paths.save.data.controllerMode = controllerMode;
		Paths.save.data.hitsoundVolume = hitsoundVolume;
		Paths.save.data.pauseMusic = pauseMusic;
		Paths.save.data.checkForUpdates = checkForUpdates;
		Paths.save.data.comboStacking = comboStacking;

		Paths.save.data.customControls = keyBinds;
	
		Paths.save.flush();
	}

	public static function loadPrefs() {
		if(Paths.save.data.downScroll != null)
			downScroll = Paths.save.data.downScroll;
		if(Paths.save.data.middleScroll != null)
			middleScroll = Paths.save.data.middleScroll;
		if(Paths.save.data.opponentStrums != null)
			opponentStrums = Paths.save.data.opponentStrums;
		if(Paths.save.data.showFPS != null)
			showFPS = Paths.save.data.showFPS;
		if (Paths.save.data.showMem != null)
			showMem = Paths.save.data.showMem;
		if (Paths.save.data.showWM != null)
			showWM = Paths.save.data.showWM;
		if(Paths.save.data.outlineFPS != null)
			outlineFPS = Paths.save.data.outlineFPS;
		if(Paths.save.data.flashing != null)
			flashing = Paths.save.data.flashing;
		if(Paths.save.data.globalAntialiasing != null)
			globalAntialiasing = Paths.save.data.globalAntialiasing;
		if(Paths.save.data.noteSplashes != null)
			noteSplashes = Paths.save.data.noteSplashes;
		if(Paths.save.data.lowQuality != null)
			lowQuality = Paths.save.data.lowQuality;
		if(Paths.save.data.shaders != null)
			shaders = Paths.save.data.shaders;
		if(Paths.save.data.framerate != null)
		{
			framerate = Paths.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		/*if(FlxG.save.data.cursing != null) {
			cursing = FlxG.save.data.cursing;
		}
		if(FlxG.save.data.violence != null) {
			violence = FlxG.save.data.violence;
		}*/
		if(Paths.save.data.camZooms != null)
			camZooms = Paths.save.data.camZooms;
		if(Paths.save.data.hideHud != null)
			hideHud = Paths.save.data.hideHud;
		if(Paths.save.data.noteOffset != null)
			noteOffset = Paths.save.data.noteOffset;
		if(Paths.save.data.arrowHSV != null)
			arrowHSV = Paths.save.data.arrowHSV;
		if(Paths.save.data.ghostTapping != null)
			ghostTapping = Paths.save.data.ghostTapping;
		if(Paths.save.data.timeBarType != null)
			timeBarType = Paths.save.data.timeBarType;
		if(Paths.save.data.scoreZoom != null)
			scoreZoom = Paths.save.data.scoreZoom;
		if(Paths.save.data.noReset != null)
			noReset = Paths.save.data.noReset;
		if(Paths.save.data.healthBarAlpha != null)
			healthBarAlpha = Paths.save.data.healthBarAlpha;
		if(Paths.save.data.songTab != null)
			songTab = Paths.save.data.songTab;
		if(Paths.save.data.comboOffset != null)
			comboOffset = Paths.save.data.comboOffset;
		
		if(Paths.save.data.ratingOffset != null)
			ratingOffset = Paths.save.data.ratingOffset;
		if(Paths.save.data.sickWindow != null)
			sickWindow = Paths.save.data.sickWindow;
		if(Paths.save.data.goodWindow != null)
			goodWindow = Paths.save.data.goodWindow;
		if(Paths.save.data.badWindow != null)
			badWindow = Paths.save.data.badWindow;
		if(Paths.save.data.safeFrames != null)
			safeFrames = Paths.save.data.safeFrames;
		if(Paths.save.data.controllerMode != null)
			controllerMode = Paths.save.data.controllerMode;
		if(Paths.save.data.hitsoundVolume != null)
			hitsoundVolume = Paths.save.data.hitsoundVolume;
		if(Paths.save.data.pauseMusic != null)
			pauseMusic = Paths.save.data.pauseMusic;
		if(Paths.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = Paths.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}
		
		// flixel automatically saves your volume!
		if(Paths.save.data.volume != null)
			FlxG.sound.volume = Paths.save.data.volume;
		if (Paths.save.data.mute != null)
			FlxG.sound.muted = Paths.save.data.mute;
		if (Paths.save.data.checkForUpdates != null)
			checkForUpdates = Paths.save.data.checkForUpdates;
		if (Paths.save.data.comboStacking != null)
			comboStacking = Paths.save.data.comboStacking;

		if (Paths.save.data.customControls != null)
		{
			keyBinds = Paths.save.data.customControls;
			reloadControls();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
