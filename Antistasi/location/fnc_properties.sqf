// Returns all properties of a given type.

// one parameter, the location type
private _properties = ["type", "position", "size", "side", "garrison",
                       "spawned", "forced_spawned"];
switch (_this) do {
    case "city": {
        _properties append ["population","FIAsupport","AAFsupport","roads"];
        _properties = _properties - ["side"];
    };
    case "base": {
        _properties append ["busy"];
    };
    case "airfield": {
        _properties append ["busy"];
    };
    case "camp": {  // the camp has a name
        _properties append ["name"];
    };
    case "minefield": {
        _properties append ["mines", "found"];  // [[type, pos, dir], bool]
        _properties = _properties - ["garrison"];
    };
    case "roadblock": {
        _properties append ["location"];  // the associated location of the roadblock
    };
    default {
        []
    };
};
_properties
