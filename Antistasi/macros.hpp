#define AS_P(name) (AS_persistent getVariable name)
#define AS_Pset(name,value) (AS_persistent setVariable [name,value,true])

#define AS_S(name) (server getVariable name)
#define AS_Sset(name,value) (server setVariable [name,value,true])


#define AS_SERVER_ONLY(name) (if !(isServer) then {diag_log format ["[AS] Error: Server-only script " + name + " called"]})

#define AS_ISDEBUG(message) (if (AS_DEBUG_flag) then {diag_log ("[AS] DEBUG: " + (message))})
