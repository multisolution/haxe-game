package;

class Data
{
	static private var _score: Int = 0;
	static private var _highScore: Int = 0;

	static public function score()
	{
		return _score;
	}

	static public function incScore()
	{
		_score += 1;
	}

	static public function highScore()
	{
		return _highScore;
	}

	static public function setHighScore(value: Int)
	{
		_highScore = value;
	}

	static public function resetScore()
	{
		_score = 0;
	}
}
