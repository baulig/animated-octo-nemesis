using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Portable45;

namespace ConsoleTest {
	class Program {
		static void Main (string[] args)
		{
			var power = new Power (5);
			var number = power.Compute (5);
			Console.WriteLine (number);

			var length = power.GetLength ("Hello");
			Console.WriteLine (length);
		}
	}
}
