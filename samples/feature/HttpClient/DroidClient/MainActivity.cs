using System;
using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using PortableHttpClient;

namespace DroidClient
{
	[Activity (Label = "DroidClient", MainLauncher = true)]
	public class MainActivity : Activity
	{
		Client client; 
		TextView urlText;
		TextView resultArea;
		Button button;

		protected override void OnCreate (Bundle bundle)
		{
			base.OnCreate (bundle);

			// Set our view from the "main" layout resource
			SetContentView (Resource.Layout.Main);

			urlText = FindViewById<TextView> (Resource.Id.urlText);
			resultArea = FindViewById<TextView> (Resource.Id.resultArea);
			button = FindViewById<Button> (Resource.Id.button);

			urlText.Text = "http://www.xamarin.com/";

			client = new Client ();

			button.Click += delegate {
				resultArea.Text = "Loading ...";
				Test (urlText.Text);
			};
		}

		async void Test (string url)
		{
			var result = await client.Download (url);
			Console.WriteLine ("RESULT: {0}", result.Length);
			RunOnUiThread (() => resultArea.Text = result);
		}
	}
}


