//
//  MMCardController.m
//  DeckOfOneCard-C
//
//  Created by Mitch Merrell on 8/20/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import "MMCardController.h"
#import "MMCard.h"

@implementation MMCardController

+ (MMCardController *) shared {
    static MMCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [MMCardController new];
    });
    return shared;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/9ceopuf5iw4v/draw/"];
}

- (void)drawNewCard:(NSInteger)count completion:(void (^)(NSArray<MMCard *> * _Nullable))completion
{
    NSString *cardCount = [@(count) stringValue];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[MMCardController baseURL] resolvingAgainstBaseURL:true];
    NSURLQueryItem *countQueryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    components.queryItems = @[countQueryItem];
    NSURL *finalURL = components.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error %@: %@", error, error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) { completion(nil); return; }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *cardsArray = topLevelDictionary[@"cards"];
        NSMutableArray *cards = [[NSMutableArray alloc] init];
        
        for (NSDictionary *cardDict in cardsArray) {
            MMCard *newCard = [[MMCard alloc] initWithDictionary:cardDict];
            [cards addObject:newCard];
        }
        
        completion(cards);
    }]resume];
    
}

- (void)fetchImage:(MMCard *)card completion:(void (^)(UIImage *image))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.image];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error %@: %@", error, error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) { completion(nil); return; }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
    }]resume];
}

@end
