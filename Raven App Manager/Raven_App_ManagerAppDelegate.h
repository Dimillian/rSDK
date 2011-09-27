//
//  Raven_App_ManagerAppDelegate.h
//  Raven App Manager
//
//  Created by Thomas Ricouard on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Raven_App_ManagerAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource>
{
    NSWindow *window;
    IBOutlet NSTableView *tableview; 
    IBOutlet NSImageView *firstImageOff;
    IBOutlet NSImageView *firstImageOn;
     IBOutlet NSImageView *secondImageOff;
     IBOutlet NSImageView *secondImageOn;
     IBOutlet NSImageView *thirdImageOff;
     IBOutlet NSImageView *thirdImageOn;
     IBOutlet NSImageView *fourImageOff;
     IBOutlet NSImageView *fourimageOn;
    
    IBOutlet NSImageView *smallIcon; 
    IBOutlet NSImageView *bigIcon; 
    
    IBOutlet NSTextField *firstUrl;
    IBOutlet NSTextField *secondUrl;
    IBOutlet NSTextField *thirdUrl;
    IBOutlet NSTextField *fourUrl;
    IBOutlet NSTextField *appNameField;
    IBOutlet NSTextField *folderNameField;
    
    NSString *templatePath;
    IBOutlet NSTextField *bigIconText; 
    IBOutlet NSTextField *smallIconText; 
    IBOutlet NSTextField *bigIconSecondText; 
    IBOutlet NSTextField *smallIconSecondText;
    IBOutlet NSTextField *udidField; 
    
    IBOutlet NSTableColumn *imageColumn; 
    IBOutlet NSTableColumn *textColumn;
    
    NSString *opennedDocumentPath;
    
    
}

@property (assign) IBOutlet NSWindow *window;
-(IBAction)newWindow:(id)sender;
-(IBAction)addAnApp:(id)sender;
-(IBAction)saveApp:(id)sender;
-(IBAction)deleteAnApp:(id)sender;
-(IBAction)openTemplate:(id)sender;
-(IBAction)moveItemUp:(id)sender;
-(IBAction)moveItemDown:(id)sender;
-(IBAction)exportSelectedApp:(id)sender;
-(IBAction)importSelectedApp:(id)sender;
-(void)selectRowSheet;

@end
