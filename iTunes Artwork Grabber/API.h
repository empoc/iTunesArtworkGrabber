//
//  API.h
//  MetaTool
//
//  Created by Chris Fletcher on 12/3/15.
//  Copyright © 2015 Chris Fletcher. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kiTunesURL @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term="

#define kEntity_TVSeason @"tvSeason"
#define kEntity_Movie @"movie"
#define kEntity_Ebook @"ebook"
#define kEntity_Album @"album"
#define kEntity_App @"software"
#define kEntity_AudioBook @"audiobook"
#define kEntity_Podcast @"podcast"
#define kEntity_MusicVideo @"musicVideo"
#define kEntity_ShortFilm @"shortFilm"

@interface API : NSObject

+ (id)searchWithTerm:(NSString *)term country:(NSString *)country andEntity:(NSString *)entity;
- (id)initWithTerm:(NSString *)term country:(NSString *)country andEntity:(NSString *)entity;

- (NSArray *)result;

@end
