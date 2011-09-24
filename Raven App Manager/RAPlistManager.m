//
//  RAPlistManager.m
//  Raven App Manager
//
//  Created by Thomas Ricouard on 17/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RAPlistManager.h"

@implementation RAPlistManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)writeToPlistWithAppName:(NSString *)appname folderName:(NSString *)folderName 
                      withURL1:(NSString *)URL1 URL2:(NSString *)URL2 URL3:(NSString *)URL3 URL4:(NSString *)URL4 atIndex:(NSInteger)index
{
    NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    if (index > [folders count]) {
        NSMutableArray *URLs = [[NSMutableArray alloc]initWithCapacity:4];
        NSMutableDictionary *newapp= [[NSMutableDictionary alloc]initWithCapacity:3];
        [newapp setObject:appname forKey:PLIST_KEY_APPNAME];
        [newapp setObject:folderName forKey:PLIST_KEY_FOLDER];
        [URLs addObject:URL1];
        [URLs addObject:URL2];
        [URLs addObject:URL3];
        [URLs addObject:URL4];
        [newapp setObject:URLs forKey:PLIST_KEY_URL];
        [folders addObject:newapp];
        [dict setObject:folders forKey:PLIST_KEY_DICTIONNARY];
        [dict writeToFile:path atomically:YES];
        [URLs release]; 
        [newapp release]; 
        [folders release]; 
    }
    else
    {
        NSMutableDictionary *item = [folders objectAtIndex:index];
        NSMutableArray *URL = [item objectForKey:PLIST_KEY_URL];
        [item setObject:appname forKey:PLIST_KEY_APPNAME]; 
        [item setObject:folderName forKey:PLIST_KEY_FOLDER]; 
        [URL removeAllObjects]; 
        [URL addObject:URL1]; 
        [URL addObject:URL2]; 
        [URL addObject:URL3]; 
        [URL addObject:URL4]; 
        [item setObject:URL forKey:PLIST_KEY_URL]; 
        [dict writeToFile:path atomically:YES];
        [folders release]; 
        
        
        
    }
    
    
    
}

-(void)swapObjectAtIndex:(NSInteger)index upOrDown:(NSInteger)order
{
    NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    if (order == 1 && index+1 < [folders count]) {
        id tempA = [folders objectAtIndex:index];
        id tempB = [folders objectAtIndex:index + 1];
        [folders replaceObjectAtIndex:index withObject:tempB];
        [folders replaceObjectAtIndex:index+1 withObject:tempA];
    }
    else if (order == 0 && index > 0)
    {
        id tempA = [folders objectAtIndex:index];
        id tempB = [folders objectAtIndex:index - 1];
        [folders replaceObjectAtIndex:index withObject:tempB];
        [folders replaceObjectAtIndex:index-1 withObject:tempA];
    }
    [dict setObject:folders forKey:PLIST_KEY_DICTIONNARY];
    [dict writeToFile:path atomically:YES];
    [folders release];
    
}

-(void)deleteAppAtIndex:(NSInteger)index
{
    NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    NSMutableDictionary *appToDelete = [folders objectAtIndex:index];
    NSString *folderName = [appToDelete objectForKey:PLIST_KEY_FOLDER];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[[NSString stringWithFormat:application_support_path@"%@", folderName]stringByExpandingTildeInPath] error:nil];
    [folders removeObjectAtIndex:index];
    [dict setObject:folders forKey:PLIST_KEY_DICTIONNARY];
    [dict writeToFile:path atomically:YES];
    [folders release]; 

}

-(void)exportAppAtIndex:(NSInteger)index
{
    NSString *path = [PLIST_PATH stringByExpandingTildeInPath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *folders = [[dict objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    NSMutableDictionary *toSave = [folders objectAtIndex:index];
    
    
    NSString *appFolder = [toSave objectForKey:PLIST_KEY_FOLDER];
    NSString *applicationSupportPath = [[NSString stringWithFormat:application_support_path@"%@", appFolder]stringByExpandingTildeInPath];
    NSString *desktopPath = [[NSString stringWithFormat:@"~/Desktop/RAvenApp_%@.bundle", appFolder] stringByExpandingTildeInPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writePath = [[NSString stringWithFormat:@"%@/app.plist", desktopPath]stringByExpandingTildeInPath];
    [fileManager copyItemAtPath:applicationSupportPath toPath:desktopPath error:nil];
    [toSave writeToFile:writePath atomically:YES];
    [folders release];
}

-(void)importAppAthPath:(NSString *)path
{
    NSString *realPath = [NSString stringWithFormat:@"%@/app.plist", path];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:realPath];
    NSString *appFolder = [dict objectForKey:PLIST_KEY_FOLDER];
    NSString *appPlist = [PLIST_PATH stringByExpandingTildeInPath];
    NSMutableDictionary *dictToEdit = [NSMutableDictionary dictionaryWithContentsOfFile:appPlist];
    NSMutableArray *folders = [[dictToEdit objectForKey:PLIST_KEY_DICTIONNARY] mutableCopy];
    [folders addObject:dict];
    [dictToEdit setObject:folders forKey:PLIST_KEY_DICTIONNARY];
    [dictToEdit writeToFile:appPlist atomically:YES];
    
    [folders release];
    NSString *applicationSupportPath = [[NSString stringWithFormat:application_support_path@"%@", appFolder]stringByExpandingTildeInPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager copyItemAtPath:path toPath:applicationSupportPath error:nil];
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/app.plist", applicationSupportPath] error:nil];

}



@end
