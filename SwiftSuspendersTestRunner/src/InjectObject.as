package
{
	public class InjectObject//被注入的对象
	{
		public function InjectObject()
		{
			trace("created");//构造函数
		}
		public function call():void{//一个简单的方法调用
			trace("called");
		}
	}
}