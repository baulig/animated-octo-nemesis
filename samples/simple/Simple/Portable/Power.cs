using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Portable
{
	public class Power
	{
		public int Base
		{
			get;
			private set;
		}

		public Power (int b)
		{
			Base = b;
		}

		public double Compute (int number)
		{
			return Math.Pow(number, Base);
		}
	}
}
