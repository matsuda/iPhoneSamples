//
//  UIImage+Filter.m
//  TestCG
//
//  Created by matsuda on 12/07/25.
//
//

/*
 http://iphone.longearth.net/2009/10/20/【iphone】カメラアプリ系の画像処理をする/
 */

#import "UIImage+Filter.h"

@implementation UIImage (Filter)

- (UIImage*)gradationImage:(CGRect)rect
{
	// CGImageを取得する
	CGImageRef cgImage;
	cgImage = self.CGImage;
    
	// 画像情報を取得する
	size_t width;
	size_t height;
	size_t bitsPerComponent;
	size_t bitsPerPixel;
	size_t bytesPerRow;
	CGColorSpaceRef colorSpace;
	CGBitmapInfo bitmapInfo;
	bool shouldInterpolate;
	CGColorRenderingIntent intent;
	width = CGImageGetWidth(cgImage);
	height = CGImageGetHeight(cgImage);
	bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
	bitsPerPixel = CGImageGetBitsPerPixel(cgImage);
	bytesPerRow = CGImageGetBytesPerRow(cgImage);
	colorSpace = CGImageGetColorSpace(cgImage);
	bitmapInfo = CGImageGetBitmapInfo(cgImage);
	shouldInterpolate = CGImageGetShouldInterpolate(cgImage);
	intent = CGImageGetRenderingIntent(cgImage);
    
	// データプロバイダを取得する
	CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    
	if (rect.size.width + rect.origin.x  > width) {
		rect.size.width = width - rect.origin.x;
	}
	if (rect.size.height + rect.origin.y > height) {
		rect.size.height = height - rect.origin.y;
	}
    
    
	// ビットマップデータを取得する
	CFDataRef data = CGDataProviderCopyData(dataProvider);
	UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
	// ビットマップに効果を与える

//	NSUInteger i, j;
//	for (j = rect.origin.y ; j < rect.origin.y + rect.size.height; j++)
//	{
//		for (i = rect.origin.x; i < rect.origin.x + rect.size.width; i++)
//		{
//			// ピクセルのポインタを取得する
//			UInt8* tmp = buffer + j * bytesPerRow + i * 4;
//            
//			// RGBの値を取得する
//			UInt8 r, g, b;
//			r = *(tmp + 3);
//			g = *(tmp + 2);
//			b = *(tmp + 1);
//            
//			// 輝度値を計算する
//			UInt8 y = (77 * r + 28 * g + 151 * b) / 256;
//            
//			// 輝度の値をRGB値として設定する
//			*(tmp + 1) = y;//b
//			*(tmp + 2) = y;//g
//			*(tmp + 3) = y;//r
//		}
//    }

    CGPoint center = CGPointMake(width / 2, height / 2);
    CGFloat outerRadius = distanceBetweenPoints(CGPointMake(0, 0), center);
    CGFloat innerRadius = rect.size.width / 2;
    CGFloat innerDistance = outerRadius - innerRadius;
    NSLog(@"outerRadius >>> %f", outerRadius);
    NSLog(@"innerRadius >>> %f", innerRadius);
    NSLog(@"innerDistance >>> %f", innerDistance);
    CGFloat distance = 0.f;

	NSUInteger i, j;
	for (j = 0 ; j < height; j++)
	{
		for (i = 0; i < width; i++)
		{
            CGPoint point = CGPointMake(i, j);
            distance = distanceBetweenPoints(point, center);
            if (distance <= innerRadius) {
                continue;
            }

			// ピクセルのポインタを取得する
			UInt8* tmp = buffer + j * bytesPerRow + i * 4;
            
			// RGBの値を取得する
			UInt8 r, g, b;
			r = *(tmp + 0);
			g = *(tmp + 1);
			b = *(tmp + 2);

            // エフェクトをかける割合
            CGFloat deltaDistance = distance - innerRadius;
            CGFloat delta = 1.f - deltaDistance / innerDistance;

			// 輝度の値をRGB値として設定する
			*(tmp + 0) = r * (delta * 100) / 100;//r
			*(tmp + 1) = g * (delta * 100) / 100;//g
			*(tmp + 2) = b * (delta * 100) / 100;//b
		}
    }

	// 効果を与えたデータを作成する
	CFDataRef effectedData;
	effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
	// 効果を与えたデータプロバイダを作成する
	CGDataProviderRef effectedDataProvider;
	effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
	// 画像を作成する
	CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage* effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];

	// 作成したデータを解放する
	CGImageRelease(effectedCgImage);
	CFRelease(effectedDataProvider);
	CFRelease(effectedData);
	CFRelease(data);	
    
	return effectedImage;
}

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
}

- (UIImage*)averageFilter:(NSInteger)pixel toRect:(CGRect)rect
{
	// CGImageを取得する
	CGImageRef cgImage;
	cgImage = self.CGImage;
    
	// 画像情報を取得する
	size_t width = CGImageGetWidth(cgImage);
	size_t height = CGImageGetHeight(cgImage);
	size_t bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
	size_t bitsPerPixel = CGImageGetBitsPerPixel(cgImage);
	size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
	CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(cgImage);
	bool shouldInterpolate = CGImageGetShouldInterpolate(cgImage);
	CGColorRenderingIntent intent = CGImageGetRenderingIntent(cgImage);
    
	// データプロバイダを取得する
	CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    
	// ビットマップデータを取得する
	CFDataRef data = CGDataProviderCopyData(dataProvider);
	UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
	// ビットマップに効果を与える
//	NSUInteger i, j;
//    
//	for (j = pixel ; j < height -pixel; j++)
//	{
//		for (i = pixel ; i < width -pixel; i++)
//		{
//			// ピクセルのポインタを取得する
//			UInt8* tmp = buffer + j * bytesPerRow + i * 4;
//            
//			// RGBの値を取得する
//			UInt8 r, g, b;
//			r = *(tmp + 3);//b
//			g = *(tmp + 2);//g
//			b = *(tmp + 1);//r
//            
//			Float32 sumr, sumg, sumb;
//			sumr = 0;
//			sumg = 0;
//			sumb = 0;
//			for (int k=-pixel;k<=pixel;k++){
//				for (int l=-pixel;l<=pixel;l++){
//					UInt8* t = buffer + (j+k) * bytesPerRow + (i+l) * 4;
//					sumr += *(t + 3);
//					sumg += *(t + 2);
//					sumb += *(t + 1);
//				}
//			}
//            
//			*(tmp + 1) = sumb/pow((1+(2*pixel)),2);//b
//			*(tmp + 2) = sumg/pow((1+(2*pixel)),2);//g
//			*(tmp + 3) = sumr/pow((1+(2*pixel)),2);//r
//		}
//    }
    
    CGPoint center = CGPointMake(width / 2, height / 2);
    CGFloat outerRadius = distanceBetweenPoints(CGPointMake(0, 0), center);
    CGFloat innerRadius = rect.size.width / 2;
    CGFloat innerDistance = outerRadius - innerRadius;
    NSLog(@"outerRadius >>> %f", outerRadius);
    NSLog(@"innerRadius >>> %f", innerRadius);
    NSLog(@"innerDistance >>> %f", innerDistance);
    CGFloat distance = 0.f;

	NSUInteger i, j;
    
	for (j = pixel ; j < height -pixel; j++)
	{
		for (i = pixel ; i < width -pixel; i++)
		{
            CGPoint point = CGPointMake(i, j);
            distance = distanceBetweenPoints(point, center);
            if (distance <= innerRadius) {
                continue;
            }

			// ピクセルのポインタを取得する
			UInt8* tmp = buffer + j * bytesPerRow + i * 4;
            
			// RGBの値を取得する
			UInt8 r, g, b;
			r = *(tmp + 0);//b
			g = *(tmp + 1);//g
			b = *(tmp + 2);//r

			Float32 sumr, sumg, sumb;
			sumr = 0;
			sumg = 0;
			sumb = 0;
			for (int k=-pixel;k<=pixel;k++){
				for (int l=-pixel;l<=pixel;l++){
					UInt8* t = buffer + (j+k) * bytesPerRow + (i+l) * 4;
					sumr += *(t + 0);
					sumg += *(t + 1);
					sumb += *(t + 2);
				}
			}
            
			*(tmp + 2) = sumb/pow((1+(2*pixel)),2);//b
			*(tmp + 1) = sumg/pow((1+(2*pixel)),2);//g
			*(tmp + 0) = sumr/pow((1+(2*pixel)),2);//r
		}
    }

	// 効果を与えたデータを作成する
	CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
	// 効果を与えたデータプロバイダを作成する
	CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
	// 画像を作成する
	CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage* effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
	// 作成したデータを解放する
	CGImageRelease(effectedCgImage);
	CFRelease(effectedDataProvider);
	CFRelease(effectedData);
	CFRelease(data);
    
	return effectedImage;	
}

@end
