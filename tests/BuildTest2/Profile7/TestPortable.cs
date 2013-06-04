using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Profile7
{
	public delegate void PortableCallback ();

	public class TestPortable
	{
		public void Hello(PortableCallback callback)
		{
			callback();
		}
	}
}
