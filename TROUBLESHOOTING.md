# AutoType Troubleshooting Guide

If you're experiencing issues with AutoType, this guide will help you resolve common problems.

## AutoType Not Typing Text

### 1. Check Accessibility Permissions

The most common reason for AutoType not working is missing accessibility permissions:

1. Open **System Preferences** > **Security & Privacy** > **Privacy** > **Accessibility**
2. Make sure AutoType is in the list and has a checkmark next to it
3. If it's not in the list, click the "+" button and add AutoType.app
4. If it's already in the list but not checked, check the box
5. You may need to unlock the preferences by clicking the lock icon in the bottom left

### 2. Restart the Application

Sometimes a simple restart can fix issues:

1. Quit AutoType (right-click the keyboard icon in the menu bar and select "Quit")
2. Reopen AutoType from the Applications folder or using Spotlight

### 3. Rebuild the Application

If you're running from source:

```
./build.sh
./run.sh
```

### 4. Adjust Typing Delay

If typing is inconsistent or characters are missing:

1. Try increasing the typing delay (move the slider to the right)
2. A delay of 0.01-0.02 seconds often works well for most systems
3. For very complex text or slower systems, try 0.05-0.1 seconds

### 5. Check for Special Characters

Some special characters may not be properly mapped. Try using simpler text with standard ASCII characters.

### 6. Typing Code

When typing code:

1. The app will automatically remove tabs and type the code with proper line breaks
2. Most code editors will automatically format the code as you type

### 7. Ensure Proper Focus

Make sure you:
1. Click "Start Typing"
2. Switch to your target application within the 5-second countdown
3. Place the cursor where you want the text to be typed

## Application Won't Launch

### 1. Check for Existing Instances

Make sure there isn't already an instance of AutoType running.

### 2. Check macOS Version

AutoType requires macOS 10.13 or later.

### 3. Rebuild from Source

If you're running from source, try a clean rebuild:

```
rm -rf AutoType.app
./build.sh
./run.sh
```

### 4. Check Console for Errors

1. Open the Console app (Applications > Utilities > Console)
2. Search for "AutoType" to see any error messages

## Contact Support

If you're still experiencing issues, please:

1. Create an issue on the GitHub repository with:
   - A detailed description of the problem
   - Steps to reproduce the issue
   - Your macOS version
   - Any error messages you're seeing

## Advanced Troubleshooting

For developers, you can run the app from the terminal with debugging output:

```
./AutoType.app/Contents/MacOS/AutoType
```

This will show any error messages or warnings that might help identify the issue. 