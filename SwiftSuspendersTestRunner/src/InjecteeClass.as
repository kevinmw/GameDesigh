package
{
	public class InjecteeClass//接收注入的类
	{
		[Inject(name="myinject")]public var injectPoint:InjectObject;//注入点，包含注入名
		public function InjecteeClass()
		{
		}
	}
}