//
//  HMLabelCell.m
//  XspfManager
//
//  Created by Hori,Masaki on 10/01/04.
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

#import "HMLabelCell.h"


@implementation HMLabelCell

- (void)setValue:(id)value
{
	[self setObjectValue:value];
}
- (id)value
{
	return [self objectValue];
}
- (void)setIntegerValue:(NSInteger)integer
{
	if(integer == [self integerValue]) return;
	
	[gradient release];
	gradient = nil;
	
	[super setIntegerValue:integer];
}

- (void)setObjectValue:(id)value
{
	if([value isEqual:[self objectValue]]) return;
	
	[gradient release];
	gradient = nil;
	
	[super setObjectValue:value];
}
- (void)dealloc
{
	[gradient release];
	gradient = nil;
	
	[super dealloc];
}

- (void)setLabelStyle:(NSInteger)style
{
	labelStyle = style;
}
- (NSInteger)labelStyle
{
	return labelStyle;
}
- (void)setDrawX:(BOOL)flag
{
	drawX = flag;
}
- (BOOL)isDrawX
{
	return drawX;
}

- (NSColor *)baseColor
{
	NSColor *result = nil;
	switch([self integerValue]) {
		case HMLabelNone:
			result = [NSColor darkGrayColor];
			break;
		case HMLabelRed:
			result = [NSColor colorWithCalibratedRed:238 / 255.0
											   green:93 / 255.0
												blue:84 / 255.0
											   alpha:1.0];
			break;
		case HMLabelOrange:
			result = [NSColor orangeColor];
			break;
		case HMLabelYellow:
			result = [NSColor colorWithCalibratedRed:225 / 255.0
											   green:207 / 255.0
												blue:60 / 255.0
											   alpha:1.0];
			break;
		case HMLabelGreen:
			result = [NSColor colorWithCalibratedRed:160 /255.0
											   green:190/ 255.0
												blue:59 / 255.0
											   alpha:1.0];
			break;
		case HMLabelBlue:
			result = [NSColor colorWithCalibratedRed:80 / 255.0
											   green:145 / 255.0
												blue:230 / 255.0
											   alpha:1.0];
			break;
		case HMLabelPurple:
			result = [NSColor colorWithCalibratedRed:141 / 255.0
											   green:104 / 255.0
												blue:160 / 255.0
											   alpha:1.0];
			break;
		case HMLabelGray:
			result = [NSColor grayColor];
			break;
	}
	
	return result;
}
- (NSColor *)highlightColor
{
	return [[self baseColor] highlightWithLevel:0.45];
}
- (NSGradient *)gradient
{
	if([self integerValue] == HMLabelNone) return nil;
	
	if(gradient) return gradient;
	gradient = [[NSGradient alloc] initWithStartingColor:[self highlightColor] endingColor:[self baseColor]];
	
	return gradient;
}
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSRect interFrame;
	if([self isBordered]) {
		interFrame = NSInsetRect(cellFrame, 2, 2);
	} else {
		interFrame = cellFrame;
	}
	if(![self isEnabled] || ![self isBordered] || NSOnState != [self state]) {
		[self drawInteriorWithFrame:interFrame inView:controlView];
		return;
	}
	
	[NSGraphicsContext saveGraphicsState];
	
	[[NSColor lightGrayColor] set];
	NSShadow *shadow = [[[NSShadow alloc] init] autorelease];
	[shadow setShadowOffset:NSMakeSize(.3, .3)];
	[shadow setShadowBlurRadius:0.5];
	[shadow set];
	NSFrameRect(cellFrame);
	
	[NSGraphicsContext restoreGraphicsState];
	
	[self drawInteriorWithFrame:interFrame inView:controlView];
}
- (NSBezierPath *)bezierWithFrame:(NSRect)cellFrame
{
	if(labelStyle == HMSquareStyle) {
		CGFloat radius = cellFrame.size.width * 0.1;
		radius = MIN(radius, cellFrame.size.height * 0.1);
		return [NSBezierPath bezierPathWithRoundedRect:cellFrame xRadius:radius yRadius:radius];
	}
	
	CGFloat circleRadius = (cellFrame.size.height - 2) / 2.0;
	
	NSRect circleRect = NSMakeRect(NSMidX(cellFrame) - circleRadius, NSMidY(cellFrame) - circleRadius,
								   circleRadius * 2, circleRadius * 2);
	return [NSBezierPath bezierPathWithOvalInRect:circleRect];
}
- (CGFloat)gradientAngle
{
	if(labelStyle == HMSquareStyle) return -90.0;
	return 90.0;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	if(drawX && [self integerValue] == HMLabelNone) {
		cellFrame = NSInsetRect(cellFrame, 3, 3);
		CGFloat maxX, midX, minX, maxY, midY, minY;
		maxX = NSMaxX(cellFrame); midX = NSMidX(cellFrame); minX = NSMinX(cellFrame);
		maxY = NSMaxY(cellFrame); midY = NSMidY(cellFrame); minY = NSMinY(cellFrame);
		CGFloat d = 1;
		
		NSBezierPath *result = [NSBezierPath bezierPath];
		[result setLineWidth:1];
		[result moveToPoint:NSMakePoint(minX + d, minY)];
		[result lineToPoint:NSMakePoint(midX, midY - d)];
		[result lineToPoint:NSMakePoint(maxX - d, minY)];
		[result lineToPoint:NSMakePoint(maxX, minY + d)];
		[result lineToPoint:NSMakePoint(midX + d, midY)];
		[result lineToPoint:NSMakePoint(maxX, maxY - d)];
		[result lineToPoint:NSMakePoint(maxX - d, maxY)];
		[result lineToPoint:NSMakePoint(midX, midY + d)];
		[result lineToPoint:NSMakePoint(minX + d, maxY)];
		[result lineToPoint:NSMakePoint(minX, maxY - d)];
		[result lineToPoint:NSMakePoint(midX - d, midY)];
		[result lineToPoint:NSMakePoint(minX, minY + d)];
		[result closePath];
		
		
		[[self baseColor] set];
		[result fill];
		
		return;
	}
	
	[[self gradient] drawInBezierPath:[self bezierWithFrame:cellFrame] angle:[self gradientAngle]];
}

@end
