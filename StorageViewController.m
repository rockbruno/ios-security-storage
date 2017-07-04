//
//  StorageViewController.m
//  techtalkProj
//
//  Created by Bruno Rocha on 6/21/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

#import "StorageViewController.h"
#import "SAMKeychain.h"

@interface StorageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation StorageViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)defaults:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_textField.text forKey:@"SecurityProjDefaultsKey"];
    [defaults synchronize];
}

- (IBAction)keychain:(id)sender {
    [SAMKeychain setPassword:_textField.text forService:@"SecurityTestService" account:@"SecurityTestAccount"];
}

- (IBAction)coreData:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"TestEntity" inManagedObjectContext:context];
    [newDevice setValue:_textField.text forKey:@"value"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

@end
