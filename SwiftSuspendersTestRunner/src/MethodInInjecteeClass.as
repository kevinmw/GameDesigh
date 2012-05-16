package
{
	public class MethodInInjecteeClass
	{
		public var obj1:InjectObject;//需要注入的第一个对象
		public var obj2:InjectObject;//需要注入的第二个对象
		public function MethodInInjecteeClass()
		{
		}
		[Inject(name="",name="myinject")]//第一个参数无注入名，第二个参数有myinject注入名
		public function inject(arg1:InjectObject,arg2:InjectObject):void{//方法注入
			this.obj1 = arg1;
			this.obj2 = arg2;
		}
	}
}