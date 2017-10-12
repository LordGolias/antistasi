#define EFUNC(name) DICT_fnc_##name
#define ISOBJECT(_value) (typeName _value == "OBJECT")
#define ISARRAY(_value) (typeName _value == "ARRAY")

#define OB_SEPARATOR ((toString [13,10]) + "%%%>")
#define OB_START ("%%%{" + (toString [13,10]))
#define OB_END ((toString [13,10]) + "%%%}")
#define AR_START ("%%%[" + (toString [13,10]))
#define AR_END ((toString [13,10]) + "%%%]")

#define TYPE_TO_STRING(_typeName) (_typeName select [0,2])
