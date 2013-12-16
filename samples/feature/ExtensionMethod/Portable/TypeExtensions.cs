using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Portable {
	public static class TypeExtensions {
		public static long GetPower (this Type type)
		{
			return (long)Math.Pow (2, type.FullName.Length);
		}
	}
}
