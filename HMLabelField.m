//
//  HMLabelField.m
//  XspfManager
//
//  Created by Hori,Masaki on 10/01/11.
//

/*
 This source code is release under the New BSD License.
 Copyright (c) 2010, masakih
 All rights reserved.
 
 ソースコード形式かバイナリ形式か、変更するかしないかを問わず、以下の条件を満たす場合に
 限り、再頒布および使用が許可されます。
 
 1, ソースコードを再頒布する場合、上記の著作権表示、本条件一覧、および下記免責条項を含
 めること。
 2, バイナリ形式で再頒布する場合、頒布物に付属のドキュメント等の資料に、上記の著作権表
 示、本条件一覧、および下記免責条項を含めること。
 3, 書面による特別の許可なしに、本ソフトウェアから派生した製品の宣伝または販売促進に、
 コントリビューターの名前を使用してはならない。
 本ソフトウェアは、著作権者およびコントリビューターによって「現状のまま」提供されており、
 明示黙示を問わず、商業的な使用可能性、および特定の目的に対する適合性に関する暗黙の保証
 も含め、またそれに限定されない、いかなる保証もありません。著作権者もコントリビューター
 も、事由のいかんを問わず、 損害発生の原因いかんを問わず、かつ責任の根拠が契約であるか
 厳格責任であるか（過失その他の）不法行為であるかを問わず、仮にそのような損害が発生する
 可能性を知らされていたとしても、本ソフトウェアの使用によって発生した（代替品または代用
 サービスの調達、使用の喪失、データの喪失、利益の喪失、業務の中断も含め、またそれに限定
 されない）直接損害、間接損害、偶発的な損害、特別損害、懲罰的損害、または結果損害につい
 て、一切責任を負わないものとします。
 -------------------------------------------------------------------
 Copyright (c) 2010, masakih
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 1, Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2, Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in
    the documentation and/or other materials provided with the
    distribution.
 3, The names of its contributors may be used to endorse or promote
    products derived from this software without specific prior
    written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL,EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
*/

#import "HMLabelField.h"

#import "HMLabelCell.h"


@interface HMLabelField (HMPrivate)
- (NSRect)labelRectForIndex:(NSInteger)index;
@end

static const NSInteger labelCount = 8;

static const CGFloat leftMargin = 2;
static const CGFloat rightMargin = 2;
static const CGFloat labelMargin = 1;
static const CGFloat labelSize = 19;
static const CGFloat yMargin = 2;

@implementation HMLabelField

+ (Class)cellClass
{
	return [HMLabelCell class];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	NSInteger i;
	for(i = 0; i < labelCount; i++) {
		NSCell *cell = [labelCells objectAtIndex:i];
		[cell drawWithFrame:[self labelRectForIndex:i] inView:self];
	}
}

- (NSRect)labelRectForIndex:(NSInteger)index
{
	NSRect cellRect = NSMakeRect((labelSize + labelMargin) * index + leftMargin, yMargin, labelSize, labelSize);
	
	return cellRect;
}
- (void)setup
{
	NSMutableArray *cells = [NSMutableArray arrayWithCapacity:labelCount];
	NSInteger i;
	
	Class cellClass = [[self class] cellClass];
	BOOL isImageCell = [cellClass isSubclassOfClass:[NSImageCell class]] ? YES : NO;
	for(i = 0; i < labelCount; i++) {
		NSImageCell *cell;
		if(isImageCell) {
			cell = [[[cellClass alloc] initImageCell:nil] autorelease];
		} else {
			cell = [[[cellClass alloc] initTextCell:@""] autorelease];
		}
		[cell setIntegerValue:i];
		[cell setEnabled:YES];
		[cell setBordered:YES];
		[cells addObject:cell];
		[self addTrackingRect:[self labelRectForIndex:i] owner:self userData:[NSNumber numberWithInteger:i] assumeInside:NO];
	}
	[self setCell:[cells objectAtIndex:0]];
	[self setIntegerValue:0];
	[[cells objectAtIndex:0] setState:NSOnState];
	
	labelCells = [[NSArray arrayWithArray:cells] retain];
}
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (id)initWithCoder:(id)decoder
{
	self = [super initWithCoder:decoder];
	if(self) {
		[self setup];
	}
	[self setLabelStyle:[decoder decodeIntegerForKey:@"HMLabelLabelStyleKey"]];
	[self setDrawX:[decoder decodeBoolForKey:@"HMLabelIsDrawXKey"]];
	[self setValue:[decoder decodeObjectForKey:@"HMLabelValueKey"]];
	
	return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeInteger:[self labelStyle] forKey:@"HMLabelLabelStyleKey"];
	[aCoder encodeBool:[self isDrawX] forKey:@"HMLabelIsDrawXKey"];
	[aCoder encodeObject:[self value] forKey:@"HMLabelValueKey"];
}
- (void)dealloc
{
	[labelCells release];
	[super dealloc];
}

- (NSSize)minimumSize
{
	NSRect newRect = [self labelRectForIndex:labelCount - 1];
	NSSize newSize;
	newSize.width = NSMaxX(newRect);
	newSize.width += rightMargin;
	newSize.height = yMargin + labelSize + yMargin;
	
	return newSize;
}
- (void)sizeToFit
{
	[self setFrameSize:[self minimumSize]];
	[self setNeedsDisplay];
}
- (void)setValue:(id)aValue
{
	[self setObjectValue:aValue];
}
- (id)value
{
	return [self objectValue];
}
- (void)setObjectValue:(id)aValue
{
	if([aValue respondsToSelector:@selector(integerValue)]) {
		[self setIntegerValue:[aValue integerValue]];
	} else {
		[super setObjectValue:aValue];
	}
}
- (id)objectValue
{
	return [NSNumber numberWithInteger:value];
}
- (void)setIntegerValue:(NSInteger)aValue
{
	if(aValue < 0 || aValue > labelCount) return;
	if(value == aValue) return;
	
	for(id cell in labelCells) {
		[cell setState:NSOffState];
	}
	[[labelCells objectAtIndex:aValue] setState:NSOnState];
	
	value = aValue;
	[self setNeedsDisplay];
}
- (NSInteger)integerValue
{
	return value;
}
- (void)setLabelStyle:(NSInteger)style
{
	for(id cell in labelCells) {
		[cell setLabelStyle:style];
	}
}
- (NSInteger)labelStyle
{
	if(![self cell]) return HMCircleStyle;
	
	return [[self cell] labelStyle];
}
- (void)setDrawX:(BOOL)flag
{
	[[self cell] setDrawX:flag];
}
- (BOOL)isDrawX
{
	if(![self cell]) return NO;
	return [[self cell] isDrawX];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	BOOL inLabelCell = NO;
	NSInteger labelIndex = NSNotFound;
	NSPoint mouse = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSInteger i;
	for(i = 0; i < labelCount; i++) {
		if([self mouse:mouse inRect:[self labelRectForIndex:i]]) {
			inLabelCell = YES;
			labelIndex = i;
			break;
		}
	}
	if(!inLabelCell) return;
	
	[self setIntegerValue:labelIndex];
	[self sendAction:[self action] to:[self target]];
}
- (void)mouseEntered:(NSEvent *)theEvent
{
	id cellIndex = [theEvent userData];
	if(![cellIndex isKindOfClass:[NSNumber class]]) return;
	
	NSInteger labelIndex = [cellIndex integerValue];
	[[labelCells objectAtIndex:labelIndex] setState:NSOnState];
	[self setNeedsDisplayInRect:[self labelRectForIndex:labelIndex]];
}
- (void)mouseExited:(NSEvent *)theEvent
{
	id cellIndex = [theEvent userData];
	if(![cellIndex isKindOfClass:[NSNumber class]]) return;
	
	NSInteger labelIndex = [cellIndex integerValue];
	if([self integerValue] != labelIndex) {
		[[labelCells objectAtIndex:labelIndex] setState:NSOffState];
		[self setNeedsDisplayInRect:NSInsetRect([self labelRectForIndex:labelIndex], -1,-1)];
	}
}


@end
