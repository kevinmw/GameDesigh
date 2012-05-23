package puzzlegame.components
{
	/**
	 * 
	 * @author Kevin Ni
	 * 
	 */	
	public class GameState
	{
		public var times:int = 0;
		public var level:int = 0;
		public var blocks:int = 0;
		public var width:int = 0;
		public var height:int = 0;
		
		public function GameState(width:int = 0, height:int = 0 )
		{
			this.width = width;
			this.height = height;
		}
	}
}
