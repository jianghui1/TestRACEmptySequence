//
//  TestRACEmptySequenceTests.m
//  TestRACEmptySequenceTests
//
//  Created by ys on 2018/8/15.
//  Copyright © 2018年 ys. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <ReactiveCocoa.h>
#import <RACEmptySequence.h>

@interface TestRACEmptySequenceTests : XCTestCase

@end

@implementation TestRACEmptySequenceTests

- (void)test_empty
{
    RACEmptySequence *eSequence = [RACEmptySequence empty];
    RACEmptySequence *eSequence1 = [RACEmptySequence empty];
    
    NSLog(@"empty -- %@ -- %@", eSequence, eSequence1);
    
    // 打印日志；
    /*
     2018-08-15 17:27:51.484859+0800 TestRACEmptySequence[84787:15354391] empty -- <RACEmptySequence: 0x604000016500>{ name =  } -- <RACEmptySequence: 0x604000016500>{ name =  }
     */
}

- (void)test_head_tail
{
    RACEmptySequence *sequence = [RACEmptySequence empty];
    NSLog(@"head_tail -- %@ -- %@", sequence.head, sequence.tail);
    
    // 打印日志：
    /*
     2018-08-15 17:41:17.702545+0800 TestRACEmptySequence[85320:15393534] head_tail -- (null) -- (null)
     */
}

- (void)test_bind
{
    RACEmptySequence *eSequence = [RACEmptySequence empty];
    
    NSLog(@"bind -- %@", [eSequence bind:^RACStreamBindBlock{
        return ^(id value, BOOL *stop) {
            return [RACStream empty];
        };
    }]);
    
    // 打印日志：
    /*
     2018-08-15 18:12:00.895692+0800 TestRACEmptySequence[86589:15487073] bind -- <RACEmptySequence: 0x60000000a8f0>{ name =  }
     */
}


@end
