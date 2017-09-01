package;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

class UI extends Sprite 
{
	private var score: TextField;
	private var highScore: TextField;
	
	public function new() 
	{
		super();
		
		var format: TextFormat = new TextFormat(
			Assets.getFont('fonts/AldotheApache.ttf').fontName,
			40
		);
		
		score = new TextField();
		score.defaultTextFormat = format;
		score.x = 20;
		addChild(score);
		
		highScore = new TextField();
		highScore.defaultTextFormat = format;
		addChild(highScore);
		
	}
	
	public function update()
	{
		score.text = Std.string(Data.score());
		
		highScore.text = Std.string(Data.highScore());
		highScore.x = stage.stageWidth - highScore.textWidth - 20;
	}
}