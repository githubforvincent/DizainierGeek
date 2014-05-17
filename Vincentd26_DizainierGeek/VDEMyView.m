//
//  VDEMyView.m
//  Vincentd26_DizainierGeek
//
//  Created by Utilisation on 17/05/14.
//  Copyright (c) 2014 Utilisation. All rights reserved.
//

#import "VDEMyView.h"

@implementation VDEMyView


// enumeration des controles de cette vue pour la méthode vdeActionVue: une méthode pour toutes les actions
enum vdeTagActions {
	vdeTagStepper,
	vdeTagSwitchGeek,
	vdeTagSegmentDizaine,
	vdeTagSegmentUnites,
	vdeTagSlider,
	vdeTagBoutonReset
};
typedef enum vdeTagActions vdeTagActions;

//--------------------------------------------------------------------------------------------------------
-(id) initWithFrame:(CGRect)frame {
    //--------------------------------------------------------------------------------------------------------
    
    self= [super initWithFrame:frame ];
    
    if( self) {
        // recuperation du type de terminal
        if ( [[UIDevice currentDevice] userInterfaceIdiom ]== UIUserInterfaceIdiomPhone) {
            isIpad = NO;
        } else {
            isIpad = YES;
        }
    }
	
	NSArray *vdeLabelSegments = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    
    //configuration subview du fond
    //--------------------------------------------------------------------------------------------------------
    //vdeImageEspace = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image2048_2048.png"]];
    //vdeImageEspace = [[UIImageView alloc] init];
    //[self addSubview:vdeImageEspace];
	
    
    //configuration subview Stepper
    //--------------------------------------------------------------------------------------------------------
    vdeStepper = [[UIStepper alloc] init];
    vdeStepper.maximumValue     = 99;
    vdeStepper.minimumValue     = 0;
    vdeStepper.stepValue        = 1;
	[vdeStepper setTag:vdeTagStepper]; // pour permettre l'identifiaction du sender dans la méthode vdeActionVue: qui est appelée par tous les "actionneurs"
    [vdeStepper addTarget:self action:@selector(vdeActionVue:) forControlEvents:UIControlEventValueChanged];

    [self addSubview:vdeStepper];
	

    // configuration subview du label mode geek
    //--------------------------------------------------------------------------------------------------------
    vdeLabelModeGeek = [[UILabel alloc]init];
    [vdeLabelModeGeek setText:@"Mode Geek"];
    [vdeLabelModeGeek setTextAlignment:NSTextAlignmentRight];
    [self addSubview:vdeLabelModeGeek];
    
    //configuration subview du switch
    //--------------------------------------------------------------------------------------------------------
    vdeSwitchModeGeek = [[UISwitch alloc] init];
    [vdeSwitchModeGeek addTarget:self action:@selector(vdeActionVue:) forControlEvents:UIControlEventValueChanged];
	[vdeSwitchModeGeek setTag:vdeTagSwitchGeek];
    [self addSubview:vdeSwitchModeGeek];
    
    //configuration subview segment dizaines : label et control
    //--------------------------------------------------------------------------------------------------------
    vdeLabelDizaines = [[UILabel alloc]init];
    [vdeLabelDizaines setTextAlignment:NSTextAlignmentLeft];
    [vdeLabelDizaines setText:@"Dizaines"];
    [self addSubview:vdeLabelDizaines];
    
    vdeSegmentDizaines = [[UISegmentedControl alloc] initWithItems:vdeLabelSegments];
    vdeSegmentDizaines.selectedSegmentIndex=0;
    [vdeSegmentDizaines addTarget:self action:@selector(vdeActionVue:) forControlEvents:UIControlEventValueChanged];
	[vdeSegmentDizaines setTag:vdeTagSegmentDizaine];
    [self addSubview:vdeSegmentDizaines];
    
    //configuration subview segment unites : label et control
    //--------------------------------------------------------------------------------------------------------
    vdeLabelUnites = [[UILabel alloc]init];
    [vdeLabelUnites setTextAlignment:NSTextAlignmentLeft];
    [vdeLabelUnites setText:@"Unites"];
    [self addSubview:vdeLabelUnites];
    
    vdeSegmentUnites = [[UISegmentedControl alloc] initWithItems:vdeLabelSegments];
    vdeSegmentUnites.selectedSegmentIndex=0;
    [vdeSegmentUnites addTarget:self action:@selector(vdeActionVue:) forControlEvents:UIControlEventValueChanged];
	[vdeSegmentUnites setTag:vdeTagSegmentUnites];
    [self addSubview:vdeSegmentUnites];
    
    //configuration subview du slider
    //--------------------------------------------------------------------------------------------------------
    vdeSlider = [[UISlider alloc] init];
    vdeSlider.minimumValue  = 0;
    vdeSlider.maximumValue  = 99;
    vdeSlider.continuous    = YES;
    vdeSlider.value         = 0;
    [vdeSlider addTarget:self action:@selector(vdeActionVue:) forControlEvents:UIControlEventValueChanged ];
	[vdeSlider setTag:vdeTagSlider];
    [self addSubview:vdeSlider];
    
    
    // configuration subview  valeur
    //--------------------------------------------------------------------------------------------------------
    vdeLabelValeur = [[UILabel alloc]init];
    [vdeLabelValeur setTextAlignment:NSTextAlignmentCenter];
    [vdeLabelValeur setText:@"0"];
    [self addSubview:vdeLabelValeur];
    
    
    //configuration subview du bouton reset
    //--------------------------------------------------------------------------------------------------------
    vdeBoutonReset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [vdeBoutonReset setTitle:@"Reset" forState:UIControlStateNormal];
    [vdeBoutonReset setBackgroundColor:[UIColor lightGrayColor]];
    [vdeBoutonReset setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    [vdeBoutonReset addTarget:self action:@selector(vdeActionVue:) forControlEvents:UIControlEventTouchUpInside];
	[vdeBoutonReset setTag:vdeTagBoutonReset];
    [self addSubview:vdeBoutonReset];
    
    
    // positionnement des frames
    //--------------------------------------------------------------------------------------------------------
    [ self vdeAffichageEcran];
    
    
    return self;
}

//--------------------------------------------------------------------------------------------------------
-(void) vdeAffichageEcran{
//--------------------------------------------------------------------------------------------------------
    
    int vdeEspacement;            // espacement vertical entre les éléments, calculé plus bas
    int vdeHauteurElement   = 30; // hauteur standard pour tous les éléments;
    int vdeMargeHaut        = 30; // marge haut des premiers élements
    int vdeMargeLaterale    = 20;
    int vdeOffsetEcartement = 20; // pour ajuster l'espace entre les segmented control
    
    
    int vdeLargeurVue = [self bounds].size.width;
    int vdeHauteurVue = [self bounds].size.height;
    
    // calcul des coordonnées et dimensions des subviews
    //--------------------------------------------------------------------------------------------------------
    
    if( isIpad) {
        vdeEspacement = ((vdeHauteurVue/2)-vdeMargeHaut)/5; // valeur d'espacement - occupe la moitié de l'écran sur iPad
    } else {
        vdeEspacement = ((vdeHauteurVue*2/3)-vdeMargeHaut)/5; // valeur d'espacement - occupe deux tiers de l'écran sur iPhone
    }
    
    int vdeLargeurStepper       = 100;
    int vdeXstepper             = vdeMargeLaterale;
    int vdeYStepper             = vdeMargeHaut;
    
    
    int vdeLargeurSwitchGeek    = 50;
    int vdeXSwitchGeek          = vdeLargeurVue-vdeMargeLaterale-vdeLargeurSwitchGeek;
    int vdeYSwitchGeek          = vdeMargeHaut;
    
    int vdeLargeurLabelModeGeek = 100;
    int vdeXLabelModeGeek       = vdeLargeurVue-vdeMargeLaterale-vdeLargeurSwitchGeek-5-vdeLargeurLabelModeGeek; // vue-marge droite-largeur switch-espace-largeur label geek
    int vdeYLabelModeGeek       = vdeMargeHaut;
    
    int vdeXSegmentDizaines         = vdeMargeLaterale;
    int vdeYSegmentDizaines         = vdeMargeHaut+(vdeHauteurElement/2)+vdeEspacement;
    int vdeLargeurSegmentDizaines   = vdeLargeurVue-2*vdeMargeLaterale; // deux marges de 20 de chaque coté
    
    int vdeXLabelDizaines       = vdeMargeLaterale;
    int vdeYLabelDizaines       = vdeYSegmentDizaines-vdeHauteurElement+5; // +5 pour rapprocher le label du segment
    int vdeLargeurLabelDizaines = vdeLargeurVue/2;
    
    int vdeXSegmentUnites       = vdeMargeLaterale;
    int vdeYSegmentUnites       = vdeMargeHaut+(vdeHauteurElement/2)+(2*vdeEspacement)+vdeOffsetEcartement;
    int vdeLargeurSegmentUnites = vdeLargeurVue-2*vdeMargeLaterale; // deux marges de 20 de chaque coté
    
    int vdeXLabelUnites         = vdeMargeLaterale;
    int vdeYLabelUnites         = vdeYSegmentUnites-vdeHauteurElement+5; //+5 pour rapprocher le label du segment
    int vdeLargeurLabelUnites   = vdeLargeurVue/2;
    
    int vdeXLabelValeur         = vdeMargeLaterale;
    int vdeYlabelValeur         = vdeMargeHaut+(vdeHauteurElement/2)+(3*vdeEspacement);
    int vdeLargeurLabelValeur   = vdeLargeurVue-2*vdeMargeLaterale; // il suffira de centrer le texte....
    
    int vdeXSlider              = vdeMargeLaterale;
    int vdeYSlider              = vdeMargeHaut+(vdeHauteurElement/2)+(4*vdeEspacement);
    int vdeLargeurSlider        = vdeLargeurVue-2*vdeMargeLaterale; // deux marges de 20 de chaque coté
    
    int vdeXBoutonReset         = vdeLargeurVue/3;
    int vdeYBoutonReset         = vdeMargeHaut+(vdeHauteurElement/2)+(5*vdeEspacement);
    int vdeLargeurBoutonReset   = vdeLargeurVue/3; // 1/3 de la largeur... pourquoi pas..
    
    
    // placement des subviews
    //--------------------------------------------------------------------------------------------------------
    
    [vdeStepper         setFrame:CGRectMake(vdeXstepper, vdeYStepper, vdeLargeurStepper, vdeHauteurElement)];
    
    [vdeLabelModeGeek   setFrame:CGRectMake(vdeXLabelModeGeek, vdeYLabelModeGeek, vdeLargeurLabelModeGeek, vdeHauteurElement)];
    [vdeSwitchModeGeek  setFrame:CGRectMake(vdeXSwitchGeek, vdeYSwitchGeek, vdeLargeurSwitchGeek, vdeHauteurElement)];
    
    [vdeLabelDizaines   setFrame:CGRectMake(vdeXLabelDizaines, vdeYLabelDizaines, vdeLargeurLabelDizaines, vdeHauteurElement)];
    [vdeSegmentDizaines setFrame:CGRectMake(vdeXSegmentDizaines,vdeYSegmentDizaines, vdeLargeurSegmentDizaines, vdeHauteurElement)];
    
    [vdeLabelUnites     setFrame:CGRectMake(vdeXLabelUnites, vdeYLabelUnites, vdeLargeurLabelUnites, vdeHauteurElement)];
    [vdeSegmentUnites   setFrame:CGRectMake(vdeXSegmentUnites, vdeYSegmentUnites, vdeLargeurSegmentUnites, vdeHauteurElement)];
    
    [vdeLabelValeur     setFrame:CGRectMake(vdeXLabelValeur, vdeYlabelValeur, vdeLargeurLabelValeur, vdeHauteurElement)];
    
    [vdeSlider          setFrame:CGRectMake(vdeXSlider, vdeYSlider, vdeLargeurSlider, vdeHauteurElement)];
    
    [vdeBoutonReset     setFrame:CGRectMake(vdeXBoutonReset, vdeYBoutonReset, vdeLargeurBoutonReset, vdeHauteurElement)];
    
    
}

-(void) vdeActionVue: (id) sender {
//--------------------------------------------------------------------------------------------------------

    // Recuperation du n° de tag de l'élément qui a lancé l'action
	int vdeTagSender = [sender tag];
	
	switch (vdeTagSender) {
		case vdeTagStepper:
			NSLog(@"action stepper");
			// cette partie ne sert à rien aujourd'hui mais au cas où, plus tard... sait-on jamais.... 
			break;
			
		case(vdeTagSwitchGeek):
			NSLog(@"action switch");
			vdeGeekMode= !(vdeGeekMode);
			break;
			
		case (vdeTagSegmentDizaine):{ // ajout de "(" sinon sender est casté en plusieures endroits dans le même scope
			NSLog(@"action dizaines");
			UISegmentedControl *senderDizaines = sender;
			vdeStepper.value = (senderDizaines.selectedSegmentIndex*10) +vdeSegmentUnites.selectedSegmentIndex;
			break;
		}
		
		case (vdeTagSegmentUnites):{
			NSLog(@"action unites");
			UISegmentedControl *senderUnites = sender;
			vdeStepper.value = (vdeSegmentDizaines.selectedSegmentIndex*10) +senderUnites.selectedSegmentIndex;
			break;
		}
		case ( vdeTagSlider):{
			NSLog(@"action slider");
			UISlider * senderSlider = sender;
			vdeStepper.value= senderSlider.value;
			break;
		}
			
		case ( vdeTagBoutonReset):{
			NSLog(@"action reset");
			vdeStepper.value = 0;
		}
			
		default:
			break;
	}
	
	[self vdeMiseAJourAffichage];
	
    
}

//--------------------------------------------------------------------------------------------------------
- (void)vdeMiseAJourAffichage {
    //--------------------------------------------------------------------------------------------------------
    long int v = vdeStepper.value;
    
    // configuration couleur rouge pour la réponse à la question de l'univers et du reste.... ou sinon, noir
    if (v==42) {
        vdeLabelValeur.textColor = [UIColor redColor];
    } else {
        vdeLabelValeur.textColor =[UIColor blackColor];
    }
    
    // affichage en hexa ou décimal
    if (vdeGeekMode){
        NSString *valeurEnCaractere = [NSString stringWithFormat:@"%lx", v];
        vdeLabelValeur.text=valeurEnCaractere;
    } else {
        NSString *valeurEnCaractere = [NSString stringWithFormat:@"%ld", v];
        vdeLabelValeur.text=valeurEnCaractere;
    }
    
    //mise à jour des widgets dizaines et unités
    int dizaine=v/10;
    int unite = v%10;
    vdeSegmentUnites.selectedSegmentIndex   = unite;
    vdeSegmentDizaines.selectedSegmentIndex = dizaine;
    
    //mise du curseur slider à la bonne position
    vdeSlider.value=v;
    
    
}



//--------------------------------------------------------------------------------------------------------

@end

