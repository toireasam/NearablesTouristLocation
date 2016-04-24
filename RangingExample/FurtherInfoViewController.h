//  FurtherInformationControllerViewController.h

#import "InsideAttractionViewController.h"
#import "Parse/Parse.h"
#import <PARSEUI/PFImageView.h>
#import <PARSEUI/PFImageView.h>
#import "iCarousel.h"
#import "TouristLocationArtefact.h"

@interface FurtherInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *artefactInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *artefactNameLbl;
@property (nonatomic, strong) NSString *artefactNameTxt;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@end
