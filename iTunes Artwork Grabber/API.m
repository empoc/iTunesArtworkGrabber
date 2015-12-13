//
//  API.m
//  MetaTool
//
//  Created by Chris Fletcher on 12/3/15.
//  Copyright © 2015 Chris Fletcher. All rights reserved.
//

#import "API.h"

@interface API ()

@property (nonatomic, retain) NSDictionary *responseDictionary;

@end

@implementation API

@synthesize delegate;

#pragma mark - Delegate Methods

- (void)searchFinishedWithError:(NSError *)error {
    
    [self.delegate searchDidComplete:self error:error];

}


+ (id)searchWithTerm:(NSString *)term country:(NSString *)country andEntity:(NSString *)entity {
    
    return [[self alloc] initWithTerm:term country:country andEntity:entity];
}

- (id)initWithTerm:(NSString *)term country:(NSString *)country andEntity:(NSString *)entity {

    //- Initialize the class
   
    
        //- Perform a search
        NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&country=%@&entity=%@",kiTunesURL,term,country,entity]];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:[[NSURLRequest alloc] initWithURL:searchURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error) {
                
                //- Handle the error
                [self searchFinishedWithError:error];
                
            } else {
                
                //- Parse and Store the data
                NSError *parseError = nil;
                self.responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                if (parseError) {
                    
                    //- Handle Error
                    [self searchFinishedWithError:parseError];
                
                } else {
                    
                    [self searchFinishedWithError:nil];
                }
            }
        }] resume];
        
        return self;

}

- (NSDictionary *)parsedResult {
    
    return self.responseDictionary;
}

- (NSArray *)formattedResult {
    
    NSArray *results = [[self parsedResult] objectForKey:@"results"];
    NSMutableArray *formattedResultArray = [NSMutableArray array];
    
    for (int i = 0; i < [results count]; i++) {
        
        NSString *artwork100Url = [[results objectAtIndex:i] objectForKey:@"artworkUrl100"];
        NSString *artwork600Url = [artwork100Url stringByReplacingOccurrencesOfString:@"100x100" withString:@"600x600"];
        NSString *artworkHiResUrl = [artwork100Url stringByReplacingOccurrencesOfString:@"100x100bb" withString:@"100000x100000-999"];
        NSString *title = [[results objectAtIndex:i] objectForKey:@"collectionName"];
        
        NSDictionary *resultDict = [NSDictionary dictionaryWithObjectsAndKeys:artwork600Url, kArtworkStandardURL, artworkHiResUrl, kArtworkHiResURL, title, kTitle, nil];
        
        [formattedResultArray addObject:resultDict];
    }
    
    return formattedResultArray;
}




@end
