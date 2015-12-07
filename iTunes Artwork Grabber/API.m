//
//  API.m
//  MetaTool
//
//  Created by Chris Fletcher on 12/3/15.
//  Copyright © 2015 Chris Fletcher. All rights reserved.
//

#import "API.h"

@interface API ()

@property (nonatomic, retain) NSMutableArray *resultArray;

@end

@implementation API


+ (id)searchWithTerm:(NSString *)term country:(NSString *)country andEntity:(NSString *)entity {
    
    return [[self alloc] initWithTerm:term country:country andEntity:entity];
}

- (id)initWithTerm:(NSString *)term country:(NSString *)country andEntity:(NSString *)entity {
    
    if ([self init]) {
        
        //- Initialize the class
        
        //- Perform a search
        NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&country=%@&entity=%@",kiTunesURL,term,country,entity]];
        
        [[NSURLSession sharedSession] dataTaskWithRequest:[[NSURLRequest alloc] initWithURL:searchURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           
            if (error) {
                
                //- Handle the error
                
            } else {
                
                //- Parse and Store the data
                
                
            }
        }];
        
        //- Store the result
        
        
        return self;
    }
    
    return NULL;
}

- (NSArray *)result {
    
    return self.resultArray;
}

@end
