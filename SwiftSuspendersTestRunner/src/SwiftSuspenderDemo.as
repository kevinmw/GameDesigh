package
{
	import flash.display.Sprite;
	
	import org.swiftsuspenders.Injector;
	
	public class SwiftSuspenderDemo extends Sprite
	{
		public function SwiftSuspenderDemo()//一个demo
		{
			var injector:Injector = new Injector();//申明注入器
			var injectObj1:InjectObject = new InjectObject("id_1");//新建一个叫id_1的注入对象
			var injectObj2:InjectObject = new InjectObject("id_2");//新建一个叫id_1的注入对象
			injector.mapValue(InjectObject,injectObj1);//配置注入对象的映射，id_1对象不含注入名
			injector.mapValue(InjectObject,injectObj2,"myinject");//id_2对象包含注入名
			injector.mapClass(InjecteeClass,InjecteeClass);
			
			var instance:InjecteeClass = injector.getInstance(InjecteeClass);
			instance.injectPoint.call();//调用注入对象的call()方法
			
		}
	}
}