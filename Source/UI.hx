package;

import js.html.Text;
import openfl.display.Sprite;
import openfl.text.TextField;

class UI extends Sprite 
{
	private var score: TextField;
	private var highScore: TextField;
	
	public function new() 
	{
		super();
		
		score = new TextField();
		addChild(score);
		
		highScore = new TextField();
		addChild(highScore);
		
	}
	
	public function update()
	{
		score.text = Data.score();
		
		highScore.text = Data.highScore();
		highScore.x = stage.stageWidth - highScore.width;
	}
}