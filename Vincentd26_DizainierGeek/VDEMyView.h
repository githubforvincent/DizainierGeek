//
//  VDEMyView.h
//  Vincentd26_DizainierGeek
//
//  Created by Utilisation on 17/05/14.
//  Copyright (c) 2014 Utilisation. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface VDEMyView : UIView {
    
    UIStepper           *vdeStepper;
    UILabel             *vdeLabelModeGeek;
    UISwitch            *vdeSwitchModeGeek;
    
    UILabel             *vdeLabelDizaines;
    UISegmentedControl  *vdeSegmentDizaines;
    
    UILabel             *vdeLabelUnites;
    UISegmentedControl  *vdeSegmentUnites;
    
    UILabel             *vdeLabelValeur;
    
    UISlider            *vdeSlider;
    
    UIButton            *vdeBoutonReset;
    
    
    UIImageView         *vdeImageEspace, *vdeImageFusee;
    BOOL isIpad, vdeGeekMode;
}

@end
