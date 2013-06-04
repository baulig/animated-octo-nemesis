using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Portable2;

namespace BuildTest4
{
	class Program
	{
		static void Main(string[] args)
		{
			var portable = new TestPortable2();
			var test = portable.Test();
			Console.WriteLine(test);
		}
	}
}
