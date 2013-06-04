using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Profile7;

namespace TestLibrary
{
	public class TestClass
	{
		public static void Test()
		{
			var portable = new TestPortable();
			portable.Hello(() =>
			{
				Console.WriteLine("Portable Callback!");
			});
		}
	}
}
