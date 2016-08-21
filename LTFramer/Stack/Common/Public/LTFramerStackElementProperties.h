//
//  LTFramerVirtualBox.h
//  Pods
//
//  Created by László Teveli on 08/09/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LTFramerIndividualAlignment) {
    LTFramerIndividualAlignmentInherited,
    LTFramerIndividualAlignmentStretchToFill,
    LTFramerIndividualAlignmentLeading,
    LTFramerIndividualAlignmentTrailing,
    LTFramerIndividualAlignmentCenter,
    //LTFramerIndividualAlignmentBaseline is not yet implemented
};

@interface LTFramerStackElementProperties : NSObject

@property (nonatomic, strong) NSNumber* paddingBefore;
@property (nonatomic, strong) NSNumber* paddingAfter;
@property (nonatomic, strong) NSValue* exactSize;
@property (nonatomic, assign) LTFramerIndividualAlignment alignment;
@property (nonatomic, strong) NSNumber* canGrow;
@property (nonatomic, strong) NSNumber* canShrink;

@end
