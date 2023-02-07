package;

import Song.SwagSong;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxSprite;

class EternalFunctions
{
    public static function getSong(file:String, ?folder:String = null):SwagSong
    {
        var retVal:SwagSong = null;
        
        var song:String = Paths.formatToSongPath(PlayState.SONG.song);
        if (folder != null)
            song = folder;
        if (OpenFlAssets.exists(Paths.json(song + '/' + file)))
            retVal = Song.loadFromJson(file, song);

        return retVal;
    }

    public static function readData(file:String):String
    {
        var retVal:String = "";

        if (OpenFlAssets.exists(Paths.txt(file)))
            retVal = Assets.getText(Paths.txt(file));

        return retVal;
    }

    // Stage Editor stuff
    public static function writeLuaScript(sprite:FlxSprite, tag:String, tex:String, order:Int, isFinal:Bool = false):String
    {
        var retVal:String = "function onCreatePost() \n";
        retVal += addStringsToLuaScript(sprite, tag, tex, isFinal);
        if (isFinal)
            retVal += endLuaScript();
        return retVal;
    }

    public static function addStringsToLuaScript(sprite:FlxSprite, tag:String, tex:String, order:Int = 0, isFinal:Bool = false):String
    {
        var retVal:String = "";

        retVal += "makeLuaSprite('" + tag + "','" + tex + "'," + sprite.x + "," + sprite.y + ") \n";
        retVal += "setProperty('" + tag + ".alpha'," + sprite.alpha + ") \n";
        if (!sprite.antialiasing && ClientPrefs.globalAntialiasing)
            retVal += "setProperty('" + tag + "'," + "false) \n";
        else if (sprite.antialiasing && !ClientPrefs.globalAntialiasing)
            retVal += "setProperty('" + tag + "'," + "true) \n";
        retVal += "setObjectOrder('" + tag + "'," + order + ") \n";
        retVal += "addLuaSprite('" + tag + "') \n";
        if (!isFinal)
            retVal += "\n";
        return retVal;
    }

    public static function endLuaScript():String {
        return "end";
    }
}
