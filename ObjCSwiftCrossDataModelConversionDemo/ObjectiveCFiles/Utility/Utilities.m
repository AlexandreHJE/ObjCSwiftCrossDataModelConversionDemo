//
//
// Utilities.m
// ObjCSwiftCrossDataModelConversionDemo
//
// Created by Alexandre Hu (HU JEN EN) on 2021/7/30
// Copyright © 2021 Alexandre Hu. All rights reserved.
//
        

#import "Utilities.h"
#import "NSError+MessageError.h"
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <sys/utsname.h>


@implementation Utils


typedef enum {
    
    XJsonValidFailed        = 101,
    XJsonParseFailed        = 102,
    XJsonParseGetErrorCode  = 103,
    XJsonDecodeFailed       = 104,
    XJsonDecodeGetErrorCode = 105,
    
}JSONError;


+(NSString *)getErrorMessage:(NSString *)pDesc code:(NSString *)pCode{
    
    return [NSString stringWithFormat:@"(%@) %@",  pCode ,pDesc];
}



#pragma mark -  ＪＳＯＮ

+(NSString *) json_encode: (NSDictionary *)dict error:(NSError **)error
{
    
    //NSError *error = nil;
    
    if([NSJSONSerialization isValidJSONObject:dict] == NO)
    {
        *error = [[NSError alloc] initWithCode:XJsonValidFailed message:@"資料格式錯誤！"];
        return nil;
    }
    
    NSData *makeJsonData = nil;
    NSError *jErr = nil;
    
    @try {
        makeJsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&jErr];
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithCode:XJsonParseFailed message:[exception reason]];
        
        
    }
    @finally {
        if(jErr != nil){
            *error = [[NSError alloc] initWithCode:XJsonParseGetErrorCode message:[jErr localizedDescription]];
        }
    }
    //若有Error
    if (*error != nil) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:makeJsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+(NSString *) json_encodeWithObj: (id)obj error:(NSError **)error
{
    
    //NSError *error = nil;
    
    if([NSJSONSerialization isValidJSONObject:obj] == NO)
    {
        *error = [[NSError alloc] initWithCode:XJsonValidFailed message:@"資料格式錯誤！"];
        return nil;
    }
    
    NSData *makeJsonData = nil;
    NSError *jErr = nil;
    
    @try {
        makeJsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&jErr];
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithCode:XJsonParseFailed message:[exception reason]];
        
        
    }
    @finally {
        if(jErr != nil){
            *error = [[NSError alloc] initWithCode:XJsonParseGetErrorCode message:[jErr localizedDescription]];
        }
    }
    //若有Error
    if (*error != nil) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:makeJsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}



+(NSDictionary *) json_decode : (NSString *)str error:(NSError **)error
{
    if ( !str ) {
        return nil;
    }
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *obj = nil;
    NSError *jErr = nil;
    
    @try {
        obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:error];
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithCode:XJsonDecodeFailed message:[exception reason]];
    }
    @finally {
        if(jErr != nil){
            *error = [[NSError alloc] initWithCode:XJsonDecodeGetErrorCode message:[jErr localizedDescription]];
        }
    }
    
    return obj;
}

+(BOOL)isJBDevice {
    

    //step 1 check cydia.app--------------------------------------------
//    NSLog(@"isJBDevice !!!!!!!!!!!!!!!!!!!");
    
    if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]] ){
        return YES;
    }
    
    
    //step 2  try to read applications--------------------------------------------
    if([[NSFileManager defaultManager]fileExistsAtPath:@"/User/Applications/"]) {
        
        //        NSArray *applist=[[NSFileManager defaultManager]contentsOfDirectoryAtPath:@"/User/Applications/" error:nil];
        //        NSLog(@"step 2 .YES JB 我可以讀app list");
        //        NSLog(@"applist:%@",applist);
        
        return YES;
    }else{
//        NSLog(@"step 2 .NO 我不能讀app list");
    }
    
    
    //step3 maybe hook NSFileManager , use stat to check cydia---------------------
    struct stat stat_info;
    if( 0 == stat("/Applications/Cydia.app",&stat_info)){
        //NSLog(@"step 3 .YES JB 用stat去查Cydia，裝了");
        return YES;
    }
    
    //step 4 maybe hook stat , check stat from where---------------------------------
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *)=stat;
    if((ret=dladdr(func_stat,&dylib_info))){
        
        NSString *path=[NSString stringWithFormat:@"%s",dylib_info.dli_fname];

        if( ![path isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]){
            
            struct utsname systemInfo;
            uname(&systemInfo);
            
            NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
            
            if( !( [platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"] ) ){
                return YES;
            }
//            NSLog(@"step 4 ,platform:%@",platform);
        }
        
    }
  
    //step 5 check動態庫 , JB have  /Library/MobileSubstrate/MobileSubstrate.dylib--------------
    uint32_t count=_dyld_image_count();
    
    for(uint32_t i=0; i<count; ++i){
        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
        //NSLog(@"step 5 :%@",name);
        if([name isEqualToString:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
            //NSLog(@"step 5 ,YES ,動態庫中了:%@",name);
            return YES;
        }
//        NSLog(@"step 5 , name:%@",name);
    }
   
    return NO;
}

@end
