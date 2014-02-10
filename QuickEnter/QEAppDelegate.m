//
//  QEAppDelegate.m
//  QuickEnter
//
//  Created by tu on 2/9/14.
//  Copyright (c) 2014 tu changwei. All rights reserved.
//

#import "QEAppDelegate.h"
@implementation QEAppDelegate

#pragma mark Notifications
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setImage:[NSImage imageNamed:@"icon"]];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setToolTip:@"Quick Enter"];
    
    NSMenu *menu = [[NSMenu alloc] init];
    NSMenuItem *menuItem = [[NSMenuItem alloc]initWithTitle:@"Quick Enter" action:@selector(showMainWindow:) keyEquivalent:@""];
    menuItem.tag = 1;
    [menu addItem:menuItem];
    
    menuItem = [[NSMenuItem alloc]initWithTitle:@"Quit" action:@selector(showMainWindow:) keyEquivalent:@""];
    menuItem.tag = 2;
    [menu addItem:menuItem];
    
    [self.statusItem setMenu:menu];
    self.textField.delegate = self;
    
    
}
- (void)applicationDidResignActive:(NSNotification *)notification {
    
    [self hideTheWindow];
}

- (void)showMainWindow:(NSMenuItem *)menuItem {
    
    if (menuItem.tag==1) {
       
        if ([self.window isVisible]) {
            
            [self hideTheWindow];
        }
        else {
            
            //The below code makes sure the window in the front of other windows of other apps.
            [NSApp activateIgnoringOtherApps:YES];
            [NSApp arrangeInFront:self.window];
            [self.window orderFront:nil];
            
            //The below code makes sure the textField first responder.
            //When you send a makeKeyWindow message to an NSWindow object, you ensure that it is the key window when the application is active. So I create a class to set self.window can become key window.
            [self.window makeKeyWindow];
            [self.window makeFirstResponder:self.textField];
            
        }
        
    }
    else if (menuItem.tag==2) {
        
        [[NSApplication sharedApplication] terminate:self];
        
    }
    
    
}

- (void)hideTheWindow {
    
    [self.textField resignFirstResponder];
    [self.window resignKeyWindow];
    [self.window orderOut:nil];
    //make the focus to previous app.
    [NSApp hide:nil];

}

#pragma mark NSTextFieldDelegate
- (void)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector
{
    
    NSLog(@"Selector method is (%@)", NSStringFromSelector( commandSelector ) );
    if (commandSelector == @selector(insertNewline:)) {
        //Do something against ENTER key
        [self executeCommand:self.textField.stringValue];
        
    } else if (commandSelector == @selector(deleteForward:)) {
        //Do something against DELETE key
        
    } else if (commandSelector == @selector(deleteBackward:)) {
        //Do something against BACKSPACE key
        
    } else if (commandSelector == @selector(insertTab:)) {
        //Do something against TAB key
    }
}

- (void)executeCommand:(NSString *)command {
    
    NSTask *task = [[NSTask alloc]init];
    [task setLaunchPath:@"/usr/bin/open"];
    [task setCurrentDirectoryPath:@"/"];
    [task setArguments:@[command]];
    [task launch];
}
@end
