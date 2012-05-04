package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class MyCursor extends Sprite
	{
		[Embed(source='cursor.png')]
		private const cursor:Class;
		
		public var user:Object;
		public var destX:uint = 0;
		public var destY:uint = 0;
		
		public function MyCursor()
		{
			addChild(new cursor());
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void{
			x -= (x-destX)*0.2;
			y -= (y-destY)*0.2;
		}
		
	}
}