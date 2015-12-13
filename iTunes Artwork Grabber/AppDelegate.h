//
//  AppDelegate.h
//  iTunes Artwork Grabber
//
//  Created by Chris Fletcher on 12/6/15.
//  Copyright © 2015 Chris Fletcher. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "API.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, APIDelegate, NSComboBoxDelegate, NSComboBoxDataSource, NSControlTextEditingDelegate>

@property (nonatomic, retain) IBOutlet NSTextField *searchText;
@property (nonatomic, retain) IBOutlet NSComboBox *selectBoxCountry;
@property (nonatomic, retain) IBOutlet NSPopUpButton *selectBoxType;

@property (nonatomic, retain) NSMutableArray *countriesCombo;
@property (nonatomic, retain) NSMutableArray *filteredCountriesCombo;

- (IBAction)search:(id)sender;


@end

