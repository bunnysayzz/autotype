import Cocoa
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var eventMonitor: EventMonitor?
    private var statusItemMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Check if another instance is already running
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = runningApps.contains {
            $0.bundleIdentifier == "com.example.AutoType" && $0.processIdentifier != ProcessInfo.processInfo.processIdentifier
        }
        
        if isRunning {
            NSApp.terminate(nil)
            return
        }
        
        // Set up the main menu for keyboard shortcuts
        setupMainMenu()
        
        // Check for accessibility permissions
        checkAccessibilityPermissions()
        
        // Create the popover for the content
        popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 500)
        popover.behavior = .transient
        popover.contentViewController = ContentViewController()
        
        // Create the menu for right-click
        statusItemMenu = NSMenu()
        statusItemMenu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        
        // Create the status item in the menu bar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem.button {
            // Use system symbol since we don't have the custom icon
            button.image = NSImage(systemSymbolName: "keyboard", accessibilityDescription: "AutoType")
            
            // Set up for both left and right click handling
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
            button.action = #selector(handleStatusItemClick(_:))
        }
        
        // Monitor for clicks outside the popover to dismiss it
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self, self.popover.isShown else { return }
            self.closePopover(event)
        }
        eventMonitor?.start()
    }
    
    // Set up the main menu for keyboard shortcuts
    private func setupMainMenu() {
        let mainMenu = NSMenu(title: "MainMenu")
        
        // Application menu
        let appMenuItem = NSMenuItem()
        appMenuItem.submenu = NSMenu(title: "AutoType")
        
        let aboutMenuItem = NSMenuItem(title: "About AutoType", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "")
        appMenuItem.submenu?.addItem(aboutMenuItem)
        appMenuItem.submenu?.addItem(NSMenuItem.separator())
        
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        appMenuItem.submenu?.addItem(quitMenuItem)
        
        // Edit menu (for keyboard shortcuts)
        let editMenuItem = NSMenuItem()
        editMenuItem.submenu = NSMenu(title: "Edit")
        
        // Add standard edit menu items
        let undoMenuItem = NSMenuItem(title: "Undo", action: Selector(("undo:")), keyEquivalent: "z")
        let redoMenuItem = NSMenuItem(title: "Redo", action: Selector(("redo:")), keyEquivalent: "Z") // Shift+Cmd+Z
        let cutMenuItem = NSMenuItem(title: "Cut", action: #selector(NSText.cut(_:)), keyEquivalent: "x")
        let copyMenuItem = NSMenuItem(title: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c")
        let pasteMenuItem = NSMenuItem(title: "Paste", action: #selector(NSText.paste(_:)), keyEquivalent: "v")
        let selectAllMenuItem = NSMenuItem(title: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a")
        
        // Add pause/resume menu item
        let pauseResumeMenuItem = NSMenuItem(title: "Pause/Resume Typing", action: #selector(pauseResumeTyping), keyEquivalent: "f")
        
        editMenuItem.submenu?.addItem(undoMenuItem)
        editMenuItem.submenu?.addItem(redoMenuItem)
        editMenuItem.submenu?.addItem(NSMenuItem.separator())
        editMenuItem.submenu?.addItem(cutMenuItem)
        editMenuItem.submenu?.addItem(copyMenuItem)
        editMenuItem.submenu?.addItem(pasteMenuItem)
        editMenuItem.submenu?.addItem(NSMenuItem.separator())
        editMenuItem.submenu?.addItem(selectAllMenuItem)
        editMenuItem.submenu?.addItem(NSMenuItem.separator())
        editMenuItem.submenu?.addItem(pauseResumeMenuItem)
        
        // Add menus to main menu
        mainMenu.addItem(appMenuItem)
        mainMenu.addItem(editMenuItem)
        
        // Set as the application menu
        NSApplication.shared.mainMenu = mainMenu
    }
    
    @objc func handleStatusItemClick(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == .rightMouseUp {
            // Show menu on right-click
            statusItemMenu.popUp(positioning: nil, at: NSPoint(x: sender.frame.origin.x, y: sender.frame.origin.y - 2), in: sender)
        } else if event.type == .leftMouseUp {
            // Show popover on left-click
            togglePopover(sender)
        }
    }
    
    @objc func quitApp() {
        NSApp.terminate(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        eventMonitor?.stop()
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func closePopover(_ sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    // Function to check and request accessibility permissions
    private func checkAccessibilityPermissions() {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary)
        
        if !accessEnabled {
            // Show a notification to inform the user about accessibility permissions
            let notification = NSUserNotification()
            notification.title = "Accessibility Permissions Required"
            notification.informativeText = "AutoType needs accessibility permissions to simulate keyboard input. Please grant permissions in System Preferences."
            notification.soundName = NSUserNotificationDefaultSoundName
            NSUserNotificationCenter.default.deliver(notification)
        }
    }
    
    // Method to handle pause/resume menu item
    @objc func pauseResumeTyping() {
        if let contentViewController = popover.contentViewController as? ContentViewController {
            contentViewController.togglePause()
        }
    }
}

// Event monitor to detect clicks outside the popover
class EventMonitor {
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    
    init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
} 