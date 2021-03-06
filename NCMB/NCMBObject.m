/*******
 Copyright 2014 NIFTY Corporation All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 **********/

#import "NCMB.h"

#import "NCMBURLConnection.h"

#import "NCMBSetOperation.h"
#import "NCMBIncrementOperation.h"
#import "NCMBAddOperation.h"
#import "NCMBAddUniqueOperation.h"
#import "NCMBRemoveOperation.h"
#import "NCMBDeleteOperation.h"

#import "SubClassHandler.h"
#import <objc/runtime.h>


#pragma mark - getter
//プロパティの型ごとに設定

static id dynamicGetter(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    return [result valueForKey:name];
}

static int dynamicGetterInt(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    int i = [(NSNumber*)[result valueForKey:name] intValue];
    return i;
}

static float dynamicGetterFloat(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    float f = [(NSNumber*)[result valueForKey:name] floatValue];
    return f;
}

static BOOL dynamicGetterBOOL(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    BOOL flag = [(NSNumber*)[result valueForKey:name] boolValue];
    return flag;
}

static double dynamicGetterDouble(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    double d = [(NSNumber*)[result valueForKey:name] doubleValue];
    return d;
}

static double dynamicGetterLong(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    long int l = [(NSNumber*)[result valueForKey:name] longValue];
    return l;
}

static short dynamicGetterShort(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    short s = [(NSNumber*)[result valueForKey:name] shortValue];
    return s;
}

static double dynamicGetterLongLong(id self, SEL _cmd) {
    id result = nil;
    NSString* name = NSStringFromSelector(_cmd);
    result = [self valueForKey:@"estimatedData"];
    long long int ll = [(NSNumber*)[result valueForKey:name] longLongValue];
    return ll;
}
#pragma mark - setter
//プロパティの型ごとに設定
static void dynamicSetter(id self, SEL _cmd, id value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    [self setObject:value forKey:name];
}

static void dynamicSetterInt(id self, SEL _cmd, int value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithInt:value];
    [self setObject:num forKey:name];
}


static void dynamicSetterFloat(id self, SEL _cmd, float value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithFloat:value];
    [self setObject:num forKey:name];
}

static void dynamicSetterBOOL(id self, SEL _cmd, BOOL value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithBool:value];
    [self setObject:num forKey:name];
}

static void dynamicSetterDouble(id self, SEL _cmd, double value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithDouble:value];
    [self setObject:num forKey:name];
}

static void dynamicSetterLong(id self, SEL _cmd, long int value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithLong:value];
    [self setObject:num forKey:name];
}
static void dynamicSetterShort(id self, SEL _cmd, short value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithShort:value];
    [self setObject:num forKey:name];
}
static void dynamicSetterLongLong(id self, SEL _cmd, long long int value) {
    NSString *setter    = NSStringFromSelector(_cmd);
    NSString *name  = [[[setter substringWithRange:NSMakeRange(3, 1)] lowercaseString]
                       stringByAppendingString:[setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
    NSNumber *num = [NSNumber numberWithLongLong:value];
    [self setObject:num forKey:name];
}

@implementation NCMBObject

#pragma mark - Subclass
+ (id)object{
    id object = [[[self class] alloc] initWithClassName:[[self class] ncmbClassName]];
    return object;
}
+ (id)objectWithoutDataWithObjectId:(NSString *)objectId{
    id object = [[[self class] alloc] init];
    [object setObjectId:objectId];
    
    return object;
}

+ (NCMBQuery *)query{
    NCMBQuery *query = [NCMBQuery queryWithClassName:[[self class] ncmbClassName]];
    return query;
}

+ (void)registerSubclass{
    
    [Subclass_Handler setSubClassName:NSStringFromClass([self class]) ncmbClassName:[[self class] ncmbClassName]];
    unsigned int i, count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char* attrs = property_getAttributes(property);
        NSArray *k = [[NSString stringWithUTF8String:attrs] componentsSeparatedByString:@","];
        if ([k containsObject:@"D"]){

            const char *propName = property_getName(property);
            if(propName) {
                NSString *propertyName = [NSString stringWithUTF8String:propName];
                
                NSString *getterName = propertyName;
                NSString *setterName = [NSString stringWithFormat:@"set%@%@:",
                                        [[propertyName substringToIndex:1] uppercaseString],
                                        [propertyName substringFromIndex:1]];
                
                SEL getterSEL = NSSelectorFromString(getterName);
                SEL setterSEL = NSSelectorFromString(setterName);
                
                NSString* code = [k objectAtIndex:0];
                if ([code isEqualToString:@"Ti"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterInt, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterInt, "v@:@");
                }else if ([code isEqualToString:@"Tf"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterFloat, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterFloat, "v@:@");
                }else if ([code isEqualToString:@"Tc"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterBOOL, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterBOOL, "v@:@");
                }else if ([code isEqualToString:@"Td"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterDouble, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterDouble, "v@:@");
                }else if ([code isEqualToString:@"Tl"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterLong, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterLong, "v@:@");
                }else if ([code isEqualToString:@"Ts"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterShort, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterShort, "v@:@");
                }else if ([code isEqualToString:@"Tq"]) {
                    class_addMethod(self, getterSEL, (IMP) dynamicGetterLongLong, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetterLongLong, "v@:@");
                }else{
                    class_addMethod(self, getterSEL, (IMP) dynamicGetter, "@@:");
                    class_addMethod(self, setterSEL, (IMP) dynamicSetter, "v@:@");
                }
            }
        }
    }
    free(properties);
}

#pragma mark - 初期化

//初期化
- (id)init{
    self = [super init];
    if (self) {
        //データ操作履歴を管理
        operationSetQueue = [[NSMutableArray alloc]init];
        [operationSetQueue addObject:[[NSMutableDictionary alloc] init]];
        
        //ローカルデータを管理
        estimatedData = [[NSMutableDictionary alloc] init];
        
        //デフォルトACLの設定
        _ACL = [NCMBACL ACL];
    }
    return self;
}


//クラスネームを指定して初期化
- (id)initWithClassName:(NSString *)className{
    self = [self init];
    if (self) {
        _ncmbClassName = className;
    }
    return self;
}

/**
 指定されたクラス名でNCMBObjectのインスタンスを作成する
 @param className 指定するクラス名
 */
+(instancetype)objectWithClassName:(NSString *)className{
    return [[NCMBObject alloc] initWithClassName:className];
}

/**
 Dictionaryを受け取ってNCMBObjectを返す
 */
- (id)initWithData:(NSMutableDictionary*)attrs{
    self = [self init];
    for(NSString *key in [attrs keyEnumerator]){
        if ([key isEqualToString:@"objectId"]){
            self.objectId = [attrs objectForKey:key];
        } else if ([key isEqualToString:@"className"]){
            _ncmbClassName = [attrs objectForKey:key];
        } else if ([key isEqualToString:@"createDate"]){
            NSDateFormatter *df = [self createNCMBDateFormatter];
            _createDate = [df dateFromString:[attrs objectForKey:key]];
        } else if ([key isEqualToString:@"updateDate"]){
            NSDateFormatter *df = [self createNCMBDateFormatter];
            _updateDate = [df dateFromString:[attrs objectForKey:key]];
        } else if ([key isEqualToString:@"acl"]){
            _ACL.dicACL = [attrs objectForKey:key];
        } else {
            [estimatedData setObject:[self convertToNCMBObjectFromJSON:[attrs objectForKey:key] convertKey:key]
                              forKey:key];
        }
    }
    return self;
}

+ (NCMBObject *)objectWithClassName:(NSString*)className data:(NSDictionary *)attrs{
    NSMutableDictionary *objDic = [NSMutableDictionary dictionaryWithDictionary:attrs];
    if (className != nil){
        [objDic setObject:className forKey:@"className"];
    }
    return [[NCMBObject alloc] initWithData:objDic];
}

/**
 指定されたクラス名とobjectIdでNCMBObjectのインスタンスを作成する
 @param className 指定するクラス名
 @param objectId 指定するオブジェクトID
 */
+ (NCMBObject*)objectWithClassName:(NSString*)className objectId:(NSString*)objectId{
    NCMBObject *obj = [[NCMBObject alloc] initWithClassName:className];
    obj.objectId = objectId;
    return obj;
}

-(NSString*)description{
    NSDictionary *jsonDic = [self getLocalData];
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:jsonDic
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

- (NSDictionary*)getLocalData{
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:[self convertToJSONFromNCMBObject:estimatedData]];
    if (_objectId){
        [returnDic setObject:_objectId forKey:@"objectId"];
    }
    if (_createDate){
        [returnDic setObject:[self convertToJSONFromNCMBObject:_createDate] forKey:@"createDate"];
    }
    if (_updateDate){
        [returnDic setObject:[self convertToJSONFromNCMBObject:_updateDate] forKey:@"updateDate"];
    }
    if (_ACL){
        [returnDic setObject:_ACL.dicACL forKey:@"acl"];
    }
    return returnDic;
}

#pragma mark - 型チェック
//入力値の型チェック
-(BOOL)isValidType:(id)object{
    if (object == nil){
        return YES;
    }
    return [object isKindOfClass:[NSString class]]  || [object isKindOfClass:[NSNumber class]]
    || [object isKindOfClass:[NSArray class]]       || [object isKindOfClass:[NSDictionary class]]
    || [object isKindOfClass:[NSDate class]]        || [object isKindOfClass:[NCMBObject class]]
    || [object isKindOfClass:[NCMBGeoPoint class]]  || [object isKindOfClass:[NCMBACL class]]
    || [object isKindOfClass:[NCMBRelation class]]  || [object isKindOfClass:[NSNull class]];
}



//リストの入力値チェック
-(BOOL)listIsValidType:(NSArray*)array{
    for(int i=0; i<[array count]; i++){
        if (![self isValidType:[array objectAtIndex:i]]) {
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Invalid type for value." userInfo:nil] raise];
        }
    }
    return true;
}

#pragma mark - データ操作

/**
 オブジェクトにACLを設定する
 @param acl 設定するACLオブジェクト
 */
- (void)setACL:(NCMBACL*)acl{
    _ACL = acl;
    [self setObject:acl forKey:@"acl"];
}

//指定したキーに値を設定する
- (void)setObject:(id)object forKey:(NSString *)key{
    //入力値チェック
    if(![self isValidType:object]){
        [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Invalid type for value." userInfo:nil] raise];
    };
    [self performOperation:key byOperation:[[NCMBSetOperation alloc]initWithClassName:object]];
}


//指定したキーから値を取得する
- (id)objectForKey:(NSString *)key{
    id object = nil;
    if ([estimatedData objectForKey:key]) {
        object = [estimatedData objectForKey:key];
    }
    return object;
}
//指定したキーの値をインクリメント(+1)する
- (void)incrementKey:(NSString *)key{
    NSNumber *amount =@1;
    [self incrementKey:key byAmount:amount];
}

//指定したキーの値を指定分インクリメントする
- (void)incrementKey:(NSString *)key byAmount:(NSNumber *)amount{
    //オブジェクトIDが有れば、NCMBIncrementOperation　なければ　NCMBSetOperation
    if (self.objectId == nil || [self.objectId isEqualToString:@""]) {
        if ([estimatedData objectForKey:key]) {
            NSNumber *oldValue = nil;
            
            //前回データの取り出し、型チェック
            id value = [estimatedData objectForKey:key];
            if ([value isKindOfClass:[NSNumber class]]) {
                oldValue = (NSNumber*)value;
            }else{
                [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Old value is not an number." userInfo:nil] raise];
            }
            
            //前回の数値と今回の数値を足す
            NSNumber *newValue = [NSNumber numberWithFloat:[oldValue floatValue] + [amount floatValue]];
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:newValue];
            [self performOperation:key byOperation:operation];
        }
        else{
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:amount];
            [self performOperation:key byOperation:operation];
        }
    }
    else{
        //objectIDがある場合　NCMBIncrementOperation(サーバーサイド処理)実行
        NCMBIncrementOperation *operation = [[NCMBIncrementOperation alloc]initWithClassName:amount];
        [self performOperation:key byOperation:operation];
    }
}

/**
 指定したキーの配列に渡された値を追加する
 @param object 追加する値
 @param key 追加するキー
 */
- (void)addObject:(id)object forKey:(NSString *)key{
    [self addObjectsFromArray:[NSArray arrayWithObjects:object, nil] forKey:key];
}

//指定したキーの配列に渡された配列の値を追加する
- (void)addObjectsFromArray:(NSArray *)objects forKey:(NSString *)key{
    //リスト内の型チェック
    [self listIsValidType:objects];
    
    //オブジェクトIDが有れば、NCMBAddOperation　なければ　NCMBSetOperation
    if (self.objectId == nil || [self.objectId isEqualToString:@""]) {
        NSMutableArray *newValue = [NSMutableArray array];
        if ([estimatedData objectForKey:key]) {
            //前回データの取り出し
            id oldValue = [estimatedData objectForKey:key];
            if ([oldValue isKindOfClass:[NSArray class]]) {
                for(int i=0; i<[oldValue count]; i++){
                    [newValue insertObject:[oldValue objectAtIndex:i] atIndex:i];
                }
            }else{
                [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Old value is not an array." userInfo:nil] raise];
            }
            
            //objects(今回追加する値)の要素をすべてnewValueの末尾に追加
            for(int i=0; i<[objects count]; i++){
                [newValue addObject:[objects objectAtIndex:i]];
            }
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:newValue];
            [self performOperation:key byOperation:operation];
        }
        else{
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:objects];
            [self performOperation:key byOperation:operation];
        }
    }
    else{
        //objectIDがある場合　NCMBAddOperation(サーバーサイド処理)実行
        NCMBAddOperation *operation = [[NCMBAddOperation alloc]initWithClassName:objects];
        [self performOperation:key byOperation:operation];
    }
}

//指定したキーの配列に渡された、重複していない値を追加する
- (void)addUniqueObject:(id)object forKey:(NSString *)key{
    [self addUniqueObjectsFromArray:[NSArray arrayWithObjects:object, nil] forKey:key];
}

//指定したキーの配列に渡された、重複していない配列の値を追加する
- (void)addUniqueObjectsFromArray:(NSArray *)objects forKey:(NSString *)key{
    //リスト内の型チェック
    [self listIsValidType:objects];
    
    if (self.objectId == nil || [self.objectId isEqualToString:@""]) {
        NSMutableArray *newValue = [NSMutableArray array];
        if ([estimatedData objectForKey:key]) {
            //addUnique対象のローカルデータ取り出し
            id oldValue = [estimatedData objectForKey:key];
            //valにobjectの配列である全要素を追加
            if ([oldValue isKindOfClass:[NSArray class]]) {
                for(int i=0; i<[oldValue count]; i++){
                    [newValue insertObject:[oldValue objectAtIndex:i] atIndex:i];
                }
            }else{
                [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Old value is not an array." userInfo:nil] raise];
            }
            
            /** 以下NCMBObjectの重複処理　ObjectIdが同じものは上書き　違うものは末尾に追加*/
            //前回のオブジェクトのobjectIDを保管する。key:各objectID　value:NSNumber
            NSMutableDictionary *existingObjectIds = [NSMutableDictionary dictionary];
            for(int i=0; i<[newValue count]; i++){
                //前回のオブジェクトからNCMBObject要素検索
                if ([[newValue objectAtIndex:i] isKindOfClass:[NCMBObject class]]) {
                    //NCMBObjectがあればkeyにobjectID、valueにNSNumber追加
                    if([((NCMBObject *)[newValue objectAtIndex:i]) objectId]){
                        [existingObjectIds setObject:[NSNumber numberWithInt:i] forKey:[((NCMBObject *)[newValue objectAtIndex:i]) objectId]];
                    }else{
                        [existingObjectIds setObject:[NSNumber numberWithInt:i] forKey:[NSNull null]];
                    }
                }
            }
            
            NSEnumerator* localEnumerator = [objects objectEnumerator];
            id NCMBObj;
            while (NCMBObj = [localEnumerator nextObject]) {
                if ([NCMBObj isKindOfClass:[NCMBObject class]]){
                    //objectsのobjectIdと先ほど生成したexistingObjectIdsのobjectIdが一致した場合、existingObjectIdsのvalue:NSNumberを返す。なければnilを返す。
                    NSNumber *index = [existingObjectIds objectForKey:[NCMBObj objectId]];
                    if (index != nil) {
                        [newValue insertObject:NCMBObj atIndex:[index intValue]];//一致した場所にオブジェクト追加
                    }
                    else{
                        [newValue addObject:NCMBObj];//一致しなかった場合は末に追加
                    }
                }
                else if (![newValue containsObject:NCMBObj]){
                    [newValue addObject:NCMBObj];//NCMBObjectではなかった場合は末に追加
                }
            }
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:newValue];
            [self performOperation:key byOperation:operation];
        }
        else{
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:objects];
            [self performOperation:key byOperation:operation];
        }
    }
    else{
        //objectIDがある場合　AddUniqueOperation(サーバーサイド処理)実行
        NCMBAddUniqueOperation *operation = [[NCMBAddUniqueOperation alloc]initWithClassName:objects];
        [self performOperation:key byOperation:operation];
    }
}

- (void)removeObject:(id)object forKey:(NSString *)key{
    [self removeObjectsInArray:[NSArray arrayWithObjects:object, nil] forKey:key];
}

- (void)removeObjectsInArray:(NSArray *)objects forKey:(NSString *)key{
    if (self.objectId == nil || [self.objectId isEqualToString:@""]) {
        NSMutableArray *val = [NSMutableArray array];
        if ([estimatedData objectForKey:key]) {
            //remove対象のローカルデータ取り出し
            id object = [estimatedData objectForKey:key];
            
            //valにobjectの配列である全要素を追加
            if ([object isKindOfClass:[NSArray class]]) {
                for(int i=0; i<[object count]; i++){
                    [val insertObject:[object objectAtIndex:i] atIndex:i];
                }
            }else{
                [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Old value is not an array." userInfo:nil] raise];
            }
            //resultにvalの全要素を追加
            NSMutableArray *newValue = [NSMutableArray array];
            [newValue setArray:val];
            
            //ローカルデータから今回引数で指定したobjectsの値削除
            [newValue removeObjectsInArray:objects];
            
            /** 以下NCMBObjectの重複処理　ObjectIdが同じものを配列から削除*/
            NSMutableArray *objectsToBeRemoved = [NSMutableArray array];//remove対象のobject格納
            NSMutableSet *objectIds = [NSMutableSet set];//remove対象(NCMBObject)のobjectId格納
            
            //今回指引数で指定したobjectsからnewValueの値削除
            [objectsToBeRemoved setArray:objects];
            [objectsToBeRemoved removeObjectsInArray:newValue];
            
            //削除対象(NCMBOBject)のobjectIdを取得
            NSEnumerator* localEnumerator = [objectsToBeRemoved objectEnumerator];
            id removeNCMBObject;
            while (removeNCMBObject = [localEnumerator nextObject]) {
                if ([removeNCMBObject isKindOfClass:[NCMBObject class]]){
                    [objectIds addObject:[removeNCMBObject objectId]];
                }
            }
            
            //取得したobjectIdと同じNCMBObjectを削除
            id NCMBObj;
            for(int i=0; i<[newValue count]; i++){
                NCMBObj = [newValue objectAtIndex:i];
                if ([NCMBObj isKindOfClass:[NCMBObject class]] && [objectIds containsObject:[NCMBObj objectId]]){
                    [newValue removeObjectAtIndex:i];
                }
            }
            
            NCMBSetOperation *operation = [[NCMBSetOperation alloc]initWithClassName:newValue];
            [self performOperation:key byOperation:operation];
        }
        else{
            //データ操作初回時は削除対象が無いため、exceptionを吐く
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:@"Does not have a value." userInfo:nil] raise];
        }
    }
    else{
        //objectIDがある場合　RemoveOperation(サーバーサイド処理)実行
        NCMBRemoveOperation *operation = [[NCMBRemoveOperation alloc]initWithClassName:objects];
        [self performOperation:key byOperation:operation];
    }
}

//指定したキーの値を削除する
-(void)removeObjectForKey:(NSString *)key{
    if ([estimatedData objectForKey:key]) {
        [estimatedData removeObjectForKey:key];
        [[self currentOperations] setObject:[[NCMBDeleteOperation alloc]init] forKey:key];
    }
    if ([key isEqualToString:@"acl"]){
        _ACL = nil;
    }
}

//指定キーのNCMBRelationを作成する
- (NCMBRelation *)relationforKey:(NSString *)key{
    NCMBRelation *relation=[[NCMBRelation alloc]initWithClassName:self key:key];
    id value = [estimatedData objectForKey:key];
    if(value != nil && [value isKindOfClass:[NCMBRelation class]]){
        relation.targetClass = ((NCMBRelation *)value).targetClass;
    }
    return relation;
}


#pragma mark - 履歴操作

//各オペレーション操作実行。履歴データとローカルデータを作成。
-(void)performOperation:(NSString *)key byOperation:(id)operation{
    
    /** estimetedData構築 */
    //前回実行時のローカルデータ作成
    id oldValue = [estimatedData objectForKey:key];
    //新規ローカルデータ作成
    id newValue = [operation apply:oldValue NCMBObject:self forkey:key];
    //新規ローカルデータ保存
    if (newValue != nil) {
        [estimatedData setObject:newValue forKey:key];
    }else{
        [estimatedData removeObjectForKey:(key)];
    }
    
    /** operationSetQueue構築 */
    //前回実行時の履歴データ作成
    id oldOperation = [[self currentOperations] objectForKey:key];
    //新規履歴データ作成
    id newOperation = [operation mergeWithPrevious:oldOperation];
    //新規履歴データ保存
    NSUInteger index = [operationSetQueue indexOfObject:[self currentOperations]];
    if (index != NSNotFound) {
        [[self currentOperations] setObject:newOperation forKey:key];
    }
}

/**
 キューから最後(前回)の履歴データの取り出し
 @return 一番最後の操作履歴
 */
-(NSMutableDictionary *)currentOperations{
    return [operationSetQueue lastObject];
}


/**
 通信前に履歴の取り出しと、次のOperationを保存するDictionaryをキューにセットする
 @return currentOperations オブジェクトの操作履歴
 */
-(NSMutableDictionary *)beforeConnection{
    NSMutableDictionary *currentOperations = [self currentOperations];
    [operationSetQueue addObject:[[NSMutableDictionary alloc]init]];
    return currentOperations;
}

/**
 オブジェクト更新後に操作履歴とestimatedDataを同期する
 @param response REST APIのレスポンスデータ
 @param operations 同期する操作履歴
 */
-(void)afterSave:(NSDictionary*)response operations:(NSMutableDictionary*)operations{
    //リクエスト実行時の該当履歴削除
    NSUInteger index = [operationSetQueue indexOfObject:operations];
    if (index != NSNotFound) {
        [operationSetQueue removeObjectAtIndex:index];
    }
    //プロパティを更新
    if ([response objectForKey:@"objectId"]){
        _objectId = [self convertToNCMBObjectFromJSON:[response objectForKey:@"objectId"] convertKey:@"objectId"];
    }
    if ([response objectForKey:@"createDate"]){
        _createDate = [self convertToNCMBObjectFromJSON:[response objectForKey:@"createDate"] convertKey:@"createDate"];
    }
    if ([response objectForKey:@"updateDate"]){
        _updateDate = [response objectForKey:@"updateDate"];
    }
    if (self.updateDate == nil && self.createDate != nil){
        _updateDate = _createDate;
    }
}

/**
 saveAll実行後の処理を行う
 @param objects リクエストされたNCMBObjectの配列
 @param operation 各オブジェクトに対する操作履歴
 @param response 各オブジェクトに対するレスポンス
 @param
 **/
+ (void)afterSaveAll:(id)object
           operation:(NSMutableDictionary*)operation
            response:(NSMutableDictionary*)responseDic
{
    if ([[responseDic allKeys] containsObject:@"error"]){
        //各オブジェクトがエラーだった場合の処理
        NCMBObject *obj = object;
        [obj mergePreviousOperation:operation];
    } else {
        NSDictionary *response = [responseDic objectForKey:@"success"];
        if([object isKindOfClass:[NCMBObject class]]){
            NCMBObject *obj = object;
            [obj afterSave:response operations:operation];
        } else if ([object isKindOfClass:[NCMBUser class]]){
            NCMBUser *user = object;
            [user afterSave:response operations:operation];
        } else if ([object isKindOfClass:[NCMBRole class]]){
            NCMBRole *role = object;
            [role afterSave:response operations:operation];
        } else if ([object isKindOfClass:[NCMBPush class]]){
            NCMBPush *push = object;
            [push afterSave:response operations:operation];
        } else if ([object isKindOfClass:[NCMBInstallation class]]){
            NCMBInstallation *installation = object;
            [installation afterSave:response operations:operation];
        }
    }
}

/**
 mobile backendからエラーが返ってきたときに最新の操作履歴と通信中の操作履歴をマージする
 @param operations 最新の操作履歴
 */
- (void)mergePreviousOperation:(NSMutableDictionary*)operations{
    for (id key in [operations keyEnumerator]){
        if ([[[self currentOperations] allKeys] containsObject:key]){
        } else {
            [[self currentOperations] setObject:[operations objectForKey:key] forKey:key];
        }
    }
}

- (NSArray *)allKeys{
    return [estimatedData allKeys];
}

#pragma mark - Refresh

/**
 mobile backendからobjectIdをキーにしてデータを取得する。履歴はリセットされる。
 @param error エラーを保持するポインタ
 */
- (BOOL)refresh:(NSError **)error{
    BOOL result = NO;
    if (_objectId){
        NSString *url = [NSString stringWithFormat:@"classes/%@/%@", _ncmbClassName, _objectId];
        result = [self fetch:url error:error isRefresh:YES];
    }
    return result;
}

/**
 mobile backendからobjectIdをキーにしてデータを取得する。非同期通信を行う。履歴はリセットされる。
 @param block 通信後に実行されるblock。引数にNSError *errorを持つ。
 */
- (void)refreshInBackgroundWithBlock:(NCMBFetchResultBlock)block{
    if (_objectId){
        NSString *url = [NSString stringWithFormat:@"classes/%@/%@", _ncmbClassName, _objectId];
        [self fetchInBackgroundWithBlock:url block:block isRefresh:YES];
    } else {
        block(NO, nil);
    }
}

/**
 mobile backendからobjectIdをキーにしてデータを取得する。非同期通信を行い、通信後は指定されたセレクタを実行する。履歴はリセットされる。
 @param target 呼び出すセレクタのターゲット
 @param selector 実行するセレクタ
 */
- (void)refreshInBackgroundWithTarget:(id)target selector:(SEL)selector{
    NSMethodSignature* signature = [target methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    if (_objectId){
        [self refreshInBackgroundWithBlock:^(BOOL suceeded, NSError *error) {
            [invocation retainArguments];
            [invocation setArgument:&suceeded atIndex: 2 ];
            [invocation setArgument:&error atIndex: 3 ];
            [invocation invoke];
        }];
    } else {
        BOOL result = NO;
        NSError *error = nil;
        [invocation retainArguments];
        [invocation setArgument:&result atIndex: 2 ];
        [invocation setArgument:&error atIndex: 3 ];
        [invocation invoke];
    }
}

#pragma mark - Fetch

/**
 リクエストURLを受け取ってfetchを実行する。
 @param url リクエストURL
 @param error エラーを保持するポインタ
 */
- (BOOL)fetch:(NSString*)url error:(NSError **)error isRefresh:(BOOL)isRefresh{
    NCMBURLConnection *connect = [[NCMBURLConnection alloc]initWithPath:url method:@"GET" data:nil];
    BOOL result = NO;
    //同期通信を実行
    //NSError __autoreleasing *fetchError = nil;
    NSDictionary *response = [connect syncConnection:error];
        //データ取得後にestimatedDataとマージする
    [self afterFetch:[NSMutableDictionary dictionaryWithDictionary:response] isRefresh:isRefresh];
    result = YES;
    return result;
}

/**
 mobile backendからobjectIdをキーにしてデータを取得する
 @param error エラーを保持するポインタ
 @return 通信を行った場合にはYESを返却する
 */
- (BOOL)fetch:(NSError **)error{
    BOOL result = NO;
    if (_objectId){
        NSString *url = [NSString stringWithFormat:@"classes/%@/%@", _ncmbClassName, _objectId];
        result = [self fetch:url error:error isRefresh:NO];
    }
    return result;
    
}

/**
 リクエストURLを受け取ってfetchを実行する。非同期通信を行う。
 @param url リクエストURL
 @param userBlock 通信後に実行されるblock。引数にNSError *errorを持つ。
 */
- (void)fetchInBackgroundWithBlock:(NSString *)url block:(NCMBFetchResultBlock)userBlock isRefresh:(BOOL)isRefresh{
    dispatch_queue_t sub_queue = dispatch_queue_create("fetchInBackgroundWithBlock", NULL);
    dispatch_async(sub_queue, ^{
        //リクエストを作成
        NCMBURLConnection *connect = [[NCMBURLConnection alloc] initWithPath:url method:@"GET" data:nil];
        //非同期通信を実行
        NCMBResultBlock block = ^(NSDictionary *response, NSError *error){
            if (userBlock){
                if (error){
                    userBlock(YES, error);
                } else {
                    //データ取得後にestimatedDataとマージする
                    [self afterFetch:[NSMutableDictionary dictionaryWithDictionary:response] isRefresh:isRefresh];
                    userBlock(YES, nil);
                }
            }
        };
        [connect asyncConnectionWithBlock:block];
        
    });
}

/**
 mobile backendからobjectIdをキーにしてデータを取得する。非同期通信を行う。
 オブジェクトが保存前だった場合には、blockが実行されない。
 @param block 通信後に実行されるblock。引数にNSError *errorを持つ。
 */
- (void)fetchInBackgroundWithBlock:(NCMBFetchResultBlock)block{
    if (_objectId){
        NSString *url = [NSString stringWithFormat:@"classes/%@/%@", _ncmbClassName, _objectId];
        [self fetchInBackgroundWithBlock:url block:block isRefresh:NO];
    } else {
        block(NO, nil);
    }
}

/**
 mobile backendからobjectIdをキーにしてデータを取得する。非同期通信を行い、通信後は指定されたセレクタを実行する。
 オブジェクトが保存前だった場合には、セレクタが実行されない。
 @param target 呼び出すセレクタのターゲット
 @param selector 実行するセレクタ
 */
- (void)fetchInBackgroundWithTarget:(id)target selector:(SEL)selector{
    if (_objectId){
        NSMethodSignature* signature = [target methodSignatureForSelector:selector];
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:target];
        [invocation setSelector:selector];
        
        [self fetchInBackgroundWithBlock:^(BOOL suceeded, NSError *error) {
            [invocation retainArguments];
            [invocation setArgument:&suceeded atIndex: 2 ];
            [invocation setArgument:&error atIndex: 3 ];
            [invocation invoke];
        }];
    }
}

/**
 fetchを実行したあとにプロパティとestimatedDataの更新を行う
 @param response レスポンスのDicitonary
 @param isRefresh リフレッシュ実行フラグ
 */
- (void)afterFetch:(NSMutableDictionary*)response isRefresh:(BOOL)isRefresh{
    //プロパティを更新
    if ([response objectForKey:@"objectId"]){
        _objectId = [response objectForKey:@"objectId"];
        //[response removeObjectForKey:@"objectId"];
    }
    if ([response objectForKey:@"createDate"]){
        _createDate = [response objectForKey:@"createDate"];
    }
    if ([response objectForKey:@"updateDate"]){
        _updateDate = [response objectForKey:@"updateDate"];
    }
    if ([response objectForKey:@"acl"]){
        _ACL = [NCMBACL ACL];
        _ACL.dicACL = [NSMutableDictionary dictionaryWithDictionary:[response objectForKey:@"acl"]];
        //[response removeObjectForKey:@"acl"];
    }
    if (self.createDate == nil && self.updateDate != nil){
        _updateDate = _createDate;
    }
    if (isRefresh == YES){
        //refreshが実行された場合は履歴をすべて消去する。saveEventually対策。
        [operationSetQueue setArray:[NSMutableArray array]];
        estimatedData = [NSMutableDictionary dictionary];
    }
    for (NSString *key in [response keyEnumerator]){
        [estimatedData setObject:[self convertToNCMBObjectFromJSON:[response objectForKey:key] convertKey:key]
                          forKey:key];
    }
}


#pragma mark - Save

/**
 オペレーションの中にSetOperationがないかチェックし、SetOperationのvalueが保存前のNCMBObjectの場合は保存を実行する
 @param operation チェックするオペレーション
 @param error エラーを保持するポインタ
 */
- (void)savePointerObjectBeforehand:(NSMutableDictionary*)operation error:(NSError**)error{
    for (NSString *key in operation){
        if ([[operation objectForKey:key] isKindOfClass:[NCMBSetOperation class]]){
            NCMBSetOperation *setOperation = [operation objectForKey:key];
            if ([setOperation.value isKindOfClass:[NCMBObject class]]){
                NCMBObject *valueObj = setOperation.value;
                if (valueObj.objectId == nil){
                    [valueObj save:error];
                }
            }
        }
    }
}


/**
 リクエストURLを受け取ってsave処理を実行する
 @param url リクエストURL
 @param エラーを保持するポインタ
 @return 通信が行われたかを真偽値で返却する
 */
- (BOOL)save:(NSString*)url error:(NSError **)error{
    
    //ポインタ先オブジェクトは事前に保存してから、connectionを作成
    BOOL result = NO;
    NSMutableDictionary *operation = [self beforeConnection];
    [self savePointerObjectBeforehand:operation
                                error:error];
    
    NCMBURLConnection *connect = [self createConnectionForSave:url
                                                     operation:operation];
    
    if (error != nil && *error != nil){
        return result;
    }
    if (connect == nil){
        return result;
    }
    NSDictionary *response = [connect syncConnection:error];
    
    //通信エラーだった場合はfalseを返す
    if (error != nil && *error){
        //通信エラー or mbエラー
        [self mergePreviousOperation:operation];
    } else {
        [self afterSave:response operations:operation];
        result = YES;
    }
    return result;
}

/**
 mobile backendにオブジェクトを保存する
 @param error エラーを保持するポインタ
 @return result 通信が実行されたらYESを返す
 */
- (BOOL)save:(NSError **)error{
    NSString *url = [NSString stringWithFormat:@"classes/%@", self.ncmbClassName];
    BOOL result = [self save:url error:error];
    return result;
}

/**
 リクエストURLを受け取ってmobile backendにオブジェクトを保存する。非同期通信を行う。
 @param url リクエストURL
 @param block 通信後に実行されるblock。引数にBOOL succeeded, NSError *errorを持つ。
 */
- (void)saveInBackgroundWithBlock:(NSString *)url block:(NCMBSaveResultBlock)userBlock{
    dispatch_queue_t sub_queue = dispatch_queue_create("saveInBackgroundWithBlock", NULL);
    dispatch_async(sub_queue, ^{
        
        //ポインタ先オブジェクトは事前に保存してから、connectionを作成
        NSError *e = nil;
        NSMutableDictionary *operation = [self beforeConnection];
        [self savePointerObjectBeforehand:operation error:&e];
        
        NCMBURLConnection *connect = [self createConnectionForSave:url
                                                         operation:operation];
        
        if (connect == nil || e != nil){
            if (userBlock){
                userBlock(NO, e);
            }
        }
        //非同期通信を実行
        NCMBResultBlock block = ^(NSDictionary *responseDic, NSError *error){
            if (error){
                [self mergePreviousOperation:operation];
            } else {
                
                [self afterSave:responseDic operations:operation];
                
            }
            if (userBlock){
                userBlock(YES, error);                
            }
        };
        [connect asyncConnectionWithBlock:block];
    });
}

/**
 mobile backendにオブジェクトを保存する。非同期通信を行う。
 @param block 通信後に実行されるblock。引数にBOOL succeeded, NSError *errorを持つ。
 */
- (void)saveInBackgroundWithBlock:(NCMBSaveResultBlock)userBlock{
    NSString *url = [NSString stringWithFormat:@"classes/%@", self.ncmbClassName];
    [self saveInBackgroundWithBlock:url block:userBlock];
}

/**
 mobile backendにオブジェクトを保存する。非同期通信を行い、通信後は指定されたセレクタを実行する。
 @param target 呼び出すセレクタのターゲット
 @param selector 実行するセレクタ
 */
- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector{
    if (!target || !selector){
        [NSException raise:@"NCMBInvalidValueException" format:@"target or selector must not nil."];
    }
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [invocation retainArguments];
        [invocation setArgument:&succeeded atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];
    }];
}

/**
 objectsにあるNCMBObjectを継承した全てのオブジェクトを保存する。
 @param objects 保存するNCMBObjectが含まれる配列
 @param error APIリクエストについてのエラー
 @return 実行結果の配列を返却する
 */
+ (NSArray*)saveAll:(NSArray*)objects error:(NSError**)error{
    NSMutableArray *requestArray = [NSMutableArray array];
    //配列にあるNCMBObjectをJSONに変換
    NSMutableArray *operationArray = [NSMutableArray array];
    for (id obj in [objects objectEnumerator]){
        if ([obj isKindOfClass:[NCMBObject class]]){
            NSMutableDictionary *operation = [obj beforeConnection];
            [operationArray addObject:operation];
            //リクエスト用のNSDictionaryを作成
            [requestArray addObject:[obj returnRequestDictionaryForSaveAll:obj operation:operation]];
        }
    }
    
    NCMBURLConnection *connect = [NCMBObject createConnectionForbatchAPI:requestArray];
    if (connect == nil){
        return nil;
    }
    
    //通信を行う
    NSDictionary *response = [connect syncConnection:error];
    NSArray *responseArray = [response objectForKey:@"result"];
    
    //それぞれのNCMBObjectのafterSaveを実行する
    NSEnumerator *responseEnumerator = [responseArray objectEnumerator];
    NSEnumerator *operationEnumerator = [operationArray objectEnumerator];
    if (error != nil && *error){
        //通信エラー(そもそものmbエラーも含む)があった場合
        for (NCMBObject *obj in objects){
            [obj mergePreviousOperation:[operationEnumerator nextObject]];
        }
    } else {
        for (id obj in objects){
            [NCMBObject afterSaveAll:obj
                           operation:[operationEnumerator nextObject]
                            response:[responseEnumerator nextObject]];
        }
    }
    //Dictionaryを返却するけど、objectIdはセットされている状態
    return responseArray;
}

/**
 objectsにある、NCMBObjectを継承した全てのオブジェクトを非同期通信で保存する。通信後は渡されたblockを実行する
 @param objects 保存するNCMBObjectが含まれる配列
 @param error APIリクエストについてのエラー
 */
+ (void)saveAllInBackground:(NSArray*)objects withBlock:(NCMBSaveAllResultBlock)userBlock{
    NSMutableArray *requestArray = [NSMutableArray array];
    //配列にあるNCMBObjectをJSONに変換
    NSMutableArray *operationArray = [NSMutableArray array];
    for (id obj in [objects objectEnumerator]){
        if ([obj isKindOfClass:[NCMBObject class]]){
            NSMutableDictionary *operation = [obj beforeConnection];
            [operationArray addObject:operation];
            //リクエスト用のNSDictionaryを作成
            [requestArray addObject:[obj returnRequestDictionaryForSaveAll:obj operation:operation]];
        }
    }
    
    NCMBURLConnection *connect = [NCMBObject createConnectionForbatchAPI:requestArray];
    if (connect == nil){
        userBlock(NO, nil, nil);
    }
    NCMBResultBlock block = ^(NSDictionary *responseDic, NSError *error){
        NSArray *responseArray = [responseDic objectForKey:@"result"];
        NSEnumerator *responseEnumerator = [responseArray objectEnumerator];
        NSEnumerator *operationEnumerator = [operationArray objectEnumerator];
        if (error){
            //通信エラー(そもそものmbエラーも含む)があった場合
            for (NCMBObject *obj in objects){
                [obj mergePreviousOperation:[operationEnumerator nextObject]];
            }
        } else {
            //各オブジェクトのレスポンスがエラーだった場合
            for (id obj in objects){
                [NCMBObject afterSaveAll:obj
                               operation:[operationEnumerator nextObject]
                                response:[responseEnumerator nextObject]];
            }
        }
        userBlock(YES, responseArray, error);
    };
    [connect asyncConnectionWithBlock:block];
}

/**
 objectsにある、NCMBObjectを継承した全てのオブジェクトを非同期通信で保存する。通信後は指定されたセレクタを実行する
 @param objects 保存するNCMBObjectが含まれる配列
 @param target 呼び出すセレクタのターゲット
 @param selector 実行するセレクタ
 */
+ (void)saveAllInBackground:(NSArray*)objects withTarget:(id)target selector:(SEL)selector{
    if (!target || !selector){
        [NSException raise:@"NCMBInvalidValueException" format:@"target or selector must not nil."];
    }
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    [NCMBObject saveAllInBackground:objects withBlock:^(BOOL succeeded, NSArray *results, NSError *error) {
        [invocation retainArguments];
        [invocation setArgument:&succeeded atIndex:2];
        [invocation setArgument:&results atIndex:3];
        [invocation setArgument:&error atIndex:4];
        [invocation invoke];
    }];
}

/**
 save用のNCMBConnectionを作成する
 @param url APIリクエストするURL
 @param operation オブジェクトの操作履歴
 @return save用のNCMBConnection
 */
- (NCMBURLConnection*)createConnectionForSave:(NSString*)url operation:(NSMutableDictionary*)operation {
    NSData *json = [[NSData alloc] init];
    if ([operation count] != 0){
        NSMutableDictionary *ncmbDic = [self convertToJSONDicFromOperation:operation];
        NSMutableDictionary *jsonDic = [self convertToJSONFromNCMBObject:ncmbDic];
        NSError *convertError = nil;
        json = [NSJSONSerialization dataWithJSONObject:jsonDic options:kNilOptions error:&convertError];
        if (convertError){
            return nil;
        }
    } else {
        json = nil;
    }
    
    
    NSString *path = nil;
    NSString *method = nil;
    if (!self.objectId){
        path = url;
        method = @"POST";
    } else {
        path = [url stringByAppendingString:[NSString stringWithFormat:@"/%@", self.objectId]];
        //path = [NSString stringWithFormat:@"classes/%@/%@", self.ncmbClassName, self.objectId];
        method = @"PUT";
    }
    NCMBURLConnection *connect = [[NCMBURLConnection new] initWithPath:path method:method data:json];
    return connect;
}

/**
 saveAll用のNCMBURLConnectionを作成する
 @param requestArray リクエストするオブジェクトをJSONに変換した配列
 @return saveAll用のNCBURLConnection
 */
+ (NCMBURLConnection*)createConnectionForbatchAPI:(NSMutableArray*)requestArray{
    //request配列を作成
    NSDictionary *requestDic = [NSDictionary dictionaryWithObject:requestArray forKey:@"requests"];
    NSError *convertError = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:requestDic options:kNilOptions error:&convertError];
    if (convertError){
        return nil;
    }
    //NCMBConnectionを作成
    
    NSString *path = @"batch";
    NSString *method = @"POST";
    
    NCMBURLConnection *connect = [[NCMBURLConnection new] initWithPath:path method:method data:json];
    return connect;
}

/**
 saveAll用のリクエスト配列を作成する
 @param obj リクエストに追加するNCMBObject
 @param operation リクエストに追加するオブジェクトの操作履歴
 @return ncmbDic リクエスト用のNSDictionary
 */
- (NSDictionary*)returnRequestDictionaryForSaveAll:(NCMBObject*)obj operation:(NSMutableDictionary*)operation {
    NSMutableDictionary *operationDic = [obj convertToJSONDicFromOperation:operation];
    NSMutableDictionary *ncmbDic = [NSMutableDictionary dictionaryWithObject:[obj convertToJSONFromNCMBObject:operationDic] forKey:@"body"];
    if (obj.objectId == nil){
        [ncmbDic setObject:@"POST" forKey:@"method"];
    } else {
        [ncmbDic setObject:@"PUT" forKey:@"method"];
    }
    [ncmbDic setObject:[self returnRequestUrlForBatchAPI:obj.ncmbClassName objectId:obj.objectId]
                forKey:@"path"];
    return ncmbDic;
}

/**
 クラス名とobjectIdを受け取ってバッチ用APIリクエストURLを作成する
 @param ncmbClassName クラス名
 @param objectId オブジェクトID
 @return バッチ用APIリクエストURL
 */
- (NSString*)returnRequestUrlForBatchAPI:(NSString*)ncmbClassName objectId:(NSString*)objectId{
    //ベースのURLを作成
    NSDictionary *endpoint = @{@"user":@"users",
                               @"role":@"roles",
                               @"installation":@"installations",
                               @"push":@"push"};
    NSString *base = nil;
    if ([ncmbClassName isEqualToString:@"user"] || [ncmbClassName isEqualToString:@"role"] ||
        [ncmbClassName isEqualToString:@"installation"] || [ncmbClassName isEqualToString:@"push"]) {
        base = [NSString stringWithFormat:@"2013-09-01/%@", [endpoint objectForKey:ncmbClassName]];
    } else {
        base = [NSString stringWithFormat:@"2013-09-01/classes/%@", ncmbClassName];
    }
    
    //オブジェクトIDがあれば追加
    if (objectId != nil){
        return [base stringByAppendingString:[NSString stringWithFormat:@"/%@", objectId]];
    } else {
        return base;
    }
}

#pragma mark - delete

/**
 リクエストURLを受け取ってdeleteを実行する
 @param url リクエストURL
 @param error エラーを保持するポインタ
 */
- (BOOL)delete:(NSString *)url error:(NSError **)error{
    BOOL result = NO;
    NCMBURLConnection *connect = [[NCMBURLConnection alloc]initWithPath:url
                                                                 method:@"DELETE"
                                                                   data:nil];
    
    //同期通信を実行
    [connect syncConnection:error];
    
    if (error == nil || !*error){
        [self afterDelete];
        result = YES;
    }
    return result;
}

/**
 オブジェクトをmobile backendとローカル上から削除する
 @param error エラーを保持するポインタを保持するポインタ
 */
- (BOOL)delete:(NSError**)error{
    NSString *url;
    if (_objectId){
        url = [NSString stringWithFormat:@"classes/%@/%@", _ncmbClassName, _objectId];
    } else {
        url = [NSString stringWithFormat:@"classes/%@", _ncmbClassName];
    }
    return [self delete:url error:error];
}

/**
 リクエストURLを受け取ってdeleteを実行する。非同期通信を行う。
 @param url リクエストURL
 @param block
 */
- (void)deleteInBackgroundWithBlock:(NSString *)url block:(NCMBDeleteResultBlock)userBlock{
    dispatch_queue_t sub_queue = dispatch_queue_create("saveInBackgroundWithBlock", NULL);
    dispatch_async(sub_queue, ^{
        //リクエストを作成
        NCMBURLConnection *connect = [[NCMBURLConnection alloc]initWithPath:url
                                                                     method:@"DELETE"
                                                                       data:nil];
        
        //非同期通信を実行
        NCMBResultBlock block = ^(NSDictionary *responseDic, NSError *error){
            if (userBlock){
                if (error){
                    userBlock(NO, error);
                } else {
                    [self afterDelete];
                    userBlock(YES, nil);
                }
            }
        };
        [connect asyncConnectionWithBlock:block];
    });
}

/**
 オブジェクトをmobile backendとローカル上から削除する。非同期通信を行う。
 @param error block 通信後に実行されるblock。引数にBOOL succeeded, NSError *errorを持つ。
 */
- (void)deleteInBackgroundWithBlock:(NCMBDeleteResultBlock)userBlock{
    NSString *url;
    if (_objectId){
        url = [NSString stringWithFormat:@"classes/%@/%@", self.ncmbClassName, self.objectId];
    } else {
        url = [NSString stringWithFormat:@"classes/%@", self.ncmbClassName];
    }
    [self deleteInBackgroundWithBlock:url block:userBlock];
}

/**
 オブジェクトをmobile backendとローカル上から削除する。非同期通信を行い、通信後は指定されたセレクタを実行する。
 @param target 呼び出すセレクタのターゲット
 @param selector 実行するセレクタ
 */
- (void)deleteInBackgroundWithTarget:(id)target
                            selector:(SEL)selector{
    
    NSMethodSignature* signature = [target methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    
    [self deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [invocation retainArguments];
        [invocation setArgument:&succeeded atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];
    }];
}

/**
 ローカルオブジェクトをリセットする
 */
- (void)afterDelete{
    _objectId = nil;
    _createDate = nil;
    _updateDate = nil;
    _ncmbClassName = nil;
    estimatedData = nil;
    operationSetQueue = nil;
}

#pragma mark - convert

/**
 操作履歴からDictionary作成
 @param operations オブジェクトの操作履歴を保持するNSMutableDictionaryオブジェクト
 */
-(NSMutableDictionary *)convertToJSONDicFromOperation:(NSMutableDictionary*)operations{
    
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc]init];
    for (id key in [operations keyEnumerator]) {
        //各操作をREST APIの形式に変換してセットする
        [jsonDic setObject:[[operations valueForKey:key] encode] forKey:key];
    }
    return jsonDic;
}

/**
 JSONオブジェクトをNCMBObjectに変換する
 @param jsonData JSON形式のデータ
 @param convertKey 変換するキー
 @return JSONオブジェクトから変換されたオブジェクト
 */
- (id)convertToNCMBObjectFromJSON:(id)jsonData convertKey:(NSString*)convertKey{
    if (jsonData == NULL){
        //objがNULLだったら
        return nil;
    } else if ([jsonData isKindOfClass:[NSDictionary class]]){
        if ([jsonData objectForKey:@"__type"]){
            NSString *typeStr = [jsonData objectForKey:@"__type"];
            if ([typeStr isEqualToString:@"Date"]){
                //objが日付型だったら
                NSString *iso = [jsonData objectForKey:@"iso"];
                NSDateFormatter *dateFormatter = [self createNCMBDateFormatter];
                NSDate *date = [dateFormatter dateFromString:iso];
                return date;
            } else if ([typeStr isEqualToString:@"GeoPoint"]){
                //objが位置情報だったら
                NCMBGeoPoint *geoPoint = [[NCMBGeoPoint alloc] init];
                geoPoint.latitude = [[jsonData objectForKey:@"latitude"] doubleValue];
                geoPoint.longitude = [[jsonData objectForKey:@"longitude"] doubleValue];
                return geoPoint;
            } else if ([typeStr isEqualToString:@"Pointer"]){
                //objがポインタだったら
                id obj = [NCMBObject convertClass:jsonData ncmbClassName:[jsonData objectForKey:@"className"]];
                return obj;

            } else if ([typeStr isEqualToString:@"Relation"]){
                //objがリレーションだったら
                NCMBRelation *relation = [[NCMBRelation alloc] initWithClassName:self key:convertKey];
                relation.targetClass = [jsonData objectForKey:@"className"];
                return relation;
            } else if ([typeStr isEqualToString:@"Object"]){
                id obj = [NCMBObject convertClass:jsonData ncmbClassName:[jsonData objectForKey:@"className"]];
                return obj;

            }
        } else if ([jsonData objectForKey:@"acl"]){
            //objがACLだったら
            NCMBACL *acl = [[NCMBACL alloc] init];
            acl.dicACL = [jsonData objectForKey:@"acl"];
            return acl;
        } else {
            //objがNSDictionaryだったら再帰呼び出し
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (NSString *key in [jsonData keyEnumerator]){
                id convertedObj = [self convertToNCMBObjectFromJSON:[jsonData objectForKey:key] convertKey:key];
                [dic setObject:convertedObj forKey:key];
            }
            return dic;
        }
    } else if ([jsonData isKindOfClass:[NSArray class]]){
        //NSMutableArray *jsonArray = [NSMutableArray arrayWithObject:jsonData];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < [jsonData count]; i++){
            //objがNSArrayだったら再帰呼び出し
            array[i] = [self convertToNCMBObjectFromJSON:jsonData[i] convertKey:nil];
        }
        return array;
    } else if ([jsonData isKindOfClass:[NSSet class]]){
        NSMutableSet *currentSet = [NSMutableSet setWithObject:jsonData];
        NSMutableSet *set = [NSMutableSet set];
        for (id value in [currentSet objectEnumerator]){
            //objがNSSetだったら再帰呼び出し
            [set addObject:[self convertToNCMBObjectFromJSON:value  convertKey:nil]];
        }
        return set;
        
    }
    //その他の型(文字列、数値、真偽値)はそのまま返却
    return jsonData;
}

/**
 NCMB形式の日付型NSDateFormatterオブジェクトを返す
 */
-(NSDateFormatter*)createNCMBDateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //和暦表示と12時間表示対策
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setCalendar:calendar];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    return dateFormatter;
}

/**
 NCMBObjectをJSONに変換する
 @param obj NCMBオブジェクト
 */
- (id)convertToJSONFromNCMBObject:(id)obj{
    if (obj == NULL){
        //objがNULLだったら
        return [NSNull null];
    } else if ([obj isKindOfClass:[NSDate class]]){
        //objが日付型だったら
        NSMutableDictionary *jsonObj = [NSMutableDictionary dictionary];
        [jsonObj setObject:@"Date" forKey:@"__type"];
        NSDateFormatter *dateFormatter = [self createNCMBDateFormatter];
        NSString *dateStr = [dateFormatter stringFromDate:obj];
        [jsonObj setObject:dateStr forKey:@"iso"];
        return jsonObj;
    } else if ([obj isKindOfClass:[NCMBGeoPoint class]]){
        //objが位置情報だったら
        NCMBGeoPoint *geoPoint = obj;
        NSMutableDictionary *jsonObj = [NSMutableDictionary dictionary];
        [jsonObj setObject:@"GeoPoint" forKey:@"__type"];
        [jsonObj setObject:[NSNumber numberWithDouble:geoPoint.latitude] forKey:@"latitude"];
        [jsonObj setObject:[NSNumber numberWithDouble:geoPoint.longitude] forKey:@"longitude"];
        return jsonObj;
        
    } else if ([obj isKindOfClass:[NCMBObject class]]){
        //objがポインタだったら
        NCMBObject *ncmbObj = obj;
        NSMutableDictionary *jsonObj = [NSMutableDictionary dictionary];
        [jsonObj setObject:@"Pointer" forKey:@"__type"];
        [jsonObj setObject:[ncmbObj ncmbClassName] forKey:@"className"];
        [jsonObj setObject:[ncmbObj objectId] forKey:@"objectId"];
        return jsonObj;
        
    } else if ([obj isKindOfClass:[NCMBRelation class]]){
        //objがリレーションだったら
        NCMBRelation *relation = obj;
        NCMBObject *parentObj = relation.parent;
        id convertObj = [self convertToJSONDicFromOperation:[parentObj currentOperations]];
        return convertObj;
    } else if ([obj isKindOfClass:[NCMBACL class]]){
        //objがACLだったら
        NCMBACL *acl = obj;
        if ([[acl dicACL] count] == 0){
            return [NSNull null];
        } else {
            return [acl dicACL];
        }
    } else if ([obj isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *jsonObj = [NSMutableDictionary dictionary];
        //objがNSDictionaryだったら再帰呼び出し
        for (id Key in [obj keyEnumerator]){
            id convertedObj = [self convertToJSONFromNCMBObject:[obj objectForKey:Key]];
            [jsonObj setObject:convertedObj forKey:Key];
        }
        return jsonObj;
    } else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *array = [NSMutableArray array];//[NSMutableArray arrayWithObject:obj];
        for (int i = 0; i < [obj count]; i++){
            //objがNSArrayだったら再帰呼び出し
            array[i] = [self convertToJSONFromNCMBObject:obj[i]];
        }
        return array;
    } else if ([obj isKindOfClass:[NSSet class]]){
        NSMutableSet *currentSet = [NSMutableSet setWithObject:obj];
        NSMutableSet *set = [NSMutableSet set];
        for (id value in [currentSet objectEnumerator]){
            //objがNSSetだったら再帰呼び出し
            [set addObject:[self convertToJSONFromNCMBObject:value]];
        }
        return set;
        
    }
    //その他の型(文字列、数値、真偽値)はそのまま返却
    return obj;
}

/**
 引数の配列とクラス名からサブクラスor既定クラスorその他のインスタンスを作成する
 @param NSMutableDictionary *result オブジェクトのデータ
 @param NSString *ncmbClassName mobile backend上のクラス名
 */
+ (id)convertClass:(NSMutableDictionary*)result
     ncmbClassName:(NSString*)ncmbClassName{
    NSString *subClassName = @"";
    subClassName = [[SubClassHandler sharedInstance] className:ncmbClassName];
    if (subClassName != nil){
        Class vcClass = NSClassFromString(ncmbClassName);
        NCMBObject *obj = [vcClass objectWithoutDataWithObjectId:[result objectForKey:@"objectId"]];
        [obj afterFetch:result isRefresh:YES];
        return obj;
    } else if ([ncmbClassName isEqualToString:@"user"]){
        NCMBUser *user = [[NCMBUser alloc] initWithClassName:@"user"];
        [user afterFetch:result isRefresh:YES];
        return user;
    } else if ([ncmbClassName isEqualToString:@"push"]){
        NCMBPush *push = [NCMBPush push];
        [push afterFetch:result isRefresh:YES];
        return push;
    } else if ([ncmbClassName isEqualToString:@"installation"]){
        NCMBInstallation *installation = [NCMBInstallation currentInstallation];
        [installation afterFetch:result isRefresh:YES];
        return installation;
    } else if ([ncmbClassName isEqualToString:@"role"]){
        NCMBRole *role = [[NCMBRole alloc] initWithClassName:@"role"];
        [role afterFetch:result isRefresh:YES];
        return role;
    } else if ([ncmbClassName isEqualToString:@"file"]){
        NCMBFile *file = [NCMBFile fileWithName:[result objectForKey:@"fileName"] data:nil];
        file.ACL = [result objectForKey:@"acl"];
        return file;
    } else {
        NCMBObject *obj = [NCMBObject objectWithClassName:ncmbClassName];
        [obj afterFetch:result isRefresh:YES];
        return obj;
    }
}

@end
