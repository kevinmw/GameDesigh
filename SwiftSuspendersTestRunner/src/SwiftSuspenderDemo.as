package
{
	import flash.display.Sprite;
	
	import org.swiftsuspenders.Injector;
	
	public class SwiftSuspenderDemo extends Sprite
	{
		public function SwiftSuspenderDemo()//一个demo
		{
			
			var injector:Injector = new Injector();//申明注入器
			injector.mapClass(InjectObject,InjectObject);//对InjectorObject类进行类映射
			injector.mapClass(InjecteeClass,InjecteeClass);//对InjecteeClass进行类映射
			
			
			var instance:InjecteeClass = injector.getInstance(InjecteeClass);//通过注入器获取InjecteeClass对象，注入器自动完成注入
			instance.injectPoint.call();//对注入过的对象进行调用
			
			trace(injector.hasMapping(InjecteeClass));
		}
	}
}