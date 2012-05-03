package
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Game2 extends Sprite
	{
		private var sausagesVector:Vector.<Image> = new Vector.<Image>(NUM_SAUSAGES, true);
		private const NUM_SAUSAGES:uint = 400;
		
		public function Game2()
		{
			trace(sausagesVector);
		}
	}
}