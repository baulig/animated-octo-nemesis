using System;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Portable {
	public class TestWeb {
		public Type TestType ()
		{
			return typeof (System.ServiceModel.BasicHttpBinding);
		}

		public Task<HttpWebResponse> TestAsync (string url)
		{
			var tcs = new TaskCompletionSource<HttpWebResponse> ();
			var req = HttpWebRequest.Create (url);
			req.BeginGetResponse (ares => {
				var res = (HttpWebResponse)req.EndGetResponse (ares);
				tcs.SetResult (res);
			}, null);
			return tcs.Task;
		}
	}
}
