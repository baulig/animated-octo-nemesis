using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Portable1;

namespace Portable2
{
	public class TestPortable2
	{
		public double Test()
		{
			var big = TestPortable.TestNumerics(65536);
			return TestPortable.Test() * Math.E;
		}
	}
}
