using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Numerics;

namespace Portable1
{
	public class TestPortable
	{
		public static double Test()
		{
			return Math.PI;
		}

		public static BigInteger TestNumerics(long number)
		{
			return new BigInteger(number);
		}
	}
}
