//
//  NSDictionary+Add.m
//  portal
//
//  Created by Store on 2017/8/30.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "NSDictionary+Add.h"

@implementation NSDictionary (Add)
- (NSString*)DicToJsonstr{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (NSString*)dictionaryToJsonForH5{
    //    NSError *parseError = nil;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    //    NSString *tmp = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    return tmp;
    if (![self allKeys].count) {
        return @"{}";
    }
    NSString *strTT1 = [NSString stringWithFormat:@"%@",[self description]];
    
    NSString *strTT21 = [strTT1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSString *strTT2 = [strTT21 stringByReplacingOccurrencesOfString:@"\n" withString:@"\""];
    
    NSString *strTT3 = [strTT2 stringByReplacingOccurrencesOfString:@" = " withString:@"\":\""];
    
    NSString *strTT4 = [strTT3 stringByReplacingOccurrencesOfString:@";" withString:@"\","];
    
    NSString *strTT5 = [strTT4 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *strTT6 = [strTT5 stringByReplacingOccurrencesOfString:@"\\U" withString:@"%u"];
    
    NSString *strTT7 = [strTT6 stringByReplacingOccurrencesOfString:@",\"}" withString:@"}"];
    
    NSString *strTT8 = [strTT7 stringByReplacingOccurrencesOfString:@"\"(\"" withString:@"["];
    
    NSString *strTT9 = [strTT8 stringByReplacingOccurrencesOfString:@"\")\"" withString:@"]"];
    
    NSString *strTT10 = [strTT9 stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    
    NSString *strTT11 = [strTT10 stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    
    NSString *strTT12 = [strTT11 stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    return strTT12;
}

-(NSString*)ToUrl{
    if (self) {
        NSString *url = @"?";
        for (NSString *tmp in self.allKeys) {
            if (self[tmp]) {
                url = [url stringByAppendingString:tmp];
                url = [url stringByAppendingString:@"="];
                if ([self[tmp] isKindOfClass:[NSNumber class]]) {
                    url = [url stringByAppendingString:[self[tmp] string]];
                } else if ([self[tmp] isKindOfClass:[NSString class]]){
                    url = [url stringByAppendingString:self[tmp]];
                }
                if (![tmp isEqual:self.allKeys.lastObject]) {
                    url = [url stringByAppendingString:@"&"];
                }
            }
        }
        return url;
    } else {
        return @"";
    }
    return nil;
}
@end
