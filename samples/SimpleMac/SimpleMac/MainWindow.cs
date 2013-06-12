using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using MonoMac.Foundation;
using MonoMac.AppKit;

using Portable;

namespace SimpleMac
{
	public partial class MainWindow : MonoMac.AppKit.NSWindow
	{
		Power power;
		int current;

		#region Constructors
		// Called when created from unmanaged code
		public MainWindow (IntPtr handle) : base (handle)
		{
			Initialize ();
		}
		// Called when created directly from a XIB file
		[Export ("initWithCoder:")]
		public MainWindow (NSCoder coder) : base (coder)
		{
			Initialize ();
		}
		// Shared initialization code
		void Initialize ()
		{
			power = new Power (8);
		}
		#endregion

		partial void Button (MonoMac.Foundation.NSObject sender)
		{
			RunTests ();

			var number = power.Compute (++current);
			Label.StringValue = string.Format ("{0} is the power!", number);
		}

		static void RunTests ()
		{
			TestWeb.TestType ();

			var windows = new TestSystemWindows ();
			var notification = windows.Test () as INotifyCollectionChanged;
			Console.WriteLine (notification);
		}

	}
}

