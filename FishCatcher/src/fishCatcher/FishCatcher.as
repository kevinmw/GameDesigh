package fishCatcher
{
	import fishCatcher.components.GameState;
	
	import flash.display.DisplayObjectContainer;
	
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.input.KeyPoll;

	public class FishCatcher
	{
		private var container : DisplayObjectContainer;
		private var game : Game;
		private var tickProvider : FrameTickProvider;
		private var gameState : GameState;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var width : Number;
		private var height : Number;
		
		public function FishCatcher(container:DisplayObjectContainer, width:Number, height:Number)
		{
			this.container = container;
			this.width = width;
			this.height = height;
			prepare();
		}
		
		private function prepare() : void
		{
			game = new Game();
			gameState = new GameState( width, height );
			creator = new EntityCreator( game );
			keyPoll = new KeyPoll( container.stage );
			
			tickProvider = new FrameTickProvider( container );
		}
		
		public function start() : void
		{
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;
			
			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}