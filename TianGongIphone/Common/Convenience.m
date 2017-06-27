

#import "Convenience.h"
//NSColor NSFont Text
NSMutableAttributedString *attribStringWithAttribs(NSArray *array) {
    @try {
        NSMutableString *s = [[NSMutableString alloc] init];
        for (NSDictionary *dict in array) {
            [s appendString:[dict objectForKey:@"Text"]];
        }
        NSMutableAttributedString *textLabelStr = [[NSMutableAttributedString alloc]
                                                   initWithString:s];
        NSUInteger location = 0;
        for (NSDictionary *dict in array) {
            NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithDictionary:dict];
            NSString *string = [d objectForKey:@"Text"];
            [d removeObjectForKey:@"Text"];
            [textLabelStr setAttributes:d
                                  range:NSMakeRange(location, [string length])];
            location = location + [string length];
        }
        return textLabelStr;

    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
    @finally {
        
    }
}
