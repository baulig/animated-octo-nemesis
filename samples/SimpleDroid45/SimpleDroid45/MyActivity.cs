using System;

using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;

using Portable45;

namespace Simple45 {
	[Activity (Label = "Simple45", MainLauncher = true, Icon = "@drawable/icon")]
	public class MyActivity : Activity {
		int count = 1;
		Power power;

		protected override void OnCreate (Bundle bundle)
		{
			base.OnCreate (bundle);

			power = new Power (3);

			// Set our view from the "main" layout resource
			SetContentView (Resource.Layout.Main);

			// Get our button from the layout resource,
			// and attach an event to it
			Button button = FindViewById<Button> (Resource.Id.MyButton);

			button.Click += delegate
			{
				var number = power.Compute (count++);
				button.Text = string.Format ("{0} is the power", number);
			};
		}
	}
}

