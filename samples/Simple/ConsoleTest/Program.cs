using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Portable;

namespace ConsoleTest {
	class Program {
		static void Main (string[] args)
		{
			var power = new Power (8);
			Console.WriteLine (power.Compute (8));

			var test = new TestWeb ();
			Console.WriteLine (test.TestType ().FullName);

			var task = test.TestAsync ("http://www.xamarin.com/");
			var res = task.Result;
			Console.WriteLine (res);
		}
	}
}
