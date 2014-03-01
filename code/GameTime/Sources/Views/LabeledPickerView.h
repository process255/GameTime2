/*******************************************************************************
 * Copyright (c) 2009 KÃ¥re MorstÃ¸l (NotTooBad Software).
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *   KÃ¥re MorstÃ¸l (NotTooBad Software) - initial API and implementation
 *	  Michael Kaye (http://www.sendmetospace.co.uk) - modified addLabel/didMoveWindow. New methods - updateLabel, refreshLabel and removeLabel
 *******************************************************************************/ 

#import <Foundation/Foundation.h>

/** 
 A picker view with labels under the selection indicator.
 Similar to the one in the timer tab in the Clock app.
 NB: has only been tested with less than four wheels. 
 */
@interface LabeledPickerView : UIPickerView {
	NSMutableDictionary *labels;
}

- (void)setup;
/** Adds the label for the given component. */
- (void) addLabel:(NSString *)labeltext forComponent:(NSUInteger)component forLongestString:(NSString *)longestString;
- (void) updateLabel:(NSString *)labeltext forComponent:(NSUInteger)component;

@end