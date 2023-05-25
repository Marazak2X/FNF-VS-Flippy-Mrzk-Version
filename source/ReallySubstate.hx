import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class ReallySubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];
	var mustPress:Bool = false;
	var onYes:Bool = false;
	var yesText:Alphabet;
	var noText:Alphabet;

	// Week -1 = Freeplay
	public function new()
	{
		super();
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		bg.cameras = [PlayState.instance.camOther];
		add(bg);

		var text:Alphabet = new Alphabet(0, 180, "Do you really want\n to go to the menu", true);
		text.screenCenter(X);
		text.scrollFactor.set();
		alphabetArray.push(text);
		text.cameras = [PlayState.instance.camOther];
		text.alpha = 0;
		add(text);

		yesText = new Alphabet(0, text.y + 200, 'Yes', true);
		yesText.screenCenter(X);
		yesText.scrollFactor.set();
		yesText.x -= 200;
		yesText.cameras = [PlayState.instance.camOther];
		add(yesText);
		noText = new Alphabet(0, text.y + 200, 'No', true);
		noText.screenCenter(X);
		noText.scrollFactor.set();
		noText.x += 200;
		noText.cameras = [PlayState.instance.camOther];
		add(noText);

		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			mustPress = true;
		});

		updateOptions();
	}

	override function update(elapsed:Float)
	{
		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}

		if(mustPress)
		{
			if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 1);
				onYes = !onYes;
				updateOptions();
			}
			if(controls.BACK) {
				FlxG.sound.play(Paths.sound('cancelMenu'), 1);
				close();
			} else if(controls.ACCEPT) {
				if(onYes) {
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
	
					WeekData.loadTheFirstEnabledMod();
					if(PlayState.isStoryMode) {
						MusicBeatState.switchState(new StoryMenuState());
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
					} else {
						MusicBeatState.switchState(new FreeplayState());
						FlxG.sound.music.stop();
					}
					PlayState.cancelMusicFadeTween();
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
				} else {
					close();
					FlxG.sound.play(Paths.sound('cancelMenu'), 1);
				}
			}
		}
		super.update(elapsed);
	}

    function updateOptions() {
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		noText.alpha = alphas[1 - confirmInt];
	}
}