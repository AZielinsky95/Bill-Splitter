//
//  ViewController.m
//  Bill Splitter
//
//  Created by Alejandro Zielinsky on 2018-04-20.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISlider *amountOfPeopleSlider;

@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.amountTextField.delegate = self;
    [self.amountTextField addTarget:self
                                 action:@selector(textFieldDidChange)
                       forControlEvents:UIControlEventEditingChanged];
    [self.amountOfPeopleSlider addTarget:self
                    action:@selector(textFieldDidChange)
          forControlEvents:UIControlEventValueChanged];
    
    [self.tipSlider addTarget:self
                                  action:@selector(textFieldDidChange)
                        forControlEvents:UIControlEventValueChanged];
}

-(void)textFieldDidChange
{
    [self calculateSplitAmount];
}

- (CGFloat)calculateTip
{
    float tipToCalculate = [self.amountTextField.text floatValue];
    
    float tipPercent = (int)self.tipSlider.value;
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc]init];
    self.tipLabel.text = [NSString stringWithFormat:@"%d %@" ,(int)tipPercent,[fmt percentSymbol]];
    
    tipPercent = tipPercent / 100;
    
    return (tipToCalculate * tipPercent);
    
}

- (void)calculateSplitAmount
{
    float totalAmount = [self.amountTextField.text floatValue] + [self calculateTip];
    float splitAmount = totalAmount / (int)self.amountOfPeopleSlider.value;
    self.resultLabel.text = [NSString stringWithFormat:@"%0.2f",splitAmount];
}

- (IBAction)adjustSlider:(UISlider *)sender
{
    self.sliderLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

@end
