package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flash.system.System;

class NotCheatState extends MusicBeatState
{
    var menuBG:FlxSprite;

    override function create()
    {
        menuBG = new FlxSprite().loadGraphic(Paths.image('notCheating','fliqpy'));
        menuBG.scrollFactor.set();
        menuBG.screenCenter();
        menuBG.antialiasing = ClientPrefs.globalAntialiasing;
        add(menuBG);

        var cheatTxt:FlxText = new FlxText(0, 0, 1000, "Not CHEATING", 50);
        cheatTxt.setFormat(Paths.font('vcr.ttf'), 50, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		cheatTxt.scrollFactor.set();
        cheatTxt.screenCenter();
		cheatTxt.borderSize = 1.25;
		add(cheatTxt);

        FlxG.camera.shake(0.00105, 16, function()
        {
            FlxG.camera.shake(0.0015, 19, function()
            {
                FlxG.camera.shake(0.003, 1, function()
                {
                    FlxG.camera.shake(0.0065, 0.5, function()
                    {
                        FlxG.camera.shake(0.0096, 0.5, function()
                        {
                            FlxG.camera.shake(0.017, 0.5, function()
                            {
                                FlxG.camera.shake(0.03, 0.5);
                            });
                        });
                    });
                });
            });
        });

        openfl.Lib.application.window.title = "WHY ARE YOU CHEATING?!?!?!?";

        FlxG.sound.playMusic(Paths.music('cheat','fliqpy'), 1, false);

        new FlxTimer().start(22, function(tmr:FlxTimer)
        {
            closeGame();
        });
    }

    public function closeGame()
	{
		System.exit(0);
	}
}