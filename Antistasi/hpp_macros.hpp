#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1
#define FNC_FILE_BASE(func) QUOTE(DOUBLES(fnc,func).sqf)
#define FNC_BASE(func) class func {file = FNC_FILE_BASE(func);}
#define FNC_FILE(component,func) QUOTE(component\DOUBLES(fnc,func).sqf)
#define FNC(component,func) class func {file = FNC_FILE(component,func);}
#define INIT_FNC(component,func) class func {file = FNC_FILE(component,func); preInit = 1;}

#define FNC_UI_FILE(component,func) QUOTE(component\TRIPLES(fnc,UI,func).sqf)
#define FNC_UI(component,func) class UI_##func {file = FNC_UI_FILE(component,func);}
#define FNC_UI_PREFIX(component,prefix,func) class TRIPLES(UI,prefix,func) {file = FNC_UI_FILE(component\prefix,func);}
