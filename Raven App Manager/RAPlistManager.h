//
//  RAPlistManager.h
//  Raven App Manager
//
//  Created by Thomas Ricouard on 17/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAPlistManager : NSObject{
    
}

-(void)writeToPlistWithAppName:(NSString *)appname folderName:(NSString *)folderName 
                      withURL1:(NSString *)URL1 
                          URL2:(NSString *)URL2 
                          URL3:(NSString *)URL3 
                          URL4:(NSString *)URL4 
                       atIndex:(NSInteger)index
                      withUdid:(NSString *)udid
                    withState:(NSNumber *)state
                    withCategory:(NSString *)category
                    withOfficialState:(NSString *)official;
                        

-(void)deleteAppAtIndex:(NSInteger)index;
-(void)swapObjectAtIndex:(NSInteger)index upOrDown:(NSInteger)order;
-(void)exportAppAtIndex:(NSInteger)index; 
-(void)importAppAthPath:(NSString *)path;
-(void)updateProcess;
-(void)changeStateOfAppAtIndex:(NSInteger)index withState:(NSInteger)state;
-(NSInteger)returnStateOfAppAtIndex:(NSInteger)index;
@end
