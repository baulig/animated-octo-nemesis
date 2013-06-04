using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Portable45 {
	public static class TypeExtensions45 {
		public static long GetPower3 (this Type type)
		{
			return (long)Math.Pow (3, type.FullName.Length);
		}
	}
}
