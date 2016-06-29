//
//  PPComToken.m
//  PPComLib
//
//  Created by PPMessage on 3/31/16.
//  Copyright © 2016 Yvertical. All rights reserved.
//

#import "PPComToken.h"

#import "PPCom.h"
#import "PPFastLog.h"
#import "PPComUtils.h"

#define PPCOMTOKEN_ENABLE_LOG 1

@interface PPComToken ()

@property (nonatomic) PPCom *client;
@property (nonatomic) NSString *cachedAccessToken;

@end

@implementation PPComToken

+ (instancetype)tokenWithClient:(PPCom *)client {
    return [[self alloc] initWithClient:client];
}

- (instancetype)initWithClient:(PPCom *)client {
    if (self = [super initWithClient:client]) {
        self.client = client;
    }
    return self;
}

- (void)getPPComTokenWithBlock:(PPComTokenCompletedBlock)block {
    NSString *localCacheAccessToken = self.cachedAccessToken;
    if (localCacheAccessToken) {
        if (PPCOMTOKEN_ENABLE_LOG) PPFastLog(@"fetch access token from local : %@", localCacheAccessToken);
        if (block) block(localCacheAccessToken, nil, YES);
        return;
    }
    
    NSString *requestUrl = [self tokenRequestUrl];
    NSString *params = [self tokenParam];
    [self baseAsyncPost:requestUrl withParam:params config:^(NSMutableURLRequest *request) {
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
    } completed:^(NSDictionary *response, NSError *error) {
        
        NSString *accessToken = nil;
        if (!error) {
            accessToken = response[@"access_token"];
            // cache access_token
            self.cachedAccessToken = accessToken;
        }
        if (block) block(accessToken, error, error == nil);
        
    }];
}

#pragma mark - helpers

- (NSString*)tokenRequestUrl {
    return [NSString stringWithFormat:@"%@/token", PPAuthHost];
}

- (NSString*)tokenParam {
    return [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=client_credentials", PPApiKey, PPApiSecret];
}

@end
