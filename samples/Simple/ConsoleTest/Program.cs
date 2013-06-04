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
		}
	}
}
