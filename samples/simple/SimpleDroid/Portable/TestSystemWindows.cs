#if FEATURE_SYSTEM_WINDOWS
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;

namespace Portable {
	public class TestSystemWindows : INotifyCollectionChanged {
		public INotifyCollectionChanged Test ()
		{
			return this;
		}

		event NotifyCollectionChangedEventHandler INotifyCollectionChanged.CollectionChanged
		{
			add
			{
				;
			}
			remove
			{
				;
			}
		}
	}
}
#endif
