using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Profile7;
using TestPortable2;

namespace BuildTest2
{
	public class Program
	{
		static void Main()
		{
			var portable = new TestPortable();
			portable.Hello(() =>
			{
				var test = new TestClass2();
				var pi = test.Test();
				Console.WriteLine("Portable Callback: {0}", pi);
			});
		}
	}
}
