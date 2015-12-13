//
//  AppDelegate.m
//  iTunes Artwork Grabber
//
//  Created by Chris Fletcher on 12/6/15.
//  Copyright © 2015 Chris Fletcher. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, retain) API *searchAPI;
@property (nonatomic, retain) NSDictionary *countries;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
     _countries = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"]];
    _countriesCombo = [NSMutableArray arrayWithArray:[self countriesList]];
    _filteredCountriesCombo = [[NSMutableArray alloc] initWithArray:_countriesCombo];
    
    _selectBoxCountry.dataSource = self;
    _selectBoxCountry.delegate = self;
    
    
    [_selectBoxCountry addItemsWithObjectValues:[self countriesList]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)search:(id)sender {
    
    _searchAPI = [API searchWithTerm:_searchText.stringValue country:[self countryCodeForCountry:_selectBoxCountry.selectedCell.stringValue] andEntity:kEntity_TVSeason];
    _searchAPI.delegate = self;
}

- (void)searchDidComplete:(API *)sender error:(NSError *)error {
    
    if (error) {
        
        NSLog(@"Error: %@", [error localizedDescription]);
        
    } else {
    
        NSLog(@"%@",[_searchAPI formattedResult]);
    }
}

- (NSString *)countryCodeForCountry:(NSString *)countryName {
    
    return [_countries objectForKey:countryName];
}

- (NSArray *)countriesList {
    
    NSMutableArray *returnArray = [NSMutableArray array];
    
    for (NSString *key in _countries) {
        
        [returnArray addObject:key];
    }
    
    return [returnArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    
    return _filteredCountriesCombo.count;
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    
    return _filteredCountriesCombo[index];
}

- (NSUInteger)comboBox:(NSComboBox *)aComboBox indexOfItemWithStringValue:(NSString *)string {
    
    return [_filteredCountriesCombo indexOfObject:string];
}

- (void)comboBoxWillPopUp:(NSNotification *)notification {
    
    [self resultsInCOmboForString:((NSComboBox *)[notification object]).stringValue];
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
    
    NSComboBox *comboBox = (NSComboBox *)control;
    
    if (comboBox == _selectBoxCountry && (commandSelector == @selector(insertNewline:) || commandSelector == @selector(insertBacktab:) || commandSelector == @selector(insertTab:))) {
        
        if ([self resultsInCOmboForString:comboBox.stringValue].count == 0 || _filteredCountriesCombo.count == _countriesCombo.count) {
            
            comboBox.stringValue = _countriesCombo[0];
        }
    }
    
    return NO;
}

- (NSString *)comboBox:(NSComboBox *)aComboBox completedString:(NSString *)string {
    
    NSArray *currentList = [NSArray arrayWithArray:_countriesCombo];
    
    NSEnumerator *theEnum = [currentList objectEnumerator];
    id eachString;
    NSInteger maxLength = 0;
    NSString *bestMatch = @"";
    
    while (nil != (eachString = [theEnum nextObject])) {
        
        NSString *commonPrefix = [eachString commonPrefixWithString:string options:NSCaseInsensitiveSearch];
        
        if (commonPrefix.length >= string.length && commonPrefix.length > maxLength) {
            
            maxLength = commonPrefix.length;
            bestMatch = eachString;
            
            break;
        }
    }
    
    [self resultsInCOmboForString:string];
    
    return bestMatch;
}

- (NSArray *)resultsInCOmboForString:(NSString *)string {
    
    [_filteredCountriesCombo removeAllObjects];
    
    if (string.length == 0 || [string isEqualToString:@""] || [string isEqualToString:@" "]) {
        
        [_filteredCountriesCombo addObjectsFromArray:_countriesCombo];
    
    } else {
        
        for (int i = 0; i < _countriesCombo.count; i++) {
            
            NSRange searchName = [_countriesCombo[i] rangeOfString:string options:NSCaseInsensitiveSearch];
            if (searchName.location != NSNotFound) {
                
                [_filteredCountriesCombo addObject:_countriesCombo[i]];
            }
        }
    }
    
    [_selectBoxCountry reloadData];
    
    return _filteredCountriesCombo;
}

@end
