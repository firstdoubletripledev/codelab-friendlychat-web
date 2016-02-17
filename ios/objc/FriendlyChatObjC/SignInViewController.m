//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "AppState.h"
#import "Constants.h"
#import "MeasurementHelper.h"
#import "SignInViewController.h"

@import FirebaseAuth;
@import FirebaseAuthUI;

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation SignInViewController

- (IBAction)didTapSignIn:(id)sender {
  // Sign In with credentials.
  NSString *email = _emailField.text;
  NSString *password = _passwordField.text;
  [[FIRAuth auth] signInWithEmail:email
                         password:password
                         callback:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                           if (error) {
                             NSLog(error.localizedDescription);
                             return;
                           }
                           [self signedIn: user];
  }];
}

- (IBAction)didTapSignUp:(id)sender {
  NSString *email = _emailField.text;
  NSString *password = _passwordField.text;
  [[FIRAuth auth] createUserWithEmail:email
                             password:password
                             callback:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                               if (error) {
                                 NSLog(error.localizedDescription);
                                 return;
                               }
                               [self signedIn: user];
                             }];
}

- (IBAction)didTapSignInWithGoogle:(id)sender {
  FIRAuth *firebaseAuth = [FIRAuth auth];
  FIRAuthUI *firebaseAuthUI = [FIRAuthUI authUIForApp:firebaseAuth.app];
  [firebaseAuthUI presentSignInWithViewController:self callback:^(FIRUser *_Nullable user,
      NSError *_Nullable error) {
        if (error) {
          NSLog(error.localizedDescription);
      return;
    }
   [self signedIn: user];
  }];
}


- (void)signedIn:(FIRUser *)user {
  [MeasurementHelper sendLoginEvent];

  [AppState sharedInstance].displayName = user.displayName;
  [AppState sharedInstance].photoUrl = user.photoURL;
  [AppState sharedInstance].signedIn = YES;
  [[NSNotificationCenter defaultCenter] postNotificationName:NotificationKeysSignedIn
                                                      object:nil userInfo:nil];
  [self performSegueWithIdentifier:SeguesSignInToFp sender:nil];
}

@end
