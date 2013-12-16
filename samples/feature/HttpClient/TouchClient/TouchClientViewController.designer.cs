// WARNING
//
// This file has been generated automatically by Xamarin Studio to store outlets and
// actions made in the UI designer. If it is removed, they will be lost.
// Manual changes to this file may not be handled correctly.
//
using MonoTouch.Foundation;
using System.CodeDom.Compiler;

namespace TouchClient
{
	[Register ("TouchClientViewController")]
	partial class TouchClientViewController
	{
		[Outlet]
		MonoTouch.UIKit.UIButton GoButton { get; set; }

		[Outlet]
		[GeneratedCodeAttribute ("iOS Designer", "1.0")]
		MonoTouch.UIKit.UILabel StatusLabel { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton StopButton { get; set; }

		[Outlet]
		MonoTouch.UIKit.UITextField UrlField { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIWebView WebView { get; set; }

		[Action ("GoButton_TouchUpInside:")]
		partial void GoButton_TouchUpInside (MonoTouch.UIKit.UIButton sender);

		[Action ("StopButton_TouchUpInside:")]
		partial void StopButton_TouchUpInside (MonoTouch.UIKit.UIButton sender);
		
		void ReleaseDesignerOutlets ()
		{
			if (GoButton != null) {
				GoButton.Dispose ();
				GoButton = null;
			}

			if (StopButton != null) {
				StopButton.Dispose ();
				StopButton = null;
			}

			if (UrlField != null) {
				UrlField.Dispose ();
				UrlField = null;
			}

			if (WebView != null) {
				WebView.Dispose ();
				WebView = null;
			}

			if (StatusLabel != null) {
				StatusLabel.Dispose ();
				StatusLabel = null;
			}
		}
	}
}
