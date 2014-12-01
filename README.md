# Your First iOS App

This repo contains a sample for a lesson based on building an 
iOS app from scratch using code.

## Discrepancies from Textbook

The textbook takes a simpler approach, creating a UIWindow and adding
all of the sub-elements to the UIWindow. This uses MVC incorrectly, as
it puts too much on the shoulders of the AppDelegate. All code has
been transferred to the ViewController class, which is loaded via
Storyboard. This project was built in Xcode 6, using the Single Page
Application project template.

## Notes for iOS Simulator

The code here is intended to save to disk. If you were testing on an
actual iOS device, it would be more obvious, but in the Stop/Go of the
iOS Simulator, the app is hard-stopped (not gracefully quit.)

**TL;DR** - This app will only save data when you hit the Home button 
(Cmd-Shift-H) on the simulator.
