package
{
	public class InjecteeClass//接收注入的类
	{
		[Inject]public var injectPoint:InjectObject;//注入点
		public function InjecteeClass()
		{
		}
		[PostConstruct(order=1)]
		public function order1():void{//定义注入完成后执行的第一个函数
			trace("post 1");
		}
		
		[PostConstruct(order=2)]
		public function order2():void{//定义注入完成后执行的第一个函数
			trace("post 2")
		}
	}
}