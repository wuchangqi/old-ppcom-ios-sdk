//
//  PPConversationsViewControllerTableViewController.h
//  PPComLib
//
//  Created by PPMessage on 4/1/16.
//  Copyright © 2016 Yvertical. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPConversationsViewController : UITableViewController

#pragma mark - Initialize Methods

/*
 * Initialize app info, api info, user info.
 * options include:
 
 * 1. appUUID:   your team uuid, required
 * 2. apiKey:    your ppcom api key, required
 * 3. apiSecret: your ppcom api secret, required
 * 4. host:      server url, such as: "https://ppmessage.com", required
 * 5. email:     user email, optional, if not provided, current user is an annoymous user.
 *
 */
- (void) initialize:(NSDictionary *)options;

/**
 * Release resources when press `close` button at the left-side
 */
- (void)releaseResources;

@end
