

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CountryCodeBlock)(NSString *code);
@interface DFWT_CodeController : BaseViewController
@property (nonatomic,copy)CountryCodeBlock countryCodeBlock;
@end

NS_ASSUME_NONNULL_END
