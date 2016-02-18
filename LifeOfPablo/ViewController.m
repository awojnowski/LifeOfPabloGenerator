//
//  ViewController.m
//  LifeOfPablo
//
//  Created by Aaron Wojnowski on 2016-02-13.
//  Copyright © 2016 Aaron Wojnowski. All rights reserved.
//

#import "ViewController.h"

#import "PabloView.h"

#import "PabloRenderController.h"

#import "UIColor+Pablo.h"

@interface ViewController () <PabloViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, readonly, strong) UIImage *defaultImage;
@property (nonatomic, readonly, strong) UIImage *defaultImage2;
@property (nonatomic, assign) BOOL choosingImage2;
@property (nonatomic, readonly, weak) UITextField *currentTextField;
@property (nonatomic, assign) BOOL lockKeyboardHeight;
@property (nonatomic, assign) CGFloat keyboardHeight;

@property (nonatomic, readonly, strong) UIButton *versionButton;
@property (nonatomic, readonly, strong) UIButton *exportButton;
@property (nonatomic, readonly, strong) UIButton *buyButton;
@property (nonatomic, readonly, strong) PabloView *pabloView;
@property (nonatomic, readonly, strong) UITextField *textField;
@property (nonatomic, readonly, strong) UITextField *textField2;

@end

@implementation ViewController

@synthesize defaultImage=_defaultImage;
-(UIImage *)defaultImage {
    
    if (!_defaultImage) {
        
        _defaultImage = [UIImage imageNamed:@"DefaultImage"];
        
    }
    return _defaultImage;
    
}

@synthesize defaultImage2=_defaultImage2;
-(UIImage *)defaultImage2 {
    
    if (!_defaultImage2) {
        
        _defaultImage2 = [UIImage imageNamed:@"DefaultImage2"];
        
    }
    return _defaultImage2;
    
}

@synthesize versionButton=_versionButton;
-(UIButton *)versionButton {
    
    if (!_versionButton) {
        
        _versionButton = [[UIButton alloc] init];
        [_versionButton addTarget:self action:@selector(versionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_versionButton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [_versionButton addTarget:self action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_versionButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
        [[_versionButton layer] setCornerRadius:22.0];
        [[self view] addSubview:_versionButton];
        
    }
    return _versionButton;
    
}

@synthesize exportButton=_exportButton;
-(UIButton *)exportButton {
    
    if (!_exportButton) {
        
        _exportButton = [[UIButton alloc] init];
        [_exportButton addTarget:self action:@selector(exportButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_exportButton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [_exportButton addTarget:self action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_exportButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
        [_exportButton setTitle:@"Save & Share" forState:UIControlStateNormal];
        [_exportButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.75] forState:UIControlStateNormal];
        [[_exportButton layer] setCornerRadius:22.0];
        [[self view] addSubview:_exportButton];
        
    }
    return _exportButton;
    
}

@synthesize buyButton=_buyButton;
-(UIButton *)buyButton {
    
    if (!_buyButton) {
        
        _buyButton = [[UIButton alloc] init];
        [_buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [_buyButton addTarget:self action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_buyButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
        [_buyButton setTitle:@"Buy It" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.75] forState:UIControlStateNormal];
        [[_buyButton layer] setCornerRadius:22.0];
        [[self view] addSubview:_buyButton];
        
    }
    return _buyButton;
    
}

@synthesize pabloView=_pabloView;
-(PabloView *)pabloView {
    
    if (!_pabloView) {
        
        _pabloView = [[PabloView alloc] init];
        [_pabloView setDelegate:self];
        [_pabloView setVersion:PabloRenderVersionNew];
        [_pabloView setBackgroundColor:[UIColor pab_orangeColor]];
        [_pabloView setImage:[self defaultImage]];
        [_pabloView setImage2:[self defaultImage2]];
        [_pabloView setText:@"THE LIFE OF PABLO"];
        [_pabloView setText2:@"WHICH / ONE"];
        [[self view] addSubview:_pabloView];
        
    }
    return _pabloView;
    
}

@synthesize textField=_textField;
-(UITextField *)textField {
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        [_textField addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [_textField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
        [_textField setHidden:YES];
        [[self view] addSubview:_textField];
        
    }
    return _textField;
    
}

@synthesize textField2=_textField2;
-(UITextField *)textField2 {
    
    if (!_textField2) {
        
        _textField2 = [[UITextField alloc] init];
        [_textField2 addTarget:self action:@selector(textField2TextChanged:) forControlEvents:UIControlEventEditingChanged];
        [_textField2 setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_textField2 setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
        [_textField2 setHidden:YES];
        [[self view] addSubview:_textField2];
        
    }
    return _textField2;
    
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor pab_orangeColor]];
    
    [self refreshVersionButton];
    [self setCurrentTextField:[self textField]];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[self currentTextField] becomeFirstResponder];
    
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [[self textField] setFrame:CGRectMake(0, 0, CGRectGetWidth([[self view] bounds]), 44)];
    
    CGFloat const actionButtonY = CGRectGetHeight([[self view] bounds]) - [self keyboardHeight] - 44.0 - 8.0;
    [[self versionButton] setFrame:CGRectMake(8.0, actionButtonY, 44.0, 44.0)];
    [[self buyButton] setFrame:CGRectMake(CGRectGetWidth([[self view] bounds]) - 8.0 - 80.0, actionButtonY, 80.0, 44.0)];
    [[self exportButton] setFrame:CGRectMake(CGRectGetMaxX([[self versionButton] frame]) + 8.0, actionButtonY, CGRectGetWidth([[self textField] bounds]) - CGRectGetMaxX([[self versionButton] frame]) - 8.0 - CGRectGetWidth([[self buyButton] bounds]) - 8.0 * 2.0, 44.0)];
    
    CGFloat const width = CGRectGetWidth([[self view] bounds]);
    CGFloat const yInsetTop = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    CGFloat const yInsetBottom = [self keyboardHeight] + 8.0 + CGRectGetHeight([[self exportButton] frame]) + 8.0;
    CGFloat const height = CGRectGetHeight([[self view] bounds]) - yInsetTop - yInsetBottom;
    CGFloat const padding = 0.0;
    CGFloat const pabloSize = MIN(width, height) - padding * 2.0;
    [[self pabloView] setFrame:CGRectMake((width - pabloSize) / 2.0, yInsetTop + (height - pabloSize) / 2.0, pabloSize, pabloSize)];
    
}

#pragma mark - Actions

-(void)buyButtonTapped:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://kanyewest.tidal.com"]];
    
}

-(void)exportButtonTapped:(id)sender {
    
    [self setLockKeyboardHeight:YES];
    [[self exportButton] setUserInteractionEnabled:NO];
    [[self exportButton] setAlpha:0.5];
    
    PabloRenderController * const rendererController = [[PabloRenderController alloc] init];
    [rendererController setRenderVersion:[[self pabloView] version]];
    [rendererController setBackgroundColor:[[self pabloView] backgroundColor]];
    [rendererController setImage:[[self pabloView] image]];
    [rendererController setImage2:[[self pabloView] image2]];
    [rendererController setText:[[self pabloView] text]];
    [rendererController setText2:[[self pabloView] text2]];
    UIImage * const image = [rendererController renderImageWithSize:600.0];
    
    UIActivityViewController * const activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL URLWithString:@"https://itunes.apple.com/us/app/id##########"], image] applicationActivities:nil];
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
        [self setLockKeyboardHeight:NO];
        [[self exportButton] setUserInteractionEnabled:YES];
        [[self exportButton] setAlpha:1.0];
        
    }];
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

-(void)buttonDown:(id)sender {
    
    [sender setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.05]];
    
}

-(void)buttonUp:(id)sender {
    
    [sender setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
    
}

-(void)textFieldTextChanged:(id)sender {
    
    NSString * const text = [[self textField] text];
    [[self pabloView] setText:[text uppercaseString]];
    
}

-(void)textField2TextChanged:(id)sender {
    
    NSString * const text2 = [[self textField2] text];
    [[self pabloView] setText2:[text2 uppercaseString]];
    
}

-(void)versionButtonTapped:(id)sender {
    
    if ([[self pabloView] version] == PabloRenderVersionNew) {
        
        [[self pabloView] setVersion:PabloRenderVersionOld];
        
    } else if ([[self pabloView] version] == PabloRenderVersionOld) {
        
        [[self pabloView] setVersion:PabloRenderVersionNew];
        
    }
    [self refreshVersionButton];
    [self refreshVersionField];
    
}

#pragma mark - Keyboard

-(void)keyboardWillShow:(NSNotification *)notification {
    
    CGRect const keyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self setKeyboardHeight:CGRectGetHeight(keyboardFrame)];
    [[self view] setNeedsLayout];
    
}

-(void)keyboardWillHide:(NSNotification *)notification {
    
    [self setKeyboardHeight:0.0];
    [[self view] setNeedsLayout];
    
}

-(void)keyboardFrameWillChange:(NSNotification *)notification {
    
    CGRect const keyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self setKeyboardHeight:CGRectGetHeight(keyboardFrame)];
    [[self view] setNeedsLayout];
    
}

#pragma mark - Versions

-(void)refreshVersionButton {
    
    if ([[self pabloView] version] == PabloRenderVersionNew) {
        
        [[self versionButton] setImage:[UIImage imageNamed:@"OldVersionIcon"] forState:UIControlStateNormal];
        [[self versionButton] setImage:[[self versionButton] imageForState:UIControlStateNormal] forState:UIControlStateHighlighted];
        
    } else if ([[self pabloView] version] == PabloRenderVersionOld) {
        
        [[self versionButton] setImage:[UIImage imageNamed:@"NewVersionIcon"] forState:UIControlStateNormal];
        [[self versionButton] setImage:[[self versionButton] imageForState:UIControlStateNormal] forState:UIControlStateHighlighted];
        
    }
    
}

-(void)refreshVersionField {
    
    if ([[self pabloView] version] == PabloRenderVersionNew) {
        
        ;
        
    } else if ([[self pabloView] version] == PabloRenderVersionOld) {
        
        [self setCurrentTextField:[self textField]];
        
    }
    
}

#pragma mark - Getters & Setters

-(void)setCurrentTextField:(UITextField * _Nullable)currentTextField {
    
    _currentTextField = currentTextField;
    [currentTextField becomeFirstResponder];
    
}

-(void)setKeyboardHeight:(CGFloat)keyboardHeight {
    
    if ([self lockKeyboardHeight]) {
        
        return;
        
    }
    _keyboardHeight = keyboardHeight;
    
}

#pragma mark - PabloViewDelegate

-(void)pabloViewDidTapImage:(PabloView *)pabloView {
    
    [self setChoosingImage2:NO];
    [self setLockKeyboardHeight:YES];
    
    UIAlertController * const alertController = [UIAlertController alertControllerWithTitle:@"Choose Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([pabloView image] != [self defaultImage]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Default Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self setLockKeyboardHeight:NO];
            [pabloView setImage:[self defaultImage]];
            
        }]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController * const imagePickerController = [[UIImagePickerController alloc] init];
            [imagePickerController setDelegate:self];
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController * const imagePickerController = [[UIImagePickerController alloc] init];
            [imagePickerController setDelegate:self];
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self setLockKeyboardHeight:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)pabloViewDidTapImage2:(PabloView *)pabloView {
    
    [self setChoosingImage2:YES];
    [self setLockKeyboardHeight:YES];
    
    UIAlertController * const alertController = [UIAlertController alertControllerWithTitle:@"Choose Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([pabloView image2] != [self defaultImage2]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Default Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self setLockKeyboardHeight:NO];
            [pabloView setImage2:[self defaultImage2]];
            
        }]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController * const imagePickerController = [[UIImagePickerController alloc] init];
            [imagePickerController setDelegate:self];
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController * const imagePickerController = [[UIImagePickerController alloc] init];
            [imagePickerController setDelegate:self];
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self setLockKeyboardHeight:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)pabloViewDidTapText1:(PabloView *)pabloView {
    
    [self setCurrentTextField:[self textField]];
    
}

-(void)pabloViewDidTapText2:(PabloView *)pabloView {
    
    [self setCurrentTextField:[self textField2]];
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self setLockKeyboardHeight:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * const image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if ([self choosingImage2]) {
        
        [[self pabloView] setImage2:image];
        
    } else {
        
        [[self pabloView] setImage:image];
        
    }
    
    [self setLockKeyboardHeight:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
