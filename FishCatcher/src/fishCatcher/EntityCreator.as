package fishCatcher
{
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.core.Game;

	public class EntityCreator
	{
		private var game:Game;
		
		public function EntityCreator(game:Game)
		{
			this.game = game;
		}
		
		public function destroyEntity( entity : Entity ) : void
		{
			game.removeEntity( entity );
		}
	}
}