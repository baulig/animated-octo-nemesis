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
			var test = new TestWeb ();
			var type = test.TestType ();
			Console.WriteLine ("TYPE: {0}", type.FullName);

			var task = test.TestAsync ("http://www.xamarin.com/");
			task.Wait ();
			Console.WriteLine ("WEB: {0}", task.Result);
		}
	}
}
