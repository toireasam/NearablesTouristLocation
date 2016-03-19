//
//  AdminViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 19/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController ()

@end

@implementation AdminViewController
@synthesize touristLocationNameEdit;
@synthesize touristLocationNameTxt;
    NSString *objectID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"from admin screen");
    NSLog(touristLocationNameTxt);
    
    self.touristLocationNameEdit.text = touristLocationNameTxt;
   // self.touirstLocationNameEditField.text = touristLocationNameTxt;

    
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"TouristLocationName" equalTo:touristLocationNameTxt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            if(objects.count == 0)
            {
                // No beacons were found
                
            }
            for (PFObject *object in objects)
            {
                
                NSLog(@"%@", object.objectId);
                NSLog(@"%@",object);
                objectID = object.objectId;
                _touirstLocationNameEditField.text = object[@"TouristLocationName"];
                
                   _touirstLocationInfoEditField.text = object[@"Information"];
                
                
                
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClickUpdateInfo:(id)sender {
    
    NSLog(@"I am going to look for ");
    NSLog(touristLocationNameTxt);
    
    NSLog(@"I will update this with ");
    NSLog(_touirstLocationNameEditField.text);
    
    
    // lets do it
    NSData *imageData = UIImagePNGRepresentation(_ivPickedImage.image);
    PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    
    // Retrieve the object by id and update info
    [query getObjectInBackgroundWithId:objectID
                                 block:^(PFObject *object, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                    object[@"Information"] = _touirstLocationInfoEditField.text;
                                    // object[@"score"] = @1338;
                                           object[@"LocationImage"] = imageFile;
                                     [object saveInBackground];
                                 }];
    
    // save image in background now
    

    
//    UIImage *image = [_ivPickedImage image];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
  

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnGalleryClicked:(id)sender {
    
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:_btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
  
}
- (IBAction)btnCameraClicked:(id)sender {
    
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No Camera Available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    _ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
