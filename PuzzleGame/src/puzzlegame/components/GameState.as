package puzzlegame.components
{
	/**
	 * 
	 * @author Administrator
	 * 
	 */	
	public class GameState
	{
		public var times:int = 0;
		public var level:int = 0;
		public var points:int = 0;
		public var width:int = 0;
		public var height:int = 0;
		
		public function GameState(width:int = 0, height:int = 0 )
		{
			this.width = width;
			this.height = height;
		}
	}
}
