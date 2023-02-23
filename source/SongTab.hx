package;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

class SongTab extends FlxTypedGroup<FlxBasic>
{
    public function new(color:FlxColor, songName:String)
    {
        super();
        
        var tag = new FlxSprite(-320, 15).makeGraphic(315, 100, color);
        tag.cameras = [PlayState.instance.camOther];
        add(tag);

        var tab = new FlxSprite(-320, 15).makeGraphic(300, 100, FlxColor.BLACK);
        tab.cameras = [PlayState.instance.camOther];
        add(tab);

        var text = new FlxText(-320, 30, 300, "Now Playing:", 30);
        text.setFormat(Paths.font("vcr.ttf"), 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.borderSize = 2;
        text.cameras = [PlayState.instance.camOther];
        add(text);

        var subtext = new FlxText(-320, 60, 300, PlayState.SONG.song, 30);
        subtext.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        subtext.borderSize = 2;
        subtext.cameras = [PlayState.instance.camOther];
        add(subtext);

        FlxTween.tween(tag, {x: 0}, 1, {ease: FlxEase.circInOut});
        FlxTween.tween(tab, {x: 0}, 1, {ease: FlxEase.circInOut, startDelay: 0.1});
        FlxTween.tween(text, {x: 0}, 1, {ease: FlxEase.circInOut, startDelay: 0.1});
        FlxTween.tween(subtext, {x: 0}, 1, {ease: FlxEase.circInOut, startDelay: 0.1});

        new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            FlxTween.tween(tag, {x: -450}, 1.5, {ease: FlxEase.circInOut, startDelay: 0.5, onComplete: function(twn:FlxTween)
            {
                new FlxTimer().start(1.5, function(tmr:FlxTimer) {
                    clear();
                });
            }});
            FlxTween.tween(tab, {x: -450}, 1.5, {ease: FlxEase.circInOut});
            FlxTween.tween(text, {x: -450}, 1.5, {ease: FlxEase.circInOut});
            FlxTween.tween(subtext, {x: -450}, 1.5, {ease: FlxEase.circInOut});
        });

        if (!ClientPrefs.songTab) clear();
    }
}