// WARNING
//
// This file has been generated automatically by Xamarin Studio to store outlets and
// actions made in the Xcode designer. If it is removed, they will be lost.
// Manual changes to this file may not be handled correctly.
//
using MonoTouch.Foundation;

namespace SimpleTouch45
{
	[Register ("SimpleTouch45ViewController")]
	partial class SimpleTouch45ViewController
	{
		[Outlet]
		MonoTouch.UIKit.UILabel Label { get; set; }

		[Action ("Action:")]
		partial void Action (MonoTouch.Foundation.NSObject sender);
		
		void ReleaseDesignerOutlets ()
		{
			if (Label != null) {
				Label.Dispose ();
				Label = null;
			}
		}
	}
}
