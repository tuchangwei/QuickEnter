//
//  QEAppDelegate.h
//  QuickEnter
//
//  Created by tu on 2/9/14.
//  Copyright (c) 2014 tu changwei. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QEAppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (weak) IBOutlet NSTextField *textField;
@end
