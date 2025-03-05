import Cocoa

class ContentViewController: NSViewController {
    
    private var textView: NSTextView!
    private var delaySlider: NSSlider!
    private var delayLabel: NSTextField!
    private var typeButton: NSButton!
    private var statusLabel: NSTextField!
    private var preserveTabsCheckbox: NSButton!
    private var scrollView: NSScrollView!
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 500))
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Title
        let titleLabel = NSTextField(labelWithString: "AutoType")
        titleLabel.font = NSFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Instructions
        let instructionsLabel = NSTextField(wrappingLabelWithString: "Paste your text below. Click 'Start Typing' and switch to your target application within 5 seconds.")
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)
        
        // Text view for input
        scrollView = NSScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.borderType = .bezelBorder
        
        textView = NSTextView(frame: .zero)
        textView.isEditable = true
        textView.isSelectable = true
        textView.font = NSFont.systemFont(ofSize: 12)
        textView.textContainerInset = NSSize(width: 5, height: 5)
        textView.autoresizingMask = [.width, .height]
        
        scrollView.documentView = textView
        view.addSubview(scrollView)
        
        // Preserve tabs checkbox
        preserveTabsCheckbox = NSButton(checkboxWithTitle: "Preserve Tab Characters", target: nil, action: nil)
        preserveTabsCheckbox.translatesAutoresizingMaskIntoConstraints = false
        preserveTabsCheckbox.state = .on
        view.addSubview(preserveTabsCheckbox)
        
        // Delay slider
        let sliderLabel = NSTextField(labelWithString: "Typing Delay:")
        sliderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sliderLabel)
        
        delaySlider = NSSlider(value: 0.05, minValue: 0.01, maxValue: 0.2, target: self, action: #selector(sliderChanged(_:)))
        delaySlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(delaySlider)
        
        delayLabel = NSTextField(labelWithString: "0.05 seconds")
        delayLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(delayLabel)
        
        // Type button
        typeButton = NSButton(title: "Start Typing", target: self, action: #selector(startTyping(_:)))
        typeButton.bezelStyle = .rounded
        typeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(typeButton)
        
        // Status label
        statusLabel = NSTextField(labelWithString: "Ready")
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = NSColor.secondaryLabelColor
        view.addSubview(statusLabel)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.heightAnchor.constraint(equalToConstant: 200),
            
            preserveTabsCheckbox.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 15),
            preserveTabsCheckbox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            sliderLabel.topAnchor.constraint(equalTo: preserveTabsCheckbox.bottomAnchor, constant: 15),
            sliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            delaySlider.centerYAnchor.constraint(equalTo: sliderLabel.centerYAnchor),
            delaySlider.leadingAnchor.constraint(equalTo: sliderLabel.trailingAnchor, constant: 10),
            delaySlider.widthAnchor.constraint(equalToConstant: 150),
            
            delayLabel.centerYAnchor.constraint(equalTo: delaySlider.centerYAnchor),
            delayLabel.leadingAnchor.constraint(equalTo: delaySlider.trailingAnchor, constant: 10),
            
            typeButton.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 20),
            typeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: typeButton.bottomAnchor, constant: 15),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func sliderChanged(_ sender: NSSlider) {
        let value = sender.doubleValue
        delayLabel.stringValue = String(format: "%.3f seconds", value)
    }
    
    @objc private func startTyping(_ sender: NSButton) {
        let text = textView.string
        guard !text.isEmpty else {
            statusLabel.stringValue = "Error: No text to type"
            return
        }
        
        // Check for accessibility permissions
        if !checkAccessibilityPermissions() {
            statusLabel.stringValue = "Error: Accessibility permissions required"
            return
        }
        
        statusLabel.stringValue = "Starting in 5 seconds..."
        typeButton.isEnabled = false
        
        // Close the popover to allow user to switch to target app
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.closePopover(nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.statusLabel.stringValue = "Typing..."
            self.performTyping(text: text)
        }
    }
    
    // Function to check and request accessibility permissions
    private func checkAccessibilityPermissions() -> Bool {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary)
        return accessEnabled
    }
    
    private func performTyping(text: String) {
        let delay = delaySlider.doubleValue
        let preserveTabs = preserveTabsCheckbox.state == .on
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Add a small initial delay to ensure we're in the target app
            Thread.sleep(forTimeInterval: 0.5)
            
            let lines = text.components(separatedBy: .newlines)
            var totalChars = 0
            let totalToType = text.count
            
            for (index, line) in lines.enumerated() {
                let processedLine = preserveTabs ? line : line.replacingOccurrences(of: "\t", with: "")
                
                // Type each character with delay
                for char in processedLine {
                    if char == "\t" && preserveTabs {
                        self.pressTab()
                    } else {
                        self.typeCharacter(String(char))
                    }
                    Thread.sleep(forTimeInterval: delay)
                    
                    // Update progress
                    totalChars += 1
                    let progress = Double(totalChars) / Double(totalToType) * 100
                    DispatchQueue.main.async {
                        self.statusLabel.stringValue = String(format: "Typing... %.1f%%", progress)
                    }
                }
                
                // Press Enter after each line except the last one if it's empty
                if index < lines.count - 1 || !lines.last!.isEmpty {
                    self.pressEnter()
                    Thread.sleep(forTimeInterval: delay)
                    totalChars += 1
                }
            }
            
            DispatchQueue.main.async {
                self.statusLabel.stringValue = "Typing completed"
                self.typeButton.isEnabled = true
            }
        }
    }
    
    private func typeCharacter(_ character: String) {
        guard let source = CGEventSource(stateID: .hidSystemState) else { return }
        
        // Convert character to keycode and modifiers
        let keyInfo = self.keyCodeForChar(character)
        
        // If we have a valid keycode
        if keyInfo.keyCode != 0 {
            // Create key down event
            let keyDown = CGEvent(keyboardEventSource: source, virtualKey: keyInfo.keyCode, keyDown: true)
            keyDown?.flags = keyInfo.modifiers
            keyDown?.post(tap: .cghidEventTap)
            
            // Create key up event
            let keyUp = CGEvent(keyboardEventSource: source, virtualKey: keyInfo.keyCode, keyDown: false)
            keyUp?.post(tap: .cghidEventTap)
        } else {
            // For unsupported characters, we could implement a fallback
            // This is a placeholder for a more sophisticated implementation
            print("Unable to type character: \(character)")
        }
    }
    
    private func pressEnter() {
        guard let source = CGEventSource(stateID: .hidSystemState) else { return }
        
        // Key code for Return key
        let keyCode: CGKeyCode = 0x24
        
        // Create key down event
        let keyDown = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: true)
        keyDown?.post(tap: .cghidEventTap)
        
        // Create key up event
        let keyUp = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: false)
        keyUp?.post(tap: .cghidEventTap)
    }
    
    private func pressTab() {
        guard let source = CGEventSource(stateID: .hidSystemState) else { return }
        
        // Key code for Tab key
        let keyCode: CGKeyCode = 0x30
        
        // Create key down event
        let keyDown = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: true)
        keyDown?.post(tap: .cghidEventTap)
        
        // Create key up event
        let keyUp = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: false)
        keyUp?.post(tap: .cghidEventTap)
    }
    
    // Helper function to convert characters to key codes
    private func keyCodeForChar(_ character: String) -> (keyCode: CGKeyCode, modifiers: CGEventFlags) {
        // This is a simplified implementation - a complete implementation would map all characters
        // to their corresponding key codes and modifiers
        
        let char = character.first ?? " "
        
        // Check if it's a capital letter
        if char.isUppercase && char.isLetter {
            // Find the lowercase key code and add shift modifier
            let lowerChar = String(char).lowercased().first!
            let keyCode = self.basicKeyCodeMap[lowerChar] ?? 0
            return (keyCode, .maskShift)
        }
        
        // Check for special characters that require shift
        if let (keyCode, _) = self.shiftKeyCodeMap[char] {
            return (keyCode, .maskShift)
        }
        
        // Regular character
        if let keyCode = self.basicKeyCodeMap[char] {
            return (keyCode, [])
        }
        
        // For characters not in our map, try to use Unicode input method
        print("Character not found in keymap: \(char)")
        return (0x09, []) // Default to 'v' key (for paste fallback)
    }
    
    // Basic mapping of characters to key codes (limited set for demonstration)
    private let basicKeyCodeMap: [Character: CGKeyCode] = [
        "a": 0x00, "b": 0x0B, "c": 0x08, "d": 0x02, "e": 0x0E, "f": 0x03, "g": 0x05, "h": 0x04,
        "i": 0x22, "j": 0x26, "k": 0x28, "l": 0x25, "m": 0x2E, "n": 0x2D, "o": 0x1F, "p": 0x23,
        "q": 0x0C, "r": 0x0F, "s": 0x01, "t": 0x11, "u": 0x20, "v": 0x09, "w": 0x0D, "x": 0x07,
        "y": 0x10, "z": 0x06, " ": 0x31, "1": 0x12, "2": 0x13, "3": 0x14, "4": 0x15, "5": 0x17,
        "6": 0x16, "7": 0x1A, "8": 0x1C, "9": 0x19, "0": 0x1D, "-": 0x1B, "=": 0x18, ";": 0x29,
        "'": 0x27, ",": 0x2B, ".": 0x2F, "/": 0x2C, "\\": 0x2A, "`": 0x32, "[": 0x21, "]": 0x1E,
        "\t": 0x30
    ]
    
    // Mapping for characters that require shift key
    private let shiftKeyCodeMap: [Character: (CGKeyCode, CGEventFlags)] = [
        "!": (0x12, .maskShift), "@": (0x13, .maskShift), "#": (0x14, .maskShift),
        "$": (0x15, .maskShift), "%": (0x17, .maskShift), "^": (0x16, .maskShift),
        "&": (0x1A, .maskShift), "*": (0x1C, .maskShift), "(": (0x19, .maskShift),
        ")": (0x1D, .maskShift), "_": (0x1B, .maskShift), "+": (0x18, .maskShift),
        "{": (0x21, .maskShift), "}": (0x1E, .maskShift), "|": (0x2A, .maskShift),
        ":": (0x29, .maskShift), "\"": (0x27, .maskShift), "<": (0x2B, .maskShift),
        ">": (0x2F, .maskShift), "?": (0x2C, .maskShift), "~": (0x32, .maskShift)
    ]
} 