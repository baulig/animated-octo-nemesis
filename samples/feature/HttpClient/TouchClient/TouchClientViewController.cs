//
// TouchClientViewController.cs
//
// Author:
//       Martin Baulig <martin.baulig@xamarin.com>
//
// Copyright (c) 2013 Xamarin Inc. (http://www.xamarin.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
using System;
using System.Drawing;
using System.Threading.Tasks;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using PortableHttpClient;

namespace TouchClient
{
	public partial class TouchClientViewController : UIViewController
	{
		Client client;

		public TouchClientViewController (IntPtr handle) : base (handle)
		{
			client = new Client ();
		}

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}

		#region View lifecycle

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			
			// Perform any additional setup after loading the view, typically from a nib.
		}

		public override void ViewWillAppear (bool animated)
		{
			base.ViewWillAppear (animated);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
		}

		public override void ViewWillDisappear (bool animated)
		{
			base.ViewWillDisappear (animated);
		}

		public override void ViewDidDisappear (bool animated)
		{
			base.ViewDidDisappear (animated);
		}

		#endregion

		public override bool ShouldAutorotateToInterfaceOrientation (UIInterfaceOrientation toInterfaceOrientation)
		{
			// Return true for supported orientations
			return (toInterfaceOrientation != UIInterfaceOrientation.PortraitUpsideDown);
		}

		partial void GoButton_TouchUpInside (UIButton sender)
		{
			WebView.LoadHtmlString (string.Empty, null);
			StopButton.Enabled = true;
			GoButton.Enabled = false;
			StatusLabel.Text = "Loading ...";
			Load (UrlField.Text);
		}

		partial void StopButton_TouchUpInside (UIButton sender)
		{
			client.Cancel ();
		}

		async void Load (string url)
		{
			try {
				var result = await client.Download (url);
				InvokeOnMainThread (() => {
					WebView.LoadHtmlString (result, new NSUrl (url));
					StatusLabel.Text = string.Format ("Successfully loaded {0} bytes.", result.Length);
				});
			} catch (TaskCanceledException) {
				InvokeOnMainThread (() => StatusLabel.Text = "Canceled!");
			} catch (Exception ex) {
				InvokeOnMainThread (() => {
					StatusLabel.Text = "Error!";
					WebView.LoadHtmlString (ex.ToString (), null);
				});
			} finally {
				InvokeOnMainThread (() => {
					GoButton.Enabled = true;
					StopButton.Enabled = false;
				});
			}
		}
	}
}

