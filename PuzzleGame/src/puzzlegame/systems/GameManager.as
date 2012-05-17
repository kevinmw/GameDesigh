package puzzlegame.systems
{
	import net.richardlord.ash.core.System;
	
	import puzzlegame.components.GameState;
	
	public class GameManager extends System
	{
		[Inject]
		public var gameState:GameState;
		
		override public function update(time:Number):void
		{
			
		}
	}
}