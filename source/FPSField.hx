package;

import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Lib;

#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end

#if openfl
import openfl.system.System;
#end

class FPSField extends TextField
{
    public var currentFPS(default, null):Int;
    public var rainbow:Bool = false;

    public var bitmap:Bitmap;

	public var show:Bool = true;

    @:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

    var colors:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0, 0)
	];
    var skippedFrames = 0;

	public static var currentColor = 0;

    var fpsLine:String = "";
    var memLine:String = "";
	var waterLine:String = "";
    
    public function new()
    {
        super();
        currentFPS = 0;

        defaultTextFormat = new TextFormat(
			#if desktop
            Paths.font('vcr.ttf'),
			#else
			"_sans",
			#end
            14,
            FlxColor.WHITE
        );
        autoSize = LEFT;
        multiline = true;
		text = "";
        width += 200;

        cacheCount = 0;
		currentTime = 0;
		times = [];

        #if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end

        if (ClientPrefs.outlineFPS)
        {
            bitmap = ImageOutline.renderImage(this, 1, 0x000000, 1, true);
            (cast(Lib.current.getChildAt(0), Main)).addChild(bitmap);
        }
    }

	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentFPS > ClientPrefs.framerate) currentFPS = ClientPrefs.framerate;

		if (currentCount != cacheCount /*&& visible*/)
		{
			if (ClientPrefs.showFPS)
				fpsLine = 'FPS: $currentFPS \n';
			else
				fpsLine = "";

			if (ClientPrefs.showWM)
				waterLine = 'Infinity v${Main.game.version} \n';
			else
				waterLine = "";

			textColor = 0xFFFFFFFF;

            text = fpsLine + memLine + waterLine;

			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end
		}

		cacheCount = currentCount;

        Main.instance.removeChild(bitmap);
        visible = true;

        if (ClientPrefs.outlineFPS)
        {
			this.x = 8;
			this.y = 1;

            text = fpsLine + memLine + waterLine;
            bitmap = ImageOutline.renderImage(this, 2, 0x000000, 1);
            Main.instance.addChild(bitmap);
            visible = false;
        }
		else
		{
			this.x = 10;
			this.y = 3;
		}

		var memoryMegas:Float = 0;
		#if openfl
		memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 0));
		if (ClientPrefs.showMem)
			memLine = 'Memory: $memoryMegas MB \n';
		else
			memLine = "";
		#end
	}
}
