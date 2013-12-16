using System;
using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using PortableObservableCollection;

namespace TestDroid
{
	[Activity (Label = "TestDroid", MainLauncher = true)]
	public class MainActivity : Activity
	{
		TestCollection<string> collection;

		protected override void OnCreate (Bundle bundle)
		{
			base.OnCreate (bundle);

			// Set our view from the "main" layout resource
			SetContentView (Resource.Layout.Main);

			// Get our button from the layout resource,
			// and attach an event to it
			Button button = FindViewById<Button> (Resource.Id.myButton);

			collection = new TestCollection<string> ();
			
			button.Click += delegate {
				collection.Add (string.Format ("{0} clicks!", collection.Count));
				button.Text = string.Format ("Test Collection: {0}", collection.Count);
			};
		}
	}
}


