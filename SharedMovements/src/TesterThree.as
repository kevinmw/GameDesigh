package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	[SWF (width="900", height="400", frameRate="60", backgroundColor="0x0")]
	public class TesterThree extends Sprite
	{
		private var one:Loader;
		private var two:Loader;
		private var three:Loader;
		
		public function TesterThree()
		{
			one = new Loader();
			one.load(new URLRequest("SharedMovements.swf"), new LoaderContext(false, 
				new ApplicationDomain(ApplicationDomain.currentDomain)));
			addChild(one);
			
			two = new Loader();
			two.load(new URLRequest("SharedMovements.swf"), new LoaderContext(false, 
				new ApplicationDomain(ApplicationDomain.currentDomain)));
			two.x = 300;
			addChild(two);
			
			three = new Loader();
			three.load(new URLRequest("SharedMovements.swf"), new LoaderContext(false, 
				new ApplicationDomain(ApplicationDomain.currentDomain)));
			three.x = 600;
			addChild(three);
		}
	}
}