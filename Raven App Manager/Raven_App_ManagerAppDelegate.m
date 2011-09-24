//
//  Raven_App_ManagerAppDelegate.m
//  Raven App Manager
//
//  Created by Thomas Ricouard on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Raven_App_ManagerAppDelegate.h"
#import "RAPlistManager.h"

#define PSD_NAME @"rSDK-IconTemplate.psd"
@implementation Raven_App_ManagerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [tableview setDataSource:self]; 
    [tableview setDelegate:self];
    [tableview setAllowsEmptySelection:NO];
    
    // Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *applicationSupport = [[NSString stringWithString:@"~/Library/Application Support/RavenApp/appManager"] stringByExpandingTildeInPath];
    //Check if exist, if not create the dir
    if ([fileManager fileExistsAtPath:applicationSupport] == NO)
        [fileManager createDirectoryAtPath:applicationSupport withIntermediateDirectories:YES attributes:nil error:nil];
    
    //Set the database path
    templatePath  = [applicationSupport stringByAppendingPathComponent:PSD_NAME]; 
    [templatePath retain]; 
    
    BOOL successPath;
    
    successPath = [fileManager fileExistsAtPath:templatePath];
	if(successPath) return;

    NSString *pathTemplate = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:PSD_NAME]; 
    [fileManager copyItemAtPath:pathTemplate toPath:templatePath error:nil];
    
    fileManager = nil; 
	[fileManager release];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
    NSDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    NSUInteger count = [folders count];
    [folders release]; 
    return count;

}

 
- (id)tableView:(NSTableView *)tableView
 objectValueForTableColumn:(NSTableColumn *)tableColumn
 row:(NSInteger)row
 {  
 
     NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
     NSDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
     NSArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    NSDictionary *item = [folders objectAtIndex:row];
    NSString *appName = [item objectForKey:PLIST_KEY_APPNAME];
     NSString *folderNameTemp = [item objectForKey:PLIST_KEY_FOLDER];
     NSString *imagePath = [NSString stringWithFormat:application_support_path@"%@/main.png", folderNameTemp];
     NSImage *tempImage = [[[NSImage alloc]initWithContentsOfFile:[imagePath stringByExpandingTildeInPath]]autorelease];
     [folders release]; 
     if (tableColumn == imageColumn) {
         return tempImage;
     }
     if (tableColumn == textColumn) {
        return appName;
     }

     return nil;
}
 
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
    NSDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    NSDictionary *item = [folders objectAtIndex:[tableview selectedRow]];
    NSString *folderName = [item objectForKey:PLIST_KEY_FOLDER];
    [folderNameField setStringValue:[item objectForKey:PLIST_KEY_FOLDER]];
    [appNameField setStringValue:[item objectForKey:PLIST_KEY_APPNAME]];
    NSArray *URL = [[item objectForKey:PLIST_KEY_URL]mutableCopy]; 
    [firstUrl setStringValue:[URL objectAtIndex:0]];
    [secondUrl setStringValue:[URL objectAtIndex:1]];
    [thirdUrl setStringValue:[URL objectAtIndex:2]];
    [fourUrl setStringValue:[URL objectAtIndex:3]];
    
    NSString *homeButtonPath = [NSString stringWithFormat:application_support_path@"%@/main.png", folderName];
    NSString *homeButtonBigPath = [NSString stringWithFormat:application_support_path@"%@/main_big.png", folderName];
    NSString *firstImageOffPath = [NSString stringWithFormat:application_support_path@"%@/1_off.png", folderName];
    NSString *firstImageOnPath = [NSString stringWithFormat:application_support_path@"%@/1_on.png", folderName];
    NSString *secondImageOffPath = [NSString stringWithFormat:application_support_path@"%@/2_off.png", folderName]; 
    NSString *secondImageOnPath = [NSString stringWithFormat:application_support_path@"%@/2_on.png", folderName]; 
    NSString *thirdImageOffPath = [NSString stringWithFormat:application_support_path@"%@/3_off.png", folderName]; 
    NSString *thirdImageOnPath = [NSString stringWithFormat:application_support_path@"%@/3_on.png", folderName]; 
    NSString *fourImageOffPath = [NSString stringWithFormat:application_support_path@"%@/4_off.png", folderName]; 
    NSString *fourImageOnPath = [NSString stringWithFormat:application_support_path@"%@/4_on.png", folderName];
    
    [smallIcon setImage:[[[NSImage alloc]initWithContentsOfFile:[homeButtonPath stringByExpandingTildeInPath]]autorelease]];
    [bigIcon setImage:[[[NSImage alloc]initWithContentsOfFile:[homeButtonBigPath stringByExpandingTildeInPath]]autorelease]];
    [firstImageOff setImage:[[[NSImage alloc]initWithContentsOfFile:[firstImageOffPath stringByExpandingTildeInPath]]autorelease]];
    [firstImageOn setImage:[[[NSImage alloc]initWithContentsOfFile:[firstImageOnPath stringByExpandingTildeInPath]]autorelease]];
    [secondImageOff setImage:[[[NSImage alloc]initWithContentsOfFile:[secondImageOffPath stringByExpandingTildeInPath]]autorelease]];
    [secondImageOn setImage:[[[NSImage alloc]initWithContentsOfFile:[secondImageOnPath stringByExpandingTildeInPath]]autorelease]];
    [thirdImageOff setImage:[[[NSImage alloc]initWithContentsOfFile:[thirdImageOffPath stringByExpandingTildeInPath]]autorelease]];
    [thirdImageOn setImage:[[[NSImage alloc]initWithContentsOfFile:[thirdImageOnPath stringByExpandingTildeInPath]]autorelease]];
    [fourImageOff setImage:[[[NSImage alloc]initWithContentsOfFile:[fourImageOffPath stringByExpandingTildeInPath]]autorelease]];
    [fourimageOn setImage:[[[NSImage alloc]initWithContentsOfFile:[fourImageOnPath stringByExpandingTildeInPath]]autorelease]];
    if ([smallIcon image]!= nil) {
        [smallIconText setHidden:YES];
        [smallIconSecondText setHidden:YES];
    }
    else
    {
        [smallIconText setHidden:NO];
        [smallIconSecondText setHidden:NO];

    }
    if ([bigIcon image] != nil) {
        [bigIconText setHidden:YES];
        [bigIconSecondText setHidden:YES];
    }
    else
    {
        [bigIconText setHidden:NO];
        [bigIconSecondText setHidden:NO];  
    }
    
    [folders release]; 
    [URL release]; 
    
}

-(void)addAnApp:(id)sender
{
    RAPlistManager *listManager = [[RAPlistManager alloc]init];
    [listManager writeToPlistWithAppName:@"New app" folderName:@"Set the folder name" withURL1:@"URL1" URL2:@"URL2" URL3:@"URL3" URL4:@"URL4" atIndex:[tableview numberOfRows] +1];
     [listManager release]; 
    [tableview selectRowIndexes:[NSIndexSet indexSetWithIndex:[tableview numberOfRows]] byExtendingSelection:NO];
     [tableview reloadData];
}

-(void)saveApp:(id)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *applicationSupport = [[NSString stringWithFormat:application_support_path@"%@", [folderNameField stringValue]] stringByExpandingTildeInPath];
    //Check if exist, if not create the dir
    if ([fileManager fileExistsAtPath:applicationSupport] == NO)
        [fileManager createDirectoryAtPath:applicationSupport withIntermediateDirectories:YES attributes:nil error:nil];

    [[[firstImageOn image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/1_on.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[firstImageOff image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/1_off.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[secondImageOff image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/2_off.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[secondImageOn image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/2_on.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[thirdImageOff image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/3_off.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[thirdImageOn image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/3_on.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[fourImageOff image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/4_off.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[fourimageOn image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/4_on.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[smallIcon image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/main.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    [[[bigIcon image] TIFFRepresentation] writeToFile:[[NSString stringWithFormat:application_support_path@"%@/main_big.png", [folderNameField stringValue]]stringByExpandingTildeInPath] atomically:YES];
    RAPlistManager *listManager = [[RAPlistManager alloc]init];
    [listManager writeToPlistWithAppName:[appNameField stringValue] folderName:[folderNameField stringValue] withURL1:[firstUrl stringValue] URL2:[secondUrl stringValue] URL3:[thirdUrl stringValue] URL4:[fourUrl stringValue] atIndex:[tableview selectedRow]];
    [listManager release]; 
    [tableview reloadData];

}

-(void)deleteAnApp:(id)sender
{
    if ([tableview selectedRow] == -1) {
        [self selectRowSheet];
    }
    else
    {
    RAPlistManager *listManager = [[RAPlistManager alloc]init];
    [listManager deleteAppAtIndex:[tableview selectedRow]];
    [listManager release]; 
    [tableview reloadData];
    }
}

-(void)openTemplate:(id)sender
{
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace]; 
    [workspace selectFile:templatePath inFileViewerRootedAtPath:templatePath];
    
}

-(void)moveItemUp:(id)sender
{
    if ([tableview selectedRow] == -1) {
        [self selectRowSheet];
    }
    else
    {
    RAPlistManager *listManager = [[RAPlistManager alloc]init];
    [listManager swapObjectAtIndex:[tableview selectedRow] upOrDown:0];
    [tableview reloadData]; 
    [listManager release];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[tableview selectedRow]-1];
    [tableview selectRowIndexes:indexSet byExtendingSelection:NO];
    }
}

-(void)moveItemDown:(id)sender
{
    if ([tableview selectedRow] == -1) {
        [self selectRowSheet];
    }
    else
    {
    RAPlistManager *listManager = [[RAPlistManager alloc]init];
    [listManager swapObjectAtIndex:[tableview selectedRow] upOrDown:1];
    [tableview reloadData]; 
    [listManager release];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[tableview selectedRow]+1];
    [tableview selectRowIndexes:indexSet byExtendingSelection:NO];
    }
}

-(void)exportSelectedApp:(id)sender
{
    if ([tableview selectedRow] == -1) {
        [self selectRowSheet];

    }
    else
    {
        RAPlistManager *listManager = [[RAPlistManager alloc]init];
        [listManager exportAppAtIndex:[tableview selectedRow]];
        [listManager release];
        NSAlert *alert = [[NSAlert alloc]init];
        [alert setMessageText:@"App Exported to your desktop"];
        [alert setInformativeText:@"The application has been exported to your desktop in a bundle format, to share it just zip it and send it"];
        [alert beginSheetModalForWindow:self.window modalDelegate:self didEndSelector:nil contextInfo:nil];
        [alert release];  
    }
   
}

-(void)importSelectedApp:(id)sender
{
    NSOpenPanel *tvarNSOpenPanelObj	= [NSOpenPanel openPanel];
    [tvarNSOpenPanelObj setTitle:@"Please select an application bundle file that have been exported with rSDK"];
    NSInteger tvarNSInteger	= [tvarNSOpenPanelObj runModal];
    if(tvarNSInteger == NSOKButton){
     		
    } else if(tvarNSInteger == NSCancelButton) {
     	
     	return;
    } else {
     	return;
    }  
    
    NSString * tvarDirectory = [[tvarNSOpenPanelObj URL]absoluteString];
    tvarDirectory = [tvarDirectory stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
    RAPlistManager *listManager = [[RAPlistManager alloc]init];
    [listManager importAppAthPath:tvarDirectory];
    [listManager release]; 
    [tableview reloadData];
}

-(void)selectRowSheet
{
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setMessageText:@"Please select a row"];
    [alert beginSheetModalForWindow:self.window modalDelegate:self didEndSelector:nil contextInfo:nil];
    [alert release];
}

-(void)newWindow:(id)sender
{
    [[self window]orderFront:self];
}


@end
