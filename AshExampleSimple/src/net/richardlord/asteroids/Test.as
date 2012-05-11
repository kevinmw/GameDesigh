package net.richardlord.asteroids
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import net.richardlord.input.KeyPoll;
	
	public class Test extends Sprite {
		private var key:KeyPoll;
		
		public function Test() {
			key = new KeyPoll( this.stage );
			addEventListener( Event.ENTER_FRAME, enterFrame );
		}
		
		public function enterFrame( ev:Event ):void {
			if( key.isDown( Keyboard.LEFT ) ) {
				trace( "left down" );
			}
			if( key.isDown( Keyboard.RIGHT ) ) {
				trace( "right down" );
			}
		}
	}
}