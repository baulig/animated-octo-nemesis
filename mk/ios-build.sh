#!/bin/bash
source $(cd "`dirname "$0"`/.." && pwd)/env.sh

export XBUILD_FRAMEWORK_FOLDERS_PATH="$TEST_MONO_PATH/lib/xbuild-frameworks"
export MONOTOUCH_PREFIX=$TEST_IOS_PATH
export MTOUCH=$TEST_IOS_PATH/usr/bin/mtouch
export MD_MTOUCH_SDK_ROOT=$TEST_IOS_PATH

echo "TEST_MONO_PATH: $TEST_MONO_PATH"
echo "TEST_IOS_PATH: $MONOTOUCH_PREFIX"

if test "x$XAMARIN_STUDIO_PROFILE_PATH" != "x"; then
	echo "XAMARIN_STUDIO_PROFILE_PATH: $XAMARIN_STUDIO_PROFILE_PATH"
	export MONODEVELOP_PROFILE=$XAMARIN_STUDIO_PROFILE_PATH
fi

export XAMARIN_STUDIO_APP="\"/Applications/Xamarin Studio.app\""

eval exec $XAMARIN_STUDIO_APP/Contents/MacOS/mdtool -v $@
