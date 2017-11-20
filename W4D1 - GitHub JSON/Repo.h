//
//  Repo.h
//  W4D1 - GitHub JSON
//
//  Created by Murat Ekrem Kolcalar on 11/20/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (strong, nonatomic) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
