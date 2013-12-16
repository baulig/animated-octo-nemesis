using System;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;

using Portable45;

namespace AsyncDroid {
	[Activity (Label = "AsyncDroid", MainLauncher = true, Icon = "@drawable/icon")]
	public class MyActivity : Activity {
		int count = 1;
		Button button;

		protected override void OnCreate (Bundle bundle)
		{
			base.OnCreate (bundle);

			// Set our view from the "main" layout resource
			SetContentView (Resource.Layout.Main);

			// Get our button from the layout resource,
			// and attach an event to it
			button = FindViewById<Button> (Resource.Id.MyButton);

			button.Click += delegate {
				button.Text = "Running ...";
				ThreadPool.QueueUserWorkItem (_ => TestAsync ());
			};
		}

		public void TestAsync ()
		{
			var task = TestPortable ();
			task.Wait ();
			RunOnUiThread (() => button.Text = string.Format ("DONE: {0}", task.Result));
		}

		async Task<string> TestPortable ()
		{
			var sb = new StringBuilder ();
			var test = new TestWeb ();
			var type = test.TestType ();
			sb.AppendFormat ("TYPE: {0}", type.FullName);
			sb.AppendLine ();

			var res = await test.TestAsync ("http://www.xamarin.com/");
			sb.AppendFormat ("WEB: {0}", res);
			sb.AppendLine ();
			return sb.ToString ();
		}
	}
}

