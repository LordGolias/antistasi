// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4


////////////////
//Base Classes//
////////////////

// class used to set a common theme.
class RscColors {
    colorBackground[] = {
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
        0.7
    };
    colorBackgroundActive[] = {
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
        1
    };
    colorBackgroundDisabled[] = {0.95,0.95,0.95,1};

    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.4,0.4,0.4,1};
    
    font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    access = 0;

    shadow = 2;
	colorShadow[] = {0,0,0,1};
};


class RscPicture
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "PuristaMedium";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};

class RscButton : RscColors {
    idc = -1;
    type = 1;
    style = 2;
    borderSize = 0;

    colorBorder[] = {0,0,0,1};
    colorFocused[] = {
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
        1
    };

    offsetPressedX = 0;
    offsetPressedY = 0;
    offsetX = 0;
    offsetY = 0;
    soundClick[] = {"\A3\ui_f\data\sound\onclick",0.07,1};
    soundEnter[] = {"\A3\ui_f\data\sound\onover",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\onescape",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\new1",0,0};
};

class RscFrame {
    type = CT_STATIC;
    idc = -1;
    style = ST_FRAME;
    shadow = 0;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "PuristaMedium";
    sizeEx = 0.05;
    text = "";
};

class RscListBox : RscColors {
	deletable = 0;
	fade = 0;
	type = CT_LISTBOX;
	rowHeight = 0;
	//colorScrollbar[] = {1,0,0,0.5};
	colorSelect[] = {1,1,1,1,0.5};
	colorSelect2[] = {1,1,1,0.5};

	colorSelectBackground[] = {0,0,0,0.5};
	colorSelectBackground2[] = {0.667,0.714,0.635,1};
	soundSelect[] = {
		"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;

    colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};

    tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class ListScrollBar {
		color[] = {0,0,0,0.5};
		autoScrollEnabled = 1;
        arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
        arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	};
	style = LB_TEXTURES;
	period = 1.2;
	maxHistoryDelay = 1;
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
};

class RscEdit : RscColors {
  type = CT_EDIT;
  style = ST_LEFT+ST_FRAME;
  autocomplete = "";
  text = "";

  colorSelection[] = {1,1,1,1,0.5};
};

// The height of a button
#define BTN_H (0.03 * safezoneH)
// The height between buttons
#define BTN_SPACING (BTN_H/2)

// distance of the box to the back button.
#define BOX_BTN_SPACING (0.02 * safezoneH)

// the height of the box in number of rows of buttons
// BOX_BTN_SPACING + BTN_SPACING between the last button and the box.
#define BOX_H(n) (BOX_BTN_SPACING + 2*BTN_SPACING + BTN_H + n*(BTN_SPACING + BTN_H))

// Box is centered.
#define BOX_Y(n) (0)

// Frame position is the same as the box. The heigh is almost the same.
#define FRAME_H(n) (BOX_H(n) - 0.02)

// distance of back button.
#define BTN_BACK_Y(n) (BOX_Y(n) + BOX_BTN_SPACING)

#define BTN_Y(n) (BTN_BACK_Y(n) + n*(BTN_SPACING + BTN_H))

// size of list (same as the size of n buttons combined.)
#define LIST_H(nSize) (nSize*(BTN_SPACING + BTN_H) - BTN_SPACING)

#define BTN_X_L (0.272481 * safezoneW + safezoneX)
#define BTN_X_R (0.482498 * safezoneW + safezoneX)
#define BTN_X_M (0.37749 * safezoneW + safezoneX)

// 0 => BTN_X_L, 1 => BTN_X_R
#define LEFT_OR_RIGHT(position) (BTN_X_L + position*(BTN_X_R - BTN_X_L))

#define BTN_W (0.175015 * safezoneW)

#define A_CLOSE "closeDialog 0"

// the black box that fills the dialog.
class AS_box {
  type = CT_STATIC;
  idc = -1;
  style = 0;
  sizeEx = 0;
  shadow = 0;
  colorText[] = {1,1,1,1};
  font = "PuristaMedium";
  colorBackground[] = {0,0,0,0.5};  // the base color of the menu back.
  text = "";
  x = 0.244979 * safezoneW + safezoneX;
  y = 0;
  w = (0.445038 * safezoneW);
  h = BOX_H_2;
};

#define AS_BOX(n) \
class NAME##AS_box : AS_box { \
  y = BOX_Y(n); \
  h = BOX_H(n); \
};\

class AS_frame: RscFrame
{
  idc = -1;
  text = "";
  x = 0.254979 * safezoneW + safezoneX;
  y = 0;
  w = 0.425038 * safezoneW;
  h = FRAME_H_2;
};

#define AS_FRAME(n,F_TEXT) \
class NAME##FRAME : AS_frame { \
  y = BOX_Y(n); \
  h = FRAME_H(n); \
  text= F_TEXT; \
};\

class AS_button_back: RscButton
{
  idc = 72;  // so we can modify it if needed.
  text = "Back";
  x = 0.61 * safezoneW + safezoneX;
  w = 0.06 * safezoneW;
  h = BTN_H;
  action = A_CLOSE;
};

#define BTN_BACK(n,BTN_ACTION) \
class NAME##BTN_B##n : AS_button_back { \
  y = BTN_BACK_Y(n); \
  action = BTN_ACTION; \
};\

class AS_button_L: RscButton
{
  idc = -1;
  text = "";
  x = BTN_X_L;
  w = BTN_W;
  h = BTN_H;
  action = A_CLOSE;
};

class AS_button_R: AS_button_L
{
  x = BTN_X_R;
};

#define BTN_L(n,BTN_IDC,BTN_TEXT,BTN_TOOLTIP,BTN_ACTION) \
class NAME##BTN_L##n : AS_button_L { \
  y = BTN_Y(n); \
  idc = BTN_IDC; \
  text = BTN_TEXT; \
  toolTip = BTN_TOOLTIP; \
  action = BTN_ACTION; \
};\

#define BTN_R(n,BTN_IDC,BTN_TEXT,BTN_TOOLTIP,BTN_ACTION) \
class NAME##BTN_R##n : AS_button_R { \
  y = BTN_Y(n); \
  idc = BTN_IDC; \
  text = BTN_TEXT; \
  toolTip = BTN_TOOLTIP; \
  action = BTN_ACTION; \
};\

#define BTN_M(n,BTN_IDC,BTN_TEXT,BTN_TOOLTIP,BTN_ACTION) \
class NAME##BTN_M##n : AS_button_R { \
  y = BTN_Y(n); \
  idc = BTN_IDC; \
  text = BTN_TEXT; \
  x = BTN_X_M; \
  toolTip = BTN_TOOLTIP; \
  action = BTN_ACTION; \
};\

// A box, frame, and back button.
#define AS_DIALOG(n,F_TEXT,BACK_ACTION) \
AS_BOX(n); \
AS_FRAME(n,F_TEXT); \
BTN_BACK(n,BACK_ACTION);

// List of stuff
class AS_RscListBox : RscListBox {
    w = BTN_W;
    
};

#define LIST_L(P, yP,IDC,nSize,ON_SELECTION) \
class NAME##LIST_L##nPosition : AS_RscListBox { \
  x = LEFT_OR_RIGHT(P); \
  y = BTN_Y(yP); \
  h = LIST_H(nSize); \
  idc = IDC; \
  onLBSelChanged  = ON_SELECTION; \
};

class AS_RscEdit : RscEdit {
    w = BTN_W;
    h = BTN_H;
};

#define WRITE(position,n,BTN_IDC,BTN_TEXT) \
class NAME##WRITE##position##n : AS_RscEdit { \
  x = LEFT_OR_RIGHT(position); \
  y = BTN_Y(n); \
  idc = BTN_IDC; \
  text = BTN_TEXT; \
};\
