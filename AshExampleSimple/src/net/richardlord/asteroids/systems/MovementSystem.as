package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.MovementNode;

	public class MovementSystem extends ListIteratingSystem
	{
		
		private var gameState : GameState;
		
		public function MovementSystem( gameState : GameState)
		{
			this.gameState = gameState;
			
			super( MovementNode, updateNode );
		}

		private function updateNode( node : MovementNode, time : Number ) : void
		{
			var position : Position = node.position;
			var motion : Motion = node.motion;

			position = node.position;
			motion = node.motion;
			position.position.x += motion.velocity.x * time;
			position.position.y += motion.velocity.y * time;
			if ( position.position.x < 0 )
			{
				position.position.x += gameState.width;
			}
			if ( position.position.x > gameState.width )
			{
				position.position.x -= gameState.width;
			}
			if ( position.position.y < 0 )
			{
				position.position.y += gameState.height;
			}
			if ( position.position.y > gameState.height )
			{
				position.position.y -= gameState.height;
			}
			position.rotation += motion.angularVelocity * time;
			if ( motion.damping > 0 )
			{
				var xDamp : Number = Math.abs( Math.cos( position.rotation ) * motion.damping * time );
				var yDamp : Number = Math.abs( Math.sin( position.rotation ) * motion.damping * time );
				if ( motion.velocity.x > xDamp )
				{
					motion.velocity.x -= xDamp;
				}
				else if ( motion.velocity.x < -xDamp )
				{
					motion.velocity.x += xDamp;
				}
				else
				{
					motion.velocity.x = 0;
				}
				if ( motion.velocity.y > yDamp )
				{
					motion.velocity.y -= yDamp;
				}
				else if ( motion.velocity.y < -yDamp )
				{
					motion.velocity.y += yDamp;
				}
				else
				{
					motion.velocity.y = 0;
				}
			}
		}
	}
}
