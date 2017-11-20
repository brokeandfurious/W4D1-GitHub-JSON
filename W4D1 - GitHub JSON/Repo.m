//
//  Repo.m
//  W4D1 - GitHub JSON
//
//  Created by Murat Ekrem Kolcalar on 11/20/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = dict[@"name"];
    }
    
    return self;
}

@end
