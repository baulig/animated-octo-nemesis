using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Portable;
using Portable45;

namespace ExtensionMethod {
	class Program {
		static void Main (string[] args)
		{
			var type = typeof (int);
			var two = type.GetPower ();
			var three = type.GetPower3 ();
			Console.WriteLine ("POWER: {0} {1}", two, three);
		}
	}
}
