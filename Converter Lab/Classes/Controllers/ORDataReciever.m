//
//  ORDataReciever.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 12.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORDataReciever.h"
#import "ORDataRecieverDelegate.h"

@interface ORDataReciever ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property(nonatomic,strong)NSURLConnection *urlConnection;
@property(nonatomic,strong)NSMutableData *urlData;
@property(nonatomic,strong)NSURL *targetURL;

@end

@implementation ORDataReciever

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

//+(id)getClassInstance{
//    static ORDataReciever* contactData=nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        contactData=[[ORDataReciever alloc]init];
//    });
//    return contactData;
//}

-(void)makeRequest{
    self.targetURL=[NSURL URLWithString:@"http://resources.finance.ua/ru/public/currency-cash.json"];
    [self loadDataWithURL:self.targetURL];
   // NSLog(@"%@ delegate",[self.delegate description]);
}

-(void)loadDataWithURL:(NSURL *)targetURL{
    self.urlData=[NSMutableData new];
    NSURLRequest *request =[NSURLRequest requestWithURL:targetURL];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    self.urlConnection=connection;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.urlData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (self.urlData) {
        
        SEL selector=@selector(didRecieveJSON:);
        NSLog(@"%@ delegate 2",[self.delegate description]);
        if([self.delegate respondsToSelector:selector]){
            [self.delegate didRecieveJSON:self.urlData];
        }else{
            NSLog(@"selector not response");
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    SEL selector=@selector(didFailJSONWithError:);
    if([self.delegate respondsToSelector:selector]){
        
        [self.delegate didFailJSONWithError:error];
    }else{
        NSLog(@"selector not response");
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        int statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode != 200) {
            
            NSLog(@"Status code was %ld, but should be 200.", (long)statusCode);
            NSLog(@"response = %@", response);
        }
    }}


@end
