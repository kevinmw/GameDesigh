package
{
	public class InjectObject//被注入的对象
	{
		private var id:String;
		public function InjectObject(id:String)
		{
			trace("created");//构造函数
			this.id = id;
		}
		public function call():void{//一个简单的方法调用
			trace(id,"called");
		}
	}
}