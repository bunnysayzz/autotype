import Cocoa

// This is the main entry point for the application
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// Start the application
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv) 