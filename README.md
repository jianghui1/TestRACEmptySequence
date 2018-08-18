##### `RACEmptySequence`作为`RACSequence`的子类，代表一个空的序列，看下`.m`里面的方法。

完整测试用例[在这里](https://github.com/jianghui1/TestRACEmptySequence)。

***
    + (instancetype)empty {
    	static id singleton;
    	static dispatch_once_t pred;
    
    	dispatch_once(&pred, ^{
    		singleton = [[self alloc] init];
    	});
    
    	return singleton;
    }
类方法，返回一个单例对象。

测试用例：

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
***

    - (id)head {
    	return nil;
    }
    
    - (RACSequence *)tail {
    	return nil;
    }
`head` `tail`返回`nil`值，也就是不包含任何值。

测试用例：

    - (void)test_head_tail
    {
        RACEmptySequence *sequence = [RACEmptySequence empty];
        NSLog(@"head_tail -- %@ -- %@", sequence.head, sequence.tail);
        
        // 打印日志：
        /*
         2018-08-15 17:41:17.702545+0800 TestRACEmptySequence[85320:15393534] head_tail -- (null) -- (null)
         */
    }
***

    - (RACSequence *)bind:(RACStreamBindBlock)bindBlock passingThroughValuesFromSequence:(RACSequence *)passthroughSequence {
    	return passthroughSequence ?: self;
    }
如果`passthroughSequence`存在，返回`passthroughSequence`序列；如果不存在，返回序列自身。

测试用例：

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
***

    - (Class)classForCoder {
    	// Empty sequences should be encoded as themselves, not array sequences.
    	return self.class;
    }
    
    - (id)initWithCoder:(NSCoder *)coder {
    	// Return the singleton.
    	return self.class.empty;
    }
    
    - (void)encodeWithCoder:(NSCoder *)coder {
    }
实现序列化方法。最终还是单例对象。
***

    - (NSString *)description {
    	return [NSString stringWithFormat:@"<%@: %p>{ name = %@ }", self.class, self, self.name];
    }
格式化输出日志。
***

    - (NSUInteger)hash {
    	// This hash isn't ideal, but it's better than -[RACSequence hash], which
    	// would just be zero because we have no head.
    	return (NSUInteger)(__bridge void *)self;
    }
实现`hash`值的返回。
***

    - (BOOL)isEqual:(RACSequence *)seq {
    	return (self == seq);
    }
实现实例的判断逻辑。
***

##### 综上，这个类其实就是一个空类，并且是个单例对象。
