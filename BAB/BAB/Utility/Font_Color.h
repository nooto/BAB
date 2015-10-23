//
//#import "EHFont_Color.h"

#import "EHSysProperty.h"

#define Color_Navbar            ColorFromHex(0x2A3645)

#define Color_Cell_Separator    ColorFromHex(0xe5e5e5)
#define Color_Title             ColorFromHex(0x656565)

#define Color_text             ColorFromHex(0x646662)

#define Color_Btn_Highlighted   ColorFromHex(0xF0D0C0)
#define Color_Cell_Highlighted  ColorFromHex(0xf0f0f0)

#define Color_orange_F866822    ColorFromHex(0xf86822)//橙色
#define Color_green_88C057      ColorFromHex(0x88c057)//绿色
#define Color_red_eb5050        ColorFromHex(0xeb5050) //红色
#define Color_deepGray_666666   ColorFromHex(0x666666)//深灰
#define Color_midGary_9b9b9b    ColorFromHex(0x9b9b9b)//中灰
#define Color_littleGary_e5e5e5 ColorFromHex(0xe5e5e5)//浅灰（用于文本框内提示文字）


//根据屏幕来确定 宽度和高度上对应的间隔大小。

//2015-05-20 19:23:36
#define Color_greed_normal      ColorFromHex(0x69b825)      //绿色文字 普通效果
#define Color_greed_lighted     ColorFromHexRGBA(0x69b82580)   //绿色文字 触发效果 50%透明度

#define Color_blue_normal       ColorFromHex(0x5eb6d6)    //浅灰（用于文本框内提示文字）
#define Color_blue_lighted      ColorFromHex(0x53a1bd)   //浅灰（用于文本框内提示文字）

#define Color_orange_normal     ColorFromHex(0xFA7646)   //橘色 退出登录用
#define Color_orange_lighted    ColorFromHexRGBA(0xFA764680)//橘色文字 触发效果。。

#define Color_gray_343F52       ColorFromHex(0x343F52)//灰色  发现设备中的背景色
#define Color_AFAFAF            ColorFromHex(0xAFAFAF)//灰色  发现设备中的背景色

#define Color_white_100         ColorFromHex(0xffffff)      //[Utility colorFromColorString:@"#ffffff" alpha:1.0f]       //浅灰（用于文本框内提示文字）
#define Color_white_80          [UIColor colorWithWhite:255 alpha:0.8f]
#define Color_white_50          ColorFromHexRGBA(0xffffff7f)//[Utility colorFromColorString:@"#ffffff" alpha:0.5f]  //浅灰（用于文本框内提示文字）
#define Color_white_30          [UIColor colorWithWhite:255 alpha:0.3f]
#define Color_white_20          ColorFromHexRGBA(0xffffff33)//[Utility colorFromColorString:@"#ffffff" alpha:0.2f]  //浅灰（用于文本框内提示文字）
#define Color_white_10          ColorFromHexRGBA(0xffffff19)//[Utility colorFromColorString:@"#ffffff" alpha:0.2f]  //浅灰（用于文本框内提示文字）
#define Color_white_3           [UIColor colorWithWhite:255 alpha:0.03f]
#define Color_white_6           [UIColor colorWithWhite:255 alpha:0.06f]
#define Color_white_5           [UIColor colorWithWhite:255 alpha:0.05f]
#define Color_white_8           [UIColor colorWithWhite:255 alpha:0.08f]

//新的分割线颜色
#define Color_Split_Line        ColorFromHex(0xe0e0e0)
#define Color_Back_Ground       ColorFromHex(0xf5f5f5)

#define Color_black_5           [UIColor colorWithRed:0 green:0 blue:0  alpha:0.05f]
#define Color_black_10          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1f]
#define Color_black_20          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f]
#define Color_black_30          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]
#define Color_black_50          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]
#define Color_black_60          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]
#define Color_black_100          [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]

//2015-09-23 11:31:36
#define Color_line              Color_Split_Line//[UIColor colorWithWhite:255 alpha:0.1f]

#define Font20                  [UIFont systemFontOfSize:MarginW(20.0f)]
#define Font20Bold              [UIFont boldSystemFontOfSize:MarginW(20.0f)]

#define FontTitle               [UIFont systemFontOfSize:MarginW(18.0f)] //大号36
#define FontTitleBold           [UIFont boldSystemFontOfSize:MarginW(18.0f)] //大号36

#define Font17                 [UIFont systemFontOfSize:MarginW(17.0f)] //大号34
#define Font17Bold             [UIFont boldSystemFontOfSize:MarginW(17.0f)] //大号34

#define FontSmall               [UIFont systemFontOfSize:MarginW(16.0f)]
#define FontSmallBold           [UIFont boldSystemFontOfSize:MarginW(16.0f)]

#define Font16                  [UIFont systemFontOfSize:16.0f] //小号32
#define Font16Bold              [UIFont boldSystemFontOfSize:16.0f] //小号32

#define Font15                  [UIFont systemFontOfSize:MarginW(15)]
#define Font15Bold              [UIFont boldSystemFontOfSize:MarginW(15)]

#define Font14                  [UIFont systemFontOfSize:MarginW(14.0f)] //小号28
#define Font14Bold              [UIFont boldSystemFontOfSize:MarginW(14.0f)] //小号28

#define Font13                  [UIFont systemFontOfSize:MarginW(13.0f)]
#define Font13Bold              [UIFont boldSystemFontOfSize:MarginW(13.0f)]

#define Font12                  [UIFont systemFontOfSize:MarginW(12.0f)]
#define Font12Bold              [UIFont boldSystemFontOfSize:MarginW(12.0f)]

#define Font11                  [UIFont systemFontOfSize:MarginW(11.0f)]
#define Font11Bold              [UIFont boldSystemFontOfSize:MarginW(11.0f)]

#define Font10                  [UIFont systemFontOfSize:MarginW(10.0f)]
#define Font10Bold              [UIFont boldSystemFontOfSize:MarginW(10.0f)]
