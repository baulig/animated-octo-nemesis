using System;
using System.Collections.Generic;
using System.Collections.Specialized;
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

			Console.WriteLine (TestWeb.TestType ().FullName);

			var test = new TestWeb ();
			var task = test.TestAsync ("http://www.xamarin.com/");
			var res = task.Result;
			Console.WriteLine (res);

			var windows = new TestSystemWindows ();
			var notify = windows.Test () as INotifyCollectionChanged;
			notify.CollectionChanged += delegate
			{
				Console.WriteLine ("COLLECTION CHANGED!");
			};
			Console.WriteLine (notify);

		}
	}
}
