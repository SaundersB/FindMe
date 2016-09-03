//
//  ViewController.m
//  FindMe
//
//  Created by Brandon_Saunders on 9/3/16.
//  Copyright © 2016 Brandon_Saunders. All rights reserved.
//
/*
 Beacon type (2 bytes, 0x02-15)
 Apple has assigned a value for proximity beacons, which is used by all iBeacons. Some sources state that this is a two-byte field, with the first byte indicating a protocol identifier of 2 for iBea‐ con and the second byte indicating a length of 21 further bytes (15 in hex is 21 decimal).
 Proximity UUID (16 bytes)
 This field contains the UUID for the iBeacon. Typically, this will be set to the organization that owns the beacon. Not all beacon products allow this field to be set.
 Major (2 bytes) and Minor (2 byte) numbers
 These fields, each two bytes in length, contain the major or minor number that will be contained within the iBeacon’s broadcast.
 Measured power (1 byte)
 Implicit within the iBeacon protocol is the idea of ranging (identifying the distance a device is from a beacon, as discussed in “Ranging” on page 48). There may be slight variations in transmitter power, so an iBeacon is calibrated with a reference client. Measured power is set by holding a receiver one meter from the beacon and finding an average received signal strength. This field holds the measured power as a two’s comple‐ ment.3 For example, a value of C5 indicates a measured power at one meter of –59 dBm.
 
 
 
 Functional Proccess
 1. Create a CLBeaconRegion object.3 This object is defined by the UUID, major number, and minor number. In the following code, the iBeacon to monitor has the UUID 24F7B8B3- D124-4B7B-A180-CBA317CC1BB6 (generated specifically for this book by the uuidgen tool) and has the major and minor num‐ bers of 42 and 105, respectively. To monitor more generically, create the CLBeaconRegion object with only the numerical parameters desired—for example, only the UUID.
 2. Create a CLLocationManager to monitor for that region to obtain notifications when the device crosses region boundaries.
 3. Take action based on the region boundary crossings. These actions are developer-defined and likely involve interaction with something else to make the application respond or react. It can be as simple as displaying a message, but the type of action is limited only by the developer’s imagination.
 */

#import "ViewController.h"
@import CoreLocation;

@interface ViewController ()
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self obtainBeaconData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                              
- (void)obtainBeaconData {
    NSUUID *myUUID =
    [[NSUUID alloc]
     initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"];
    
    CLBeaconMajorValue myMajor = 10028;
    CLBeaconMinorValue myMinor = 15208;
    
    // This region matches on anything with the UUID
    CLBeaconRegion *uuidMatch = [[CLBeaconRegion alloc]
                                 initWithProximityUUID:myUUID
                                 identifier:@"uuidMatch" ];
    // This region matches on one specific beacon in the UUID
    CLBeaconRegion *matchThree = [[CLBeaconRegion alloc]
                                  initWithProximityUUID:myUUID
                                  major:myMajor
                                  minor:myMinor
                                  identifier:@"matchThree" ];
    CLLocationManager *myLocationManager =
    [[CLLocationManager alloc] init];
    
    // Check that hardware supports monitoring
    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]])
    {
        printf("Device is capable for hardware iBeacon monitoring.");
        [myLocationManager startMonitoringForRegion:uuidMatch];
        
        [myLocationManager stopMonitoringForRegion:uuidMatch];
        [myLocationManager startMonitoringForRegion:matchThree];

    }
    else {
        printf("Device is NOT capable for hardware iBeacon monitoring");
    }
}


- (void)locationManager:(CLLocationManager *)manager
                                            didEnterRegion:(nonnull CLRegion *)region {
    UILocalNotification *message =
                                [[UILocalNotification alloc] init];
    message.alertBody = @"You are here. Welcome";
    message.soundName = @"Default";
    [[UIApplication sharedApplication]
     scheduleLocalNotification:message];
}


- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(nonnull CLRegion *)region {
    UILocalNotification *message =
    [[ UILocalNotification alloc] init];
    message.alertBody = @"We're sad to see you go";
    message.soundName = @"Default";
    [[ UIApplication sharedApplication]
        scheduleLocalNotification:message];
}



@end
































