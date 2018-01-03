; KeypressOSD.ahk
; Latest version at:
; http://marius.sucan.ro/media/files/blog/ahk-scripts/keypress-osd.ahk
;
; Charset for this file must be UTF 8 with BOM.
; it may not function properly otherwise.
;
;--------------------------------------------------------------------------------------------------------------------------
;
; Keyboard language definitions file:
;   keypress-osd-languages.ini
;   http://marius.sucan.ro/media/files/blog/ahk-scripts/keypress-osd-languages.ini
;   File required for AutoDetectKBD = 1, to detect keyboard layouts.
;   File must be placed in the same folder with the script.
;   It adds support for around 50 keyboard layouts covering about 31 languages.
;
; AVAILABLE SHORTCUTS:
 ; Ctrl+Alt+Shift+F8  - Toggles "Show single key" option. Useful when you type passwords or must reliably use dead keys.
 ; Ctrl+Alt+Shift+F9  - Toggles between two OSD offsets: GuiYa and GuiYb.
 ; Ctrl+Alt+Shift+F10 - Toggles personal/regional keys support.
 ; Ctrl+Alt+Shift+F11 - Detect keyboard language.
 ; Ctrl+Alt+Shift+F12 - Reinitialize OSD. Useful when it no longer appears on top. To have it appear on top of elevated apps, run it in administrator mode.
 ; Shift+Pause/Break  - Suspends the script and all its shortcuts.
;
; NOTES:
 ;
 ; I invest time in this script for people like me, with poor eye sight
 ; or low vision. It is meant to aid desktop computer usage.
 ;
 ; This script was made for, and on Windows 10.
 ; The keyboard layouts have changed since Win XP or Win 98.
 ; Windows 10 also no longer switches keyboard layouts based
 ; on the currently active app. As such, automatic keyboard
 ; layout detection may not work for you.
 ; 
 ; I do not intend to offer support for older Windows versions.
 ; 
 ; This script has support only for Latin-based keyboards.
 ; Thus, it has no support for Chinese, Japanese, chirilic, 
 ; It is too complex for me to implement support for other alphabets or writing systems.
 ; If other programmers willing to invest the time in this script,
 ; are welcomed to do so, and even to transform it into anything they wish. 
 ;
 ; I offer numerous options/settings in the script such that
 ; everyone can find a way to adapt it to personal needs.
 ; - you can edit, in the code, what are the dead keys
 ;   - see Loop, 95, char2skip from CreateHotkey() function
 ; - you can also define personal regional keys, while autodetect is disabled
 ; - disable dead keys if you do not have such keys
 ; 
 ; Read the messages you get:
 ; - it indicates when your keyboard layout is unsupported or Unrecognized
 ; - it also indicates if it made a partial match;
 ;   - in such cases, you will likely not have all the keys
 ;   - or simply AHK will give errors trying to bind to inexistent keys
 ; - if the external file is missing, languages.ini, it will always report
 ; that it did not detect your keyboard.
 ;
 ; Default/built in language support is for English International.
 ;
 ; For the layouts I added support, I avoided binding to dead keys
 ; such that you no longer have to add them manually, as indicated previously.
 ; 
 ; If you rely only on the "vanilla" version, you will likely 
 ; not be able to use it. You can easily add language support,
 ; by editing the files of the script.
 ;
 ; I am no programmer and the script is still quite quirky, but I am trying to
 ; make it better and better with each version.
 ; My progresses with the script are thanks to the great help from the people on #ahk (irc.freenode.net).
 ;
;
; FEATURES:
 ;
 ; - Show previously pressed key if fired quickly.
 ; - Count key presses or key fires and mouse clicks.
 ; - Automatic resizing of OSD/HUD or fixed size.
 ; - Hides automatically when mouse runs over it.
 ; - Visual mouse clicks and idle mouse highlighter/locator
 ; - Generate beeps for key presses, modifiers, mouse clicks or just when typing with Capslock.
 ; - Clipboard monitor. It displays briefly texts copied to clipboard.
 ; - Indicators for CapsLock, NumLock and ScrollLock states.
 ; - Typing mode. It shows what you are typing in an expanding text area.
 ; - Partial dead keys support, option to turn it off; The work-around is only for the English International keyboard layout.
 ; - Support for many non-English keyboards. 50 keyboard layouts defined for over 30 languages.
 ;   - limited automatic detection of keyboard layouts.
 ;   - the user also has the option to define his regional keys.
 ; - Easy to configure with many options:
 ;   - to toggle features: visual mouse clicks, key beepers, key counting or previous key;
 ;   - to hide modifiers, mouse clicks or single key presses (which disables typing mode);
 ;   - or hide keys that usually get in the way: Left Click and Print Screen [HideAnnoyingKeys];
 ;   - differ between left and right modifiers;
 ;   - OSD/HUD position, size and display time;
 ;   - beep key presses even if keys are not displayed;
 
;
; CHANGELOG:
 ;
 ; by Marius Sucan (robodesign.ro)
 ;   v3.02 (2017-10-22)
 ;   - [new] an option to disable typing mode
 ;   - minor bug fixes
 ;   v3.01 (2017-10-21)
 ;   - bug fixes related to visual mouse clicks
 ;   - added support for Capture2Text. Shortcut for this: Alt+Pause/Break
 ;     - requires Capture2Text with shortcut set to Pause/Break
 ;   v3.00 (2017-10-20)
 ;   - [new] visual mouse clicks and idle mouse highlighter/locator
 ;   v2.99 (2017-10-17)
 ;   - automatic download of the language definitions file, if the file is missing
 ;   - added support for another 10 keyboard layouts when pressing Shift + [numbers/symbols].
 ;   v2.98 (2017-10-15)
 ;   - added support for another 12 keyboard layouts when pressing Shift + [numbers/symbols]. About 20 still to go.
 ;   v2.97 (2017-10-14)
 ;   - new shortcut: Pause/Break, to suspend/resume the script
 ;   - added support for 12 keyboard layouts when pressing Shift + [numbers/symbols]
 ;   - added support for a new keyboard layout: Croatian
 ;   - after pressing Shift + [letter/symbols], you will get into typing mode
 ;   - Shift + [numpad keys] works now somehow, somehow, still glitchy/quirky, but better than nothing...
 ;   v2.95 (2017-10-13)
 ;   - fixed counting related issues
 ;   - it now shows Shift+[numbers/symbols] ; many thanks to phaleth and the great folks on #ahk
 ;   - error handling for missing non-English keyboards definitions file
 ;   v2.93 (2017-10-12)
 ;   - new option: StickyKeys
 ;   - back again, modifiers behave as I want
 ;     - if StickyKeys is off, modifiers (Ctrl, Shift, Alt, WinKey) do not clear typed texts from the OSD, when pressed once, without a combo
 ;     - if StickyKeys is on, they erase what is written in the OSD, except for Shift, of course
 ;   v2.92 (2017-10-11)
 ;   - rolled back the changes for modifier keys; it resulted in many regressions noticeable for those using StickyKeys; I will insist on this :)
 ;   - clipboard monitoring; it displays briefly what text user copied to clipboard
 ;   - fixed bugs related to showing previous keys
 ;   v2.90 (2017-10-10)
 ;   - from now, numpad keys always initiate typing mode
 ;   - modifiers (Ctrl, Shift, Alt, WinKey) and Tab, Insert no longer clear tets from the OSD, if pressed once, without a combo
 ;   - unified the behaviour of modifiers
 ;   - fixed some counting bugs :)
 ;   - added option to disable PermanentSettings
 ;   v2.87 (2017-10-09)
 ;   - improvements for assigning keys;
 ;     - errors are now managed, it will beep when key bindings fail
 ;   - [new] option to disable audio alerts :)
 ;   - languages are now in an external file
 ;   - new keyboard layouts for Polish, Azerbaijian, Turkmen
 ;   v2.85 (2017-10-08)
 ;   - minor improvements for the dead keys work-around
 ;   - added support for 40 foreign keyboard layouts
 ;   - automatic detection of keyboard layouts, at start or continously
 ;   - user also can define personal/regional keys in the settings section
 ;   - new keyboard shortcut, to toggle regional keys
 ;   - new setting: to enable or disable system-wide keyboard shortcuts
 ;   - settings toggled by shortcuts are stored permanently in an INI file
 ;     - except for the option of regional keys support
 ;   v2.73 (2017-10-05)
 ;   - improvements for automatic resize calculation
 ;   v2.72 (2017-10-04)
 ;   - new option: make beeps on mouse clicks
 ;   - new option: distinct beeper for modifier keys: Shift, Ctrl, Alt, WinKey.
 ;   - new option: beep hidden keys; if you want it to beep even if the keys are not displayed
 ;   - fix: now it always counts mouse clicks
 ;   v2.70 (2017-10-03)
 ;   - added option to toggle dead keys support / work-around.
 ;   - added option to hide annoying keys that usually get in the way: Left Click and Print Screen.
 ;   - redraw improvements, reduced flickering
 ;   - disabled OSD transparency to reduce flickering
 ;   v2.69 (2017-09-30)
 ;   - OSD / GUI hides when mouse is over it. Many thanks to phaleth!
 ;   v2.68 (2017-09-29)
 ;   - numpad keys now work in typing mode as expected; they appear as symbols or numbers
 ;
 ; by phaleth from irc.freenode.net #ahk
 ;   v2.67 (2017-09-28)
 ;   - dead keys improvements
 ;
 ; by Marius Sucan (robodesign.ro)
 ;   v2.66 (2017-09-28)
 ;   - key combinations with Shift work better.
 ;   v2.65 (2017-09-27)
 ;   - Fixed a bug with counting modifier keys;
 ;   - improved the dead keys work-around
 ;   - friendly names for mouse clicks
 ;   - when pressed, volume keys  always generate beeps
 ;   - added option to differentiate between left and right modifiers
 ;   - now it detects AltGr key
 ;   - the key beeper now also makes a beep for modifiers.
 ;   - capslock no longer erases text you are typing displayed by the OSD
 ;   - now you can toggle between two different OSD positions with Ctrl + Alt + Shift + F9
 ;   v2.60 (2017-09-26)
 ;   - Fixed many bugs with counting keys;
 ;   - reimplemented the feature to see the previous key combination, if quickly a new one is pressed;
 ;   - added options/settings to toggle previous keys, counting keys and delay;
 ;   - added shortcuts to toggle ShowSingleKey option and to reinitialize the OSD;
 ;   - added option for automatic resizing of the OSD; it can be turned off in the settings section; it is a fishy implementation, but if one adjusts it, can make it to suit personal needs;
 ;   - new option: beep when key is released or when writing with capslock
 ;   v2.58 (2017-09-23)
 ;   - Numpad keys have friendly naming, based on the numlock state.
 ;   - Combinations with space and backspace work again.
 ;   v2.56 (2017-09-22)
 ;   - more fixes for space usage and key combinations;
 ;   - now it indicates when ScrollLock, NumLock and Capslock are activated.
 ;   v2.55 (2017-09-21)
 ;   - minor fixes for space usage and key combinations.
 ;
 ; by Saiapatsu from irc.freenode.net #ahk
 ;   v2.54 (2017-09-21)
 ;   - Scrolls through n recently typed characters instead of just the latest word
 ;   v2.53 (2017-09-21)
 ;   - Case change effect limited to the loop 95 letters only.
 ;   v2.52 (2017-09-21)
 ;   - Now supports backspace. Commented out CapsLock beeper.
 ;   v2.51 (2017-09-21)
 ;   - Changed labels to functions, added ToolWindow style to window, changed DisplayTime
 ;   calculation, made it show last word typed, hid spacebar presses
 ;   todo: make Shift look less ugly
 ;
 ; by Marius Sucan (robodesign.ro)
 ;   v2.50 (2017-09-20)
 ;   - Changed the OSD positioning and sizing. It was based on the current window. Now it is always fixed in a specific place. Added a Capslock beeper.
 ;
 ; by tmplinshi from https://autohotkey.com/boards/viewtopic.php?f=6&t=225
 ;   v2.22 (2017-02-25)
 ;   - Now pressing same combination keys continuously more than 2 times,
 ;   for example press Ctrl+V 3 times, will displayed as "Ctrl + v (3)"
 ;   v2.21 (2017-02-24)
 ;   - Fixed LWin/RWin not poping up start menu
 ;   v2.20 (2017-02-24)
 ;   - Added displaying continuous-pressed combination keys.
 ;   e.g.: With CTRL key held down, pressing K and U continuously will shown as "Ctrl + k, u"
 ;   v2.10 (2017-01-22)
 ;   - Added ShowStickyModKeyCount option
 ;   v2.09 (2017-01-22)
 ;   - Added ShowModifierKeyCount option
 ;   v2.08 (2017-01-19)
 ;   - Fixed a bug
 ;   v2.07 (2017-01-19)
 ;   - Added ShowSingleModifierKey option (default is True)
 ;   v2.06 (2016-11-23)
 ;   - Added more keys. Thanks to SashaChernykh.
 ;   v2.05 (2016-10-01)
 ;   - Fixed not detecting "Ctrl + ScrollLock/NumLock/Pause". Thanks to lexikos.
 ;   v2.04 (2016-10-01)
 ;   - Added NumpadDot and AppsKey
 ;   v2.03 (2016-09-17)
 ;   - Added displaying "Double-Click" of the left mouse button.
 ;   v2.02 (2016-09-16)
 ;   - Added displaying mouse button, and 3 settings (ShowMouseButton, FontSize, GuiHeight)
 ;   v2.01 (2016-09-11)
 ;   - Display non english keyboard layout characters when combine with modifer keys.
 ;   v2.00 (2016-09-01)
 ;   - Removed the "Fade out" effect because of its buggy.
 ;   - Added support for non english keyboard layout.
 ;   - Added GuiPosition setting.
 ;   v1.00 (2013-10-11)
 ;   - First release by tmplinshi based on RaptorX. Function keys, numpad keys and mouse clicks support. Popups at mouse position.
 ;   v0.50 (2010-03-18)
 ;   - Released by RaptorX.
;--------------------------------------------------------------------------------------------------------------------------
;
; TO-DO:
 ; features to implement:
 ; - show letters/chars generated by AltGr+[keys]
 ; - tray menu or window with options/settings
 ;    - check for updates as an option
 ;    - help, about, version history
 ;    - on first start, save all settings in the INI
 ; - text caret locator/highlighter
 ; - window spy, get texts underneath the mouse using Narrator' s accessbility APIs
 ; - errors journaling?
 ;
 ; glitches to fix [by priority]:
 ; - show a generic symbol for ignored dead keys; helps to clarify one was pressed;
 ; - quirky Shift + [numpad keys]
 ; - sound beeps too loud; lower their volume?
 ; - [minor bug] once a key is pressed, counting of key fires is not initiated after the OSD was hidden for a little awhile;
 ; - make dead keys work better, even detect them ;)
 ; - automatic resizing of the OSD/GUI is just a silly hack based on the default font size and the number of typed chars; it often fails to resize properly;
 ; - redraw issues; it still flickers;
 ; - make it work reliably with sticky keys; if user presses once Ctrl and another key afterwards, it rarely detects the combination on Winndows 7;
;----------------------------------------------------------------------------

; Initialization
 #SingleInstance force
 #NoEnv
 #MaxHotkeysPerInterval 500
 SetBatchLines, -1
 ListLines, Off
 SetWorkingDir, %A_ScriptDir%

; Settings / Customize:

 global DeadKeys         := 1     ; a toggle for a partial dead keys support. Zero [0] means no dead keys. See CreateHotkey() and char2skip to define the dead keys.
 , CustomRegionalKeys    := 0     ; if you want to add support to a regional keyboard
 , RegionalKeysList      := "a|b|c"  ; add the characters in this list, separated by |
 , AutoDetectKBD         := 1     ; at start, detect keyboard layout
 , ConstantAutoDetect    := 0     ; continously check if the keyboard layout changed; if AutoDetectKBD=0, this is ignored
 , SilentDetection       := 0     ; do not display information about language switching
 , audioAlerts           := 1     ; generate beeps when key bindings fail
 
 , DisableTypingMode     := 0     ; do not echo what you write
 , ShowSingleKey         := 1     ; show only key combinations
 , HideAnnoyingKeys      := 1     ; Left click and PrintScreen can easily get in the way.
 , ShowMouseButton       := 1     ; in thee OSD
 , StickyKeys            := 1     ; how modifiers behave; set it to 1 if you use StickyKeys in Windows
 , ShowSingleModifierKey := 1     ; make it display Ctrl, Alt, Shift when pressed alone
 , DifferModifiers       := 0     ; differentiate between left and right modifiers
 , ShowPrevKey           := 1     ; show previously pressed key, if pressed quickly in succession
 , ShowPrevKeyDelay      := 300
 , ShowKeyCount          := 1     ; count how many times a key is pressed
 , ShowKeyCountFired     := 1     ; show only key presses (0) or catch key fires as well (1)
 
 , DisplayTime           := 3000  ; in milliseconds
 , GuiWidth              := 360
 , GuiHeight             := 50
 , GuiX                  := 50
 , GuiYa                 := 250   ; toggle between GuiYa and GuiYb with Ctrl + Alt + Shift + F9
 , GuiYb                 := 800
 , FontSize              := 19
 , OSDautosize           := 1     ; make adjustments in ShowHotkey() to match your font size
 , NumLetters            := 25    ; amount of recently typed letters to display
 , NumLettersAutosize    := 55    ; ...when OSD resizes automatically
 
 , CapslockBeeper        := 1     ; only when the key is released
 , KeyBeeper             := 0     ; only when the key is released
 , ModBeeper             := 0     ; beeps for every modifier, when released
 , MouseBeeper           := 0     ; if both, ShowMouseButton and Visual Mouse Clicks are disabled, mouse click beeps will never occur
 , BeepHiddenKeys        := 0     ; [when any beeper enabled] to beep or not when keys are not displayed by OSD/HUD
 
 , KeyboardShortcuts     := 1     ; system-wide shortcuts
 , PermanentSettings     := 1     ; settings stored in keypress-osd.ini override the settings from here
 , ClipMonitor           := 1     ; show clipboard changes
 , VisualMouseClicks     := 1     ; shows visual indicators for different mouse clicks
 , FlashIdleMouse        := 0     ; locate an idling mouse with a flashing box

; Initialization variables. Altering these may lead to undesired results.

 global IniFile := "keypress-osd.ini"
 , typed := "" ; hack used to determine if user is writing
 , visible := 0
 , GuiY := GuiYb
 , prefixed := 0 ; hack used to determine if last keypress had a modifier
 , Capture2Text := 0
 , zcSCROL := "SCROLL LOCK"
 , tickcount_start := 0 ; timer to count repeated key presses
 , keyCount := 0
 , ShowKeyCountDelay := (ShowKeyCountFired = 0) ? 700 : 6000
 , text_width := 60
 , modifiers_temp := 0
 , shiftPressed := 0
 , MouseClickCounter := 0
 , NumLockForced := 0
 , kbLayoutSymbols := "0"
 , InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
 , NumLetters := (OSDautosize=1) ? NumLettersAutosize : NumLetters

    if PermanentSettings=1
    {
        IniRead, ShowSingleKey, IniFile, PermanentSettings, ShowSingleKey
        IniRead, GuiY, IniFile, PermanentSettings, GuiY
        GuiY := (GuiY=GuiYb || GuiY=GuiYa) ? GuiY : GuiYb
    }

    IniRead, CustomMultiLangToggled, IniFile, PermanentSettings, CustomMultiLangToggled
    if (CustomMultiLangToggled=1) {
        IniRead, CustomRegionalKeys, IniFile, PermanentSettings, CustomRegionalKeys
        CustomMultiLangToggled := 0
        IniWrite, %CustomMultiLangToggled%, IniFile, PermanentSettings, CustomMultiLangToggled
    }

    IniRead, AutoDetectKBDToggled, IniFile, PermanentSettings, AutoDetectKBDToggled
    if (AutoDetectKBDToggled=1) {
        IniRead, AutoDetectKBD, IniFile, PermanentSettings, AutoDetectKBD
        IniRead, ConstantAutoDetect, IniFile, PermanentSettings, ConstantAutoDetect
        AutoDetectKBDToggled := 0
        IniWrite, %AutoDetectKBDToggled%, IniFile, PermanentSettings, AutoDetectKBDToggled
    }


if (visualMouseClicks=1)
{
    CoordMode Mouse, Screen
    CreateMouseGUI()
}

if (FlashIdleMouse=1)
{
    SetTimer, ShowMouseIdleLocation, 1000
}

CreateGUI()
CreateGlobalShortcuts()
CreateHotkey()
if ClipMonitor=1
    OnClipboardChange("ClipChanged")
return

; The script

GetSpecialKeysStates() {
    GetKeyState, ScrollState, ScrollLock, T   
    If ScrollState = D
    {
       global zcSCROL := "SCROLL LOCK ON"
    }
    else {
       global zcSCROL := "Scroll lock off"
    }
}

TypedLetter(key) {
   StringLeft, key, key, 1
   Stringlower, key, key
   GetKeyState, CapsState, CapsLock, T
   If CapsState != D
   {
       if GetKeyState("Shift") || (shiftPressed=1) && (StickyKeys=1)
       {
         StringUpper, key, key
         key := GetShiftedSymbol(key)
       }
   } else
   {
       StringUpper, key, key
   }

    return typed := SubStr(typed key, -NumLetters)
}

OnMousePressed() {
    global tickcount_start := A_TickCount-500
    shiftPressed := 0

    try {

        key := GetKeyStr()
        if (ShowMouseButton=1)
        {
            typed := "" ; concerning TypedLetter(" ") - it resets the content of the OSD
            ShowHotkey(key)
            SetTimer, HideGUI, % -DisplayTime
        }
    }

    if (VisualMouseClicks=1)
    {
       mkey := SubStr(A_ThisHotkey, 3)
       ShowMouseClick(mkey)
    }

    if (MouseBeeper = 1) && (ShowMouseButton = 1) && (ShowSingleKey = 1) || (MouseBeeper = 1) && (ShowSingleKey = 0) && (BeepHiddenKeys = 1) || (visualMouseClicks=1) && (MouseBeeper = 1) 
       soundbeep, 2500, 65
}

OnKeyPressed() {
    try {
        key := GetKeyStr()
        if (!(key ~= "i)^(Insert|Tab|Wheel Up|Wheel Down)$")) && (DisableTypingMode=0) {
           typed := ""
        } else if ((key ~= "i)^(Insert|Tab)$") && (DisableTypingMode=0))
        {
            TypedLetter(" ")
        }
        ShowHotkey(key)
        SetTimer, HideGUI, % -DisplayTime
    }

    if (VisualMouseClicks=1)
    {
       mkey := SubStr(A_ThisHotkey, 3)
       if InStr(mkey, "wheel")
          ShowMouseClick(mkey)
    }
}

OnLetterPressed() {
    try {
        if (typed && DeadKeys=1)
            sleep, 25    ; this delay helps with dead keys, but it generates errors; the following actions: stringleft,1 and stringlower help correct these

        key := GetKeyStr(1)     ; consider it a letter

        if prefixed || DisableTypingMode=1
        {
            typed := ""
            ShowHotkey(key)
            if (InStr(key, "shift + ") && StrLen(key)<11 && ShowSingleKey=1 && DisableTypingMode=0)
            {
                StringRight, lettera, key, 1
                TypedLetter(lettera)
            }
        } else
        {
            TypedLetter(key)
            ShowHotkey(typed)
        }
        SetTimer, HideGUI, % -DisplayTime
    }
}

OnSpacePressed() {
    try {
        if (typed && (DisableTypingMode=0))
        {
            TypedLetter("_")
            ShowHotkey(typed)
        } else if (!typed) || (DisableTypingMode=1)
        {
          key := GetKeyStr()
          ShowHotkey(key)
          if (DisableTypingMode=1)
             typed := ""
        }
        SetTimer, HideGUI, % -DisplayTime
    }
}

OnBspPressed() {
    try
    {
        if (typed && (DisableTypingMode=0))
        {
            typed := SubStr(typed, 1, StrLen(typed) - 1)
            ShowHotkey(typed)
        } else if ((!typed) || (DisableTypingMode=1))
        {
            key := GetKeyStr()
            ShowHotkey(key)
            if (DisableTypingMode=1)
               typed := ""
        }
        SetTimer, HideGUI, % -DisplayTime
    }

    if (BeepHiddenKeys = 1) && (KeyBeeper = 1) && (ShowSingleKey = 0)
       soundbeep, 1900, 45

    if (KeyBeeper = 1) && (ShowSingleKey = 1)
       soundbeep, 1900, 45
}

OnCapsPressed() {
    try
    {
        if typed && (DisableTypingMode=0)
        {
            ShowHotkey(typed)
        } else if (!typed) || (DisableTypingMode=1)
        {
            key := GetKeyStr()
            GetKeyState, CapsState, CapsLock, T
            if CapsState = D
            {
                key := prefixed ? key : "CAPS LOCK ON"
            } else
                key := prefixed ? key : "Caps Lock off"
            ShowHotkey(key)
            if (DisableTypingMode=1)
               typed := ""
        }
        SetTimer, HideGUI, % -DisplayTime
    }

    If (CapslockBeeper = 1) && (ShowSingleKey = 1) || (BeepHiddenKeys = 1)
       {
        soundbeep, 450, 200
       }
}

OnNumpadPressed()
{
    GetKeyState, NumState, NumLock, T

    if (shiftPressed=1 && NumState="D")
       NumLockForced := 1

    try {
        key := GetKeyStr()
        if NumState != D
        {
            typed := "" ; reset typed content
            if (shiftPressed=1 && !InStr(key, "Shift") && StickyKeys=1)
            {
                ShowHotkey("Shift + " key)
            } else
            {
                ShowHotkey(key)
            }
            NumLockForced := 0
        } else if prefixed || (NumLockForced=1) || (DisableTypingMode=1)
        {
            typed := ""
            sleep, 30           ; stupid hack
            if (shiftPressed=1 && !InStr(key, "Shift") && StickyKeys=1)
            {
                ShowHotkey("Shift + " key)
            } else
            {
                ShowHotkey(key)
            }
                if (NumLockForced=1)
                   NumLockForced := 0
        } else if NumState = D
        {
            key2 := GetKeyStr(1)
            sleep, 30           ; stupid hack
            if (StrLen(key2)=5)
            {
              StringLeft, key2, key2, 3
              StringRight, key2, key2, 1
            }
            TypedLetter(key2)
            ShowHotkey(typed)
        }
        SetTimer, HideGUI, % -DisplayTime
    }
}

OnKeyUp() {
    global tickcount_start := A_TickCount
    shiftPressed := 0

    if typed && (CapslockBeeper = 1) && (ShowSingleKey = 1)
    {
        GetKeyState, CapsState, CapsLock, T
        If CapsState = D
           {
             soundbeep, 450, 25
           }
           else if (KeyBeeper = 1) && (ShowSingleKey = 1)
           {
             soundbeep, 1900, 45
           }
    }

    If (CapslockBeeper = 0) && (KeyBeeper = 1) && (ShowSingleKey = 1)
       {
         soundbeep, 1900, 45
       }
       else if (CapslockBeeper = 1) && (KeyBeeper = 0)
       {
       }
       else if !typed && (CapslockBeeper = 1) && (ShowSingleKey = 1)
       {
         soundbeep, 1900, 45
       }

    if (BeepHiddenKeys = 1) && (KeyBeeper = 1) && (ShowSingleKey = 0)
         soundbeep, 1900, 45  
}

OnModPressed() {
    static modifierz := ["LCtrl", "RCtrl", "LAlt", "RAlt", "LShift", "RShift", "LWin", "RWin"]
    static repeatCount := 1

    for i, mod in modifierz
    {
        if GetKeyState(mod)
           fl_prefix .= mod " + "
    }

    if GetKeyState("Shift")
    {
        shiftPressed := 1
    }

    if StickyKeys=0
       fl_prefix := RTrim(fl_prefix, "+ ")

    fl_prefix := CompactModifiers(fl_prefix)
    
    if InStr(fl_prefix, modifiers_temp)
    {
        valid_count := 1
        keyCount := a
    } else
    {
        valid_count := 0
        modifiers_temp := fl_prefix
        if StickyKeys=0
           keyCount := a
    }

    if (ShowKeyCount=1) && (StickyKeys=0) {
        if !InStr(fl_prefix, "+") {
            if (valid_count=1) {
                if (++repeatCount > 1) {
                    modifiers_temp := fl_prefix
                    fl_prefix .= " (" repeatCount ")"
                }
            } else {
                repeatCount := 1
            }
        } else {
            repeatCount := 1
        }
   }

   if (ShowSingleKey = 0) || ((A_TickCount-tickcount_start > 2000) && visible && StickyKeys=1)
   {
      sleep, 0
   } else
   {
      ShowHotkey(fl_prefix)
      SetTimer, HideGUI, % -DisplayTime/2
   }
}

OnModUp() {
    global tickcount_start := A_TickCount

    If (ModBeeper = 1) && (ShowSingleKey = 1) && (ShowSingleModifierKey = 1) || (ModBeeper = 1) && (BeepHiddenKeys = 1)
       soundbeep, 1000, 65

}

CreateGUI() {
    global

    Gui, +AlwaysOnTop -Caption +Owner +LastFound +ToolWindow +E0x20
    Gui, Margin, 10, 10
    Gui, Color, 111111
    Gui, Font, cWhite s%FontSize% bold, Arial, -wrap
    Gui, Add, Text, vHotkeyText left x10 y10 -wrap
}

CreateHotkey() {

    if (CustomRegionalKeys=1) && (AutoDetectKBD=0)
    {
        Loop, parse, RegionalKeysList, |
        {
           Hotkey, % "~*" A_LoopField, OnLetterPressed, useErrorLevel
           Hotkey, % "~*" A_LoopField " Up", OnKeyUp, useErrorLevel
           if (errorlevel!=0) && (audioAlerts=1)
              soundbeep, 1900, 50
        }
    }
   if (AutoDetectKBD=1)
   {
       IdentifyKBDlayout()
   }

    Loop, 95
    {
        k := Chr(A_Index + 31)

        if (DeadKeys=1)
        {
            for each, char2skip in StrSplit("``,^,6,',"",~", ",")        ; dead keys to ignore
            {
                if (k = char2skip && DeadKeys=1)
                {
                    continue, 2
                }
            }
        }

        if (k = " ")
        {
            Hotkey, % "~*Space", OnSpacePressed, useErrorLevel
            Hotkey, % "~*Space Up", OnKeyUp, useErrorLevel
        }
        else
        {
            Hotkey, % "~*" k, OnLetterPressed, useErrorLevel
            Hotkey, % "~*" k " Up", OnKeyUp, useErrorLevel
            if (errorlevel!=0) && (audioAlerts=1)
               soundbeep, 1900, 50
        }
    }

    Hotkey, % "~*Backspace", OnBspPressed, useErrorLevel
    Hotkey, % "~*CapsLock", OnCapsPressed, useErrorLevel
    Hotkey, % "~*CapsLock Up", OnKeyUp, useErrorLevel

    Loop, 24 ; F1-F24
    {
        Hotkey, % "~*F" A_Index, OnKeyPressed, useErrorLevel
        Hotkey, % "~*F" A_Index " Up", OnKeyUp, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }

    NumpadKeysList := "NumpadDot|NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|sc04E|sc04A|sc052|sc04F|sc050|sc051|sc04B|sc04C|sc04D|sc047|sc048|sc049|sc053|sc037|sc135"

    Loop, parse, NumpadKeysList, |
    {
       Hotkey, % "~*" A_LoopField, OnNumpadPressed, useErrorLevel
       Hotkey, % "~*" A_LoopField " Up", OnKeyUp, useErrorLevel
       if (errorlevel!=0) && (audioAlerts=1)
          soundbeep, 1900, 50
    }

    Otherkeys := "WheelDown|WheelUp|WheelLeft|WheelRight|XButton1|XButton2|Browser_Forward|Browser_Back|Browser_Refresh|Browser_Stop|Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Help|Sleep|PrintScreen|CtrlBreak|Break|AppsKey|Tab|Enter|Esc"
               . "|Insert|Home|End|Up|Down|Left|Right|ScrollLock|NumLock|Pause|sc145|sc146|sc046|sc123|sc11C|sc149|sc151|sc122|sc153"
    Loop, parse, Otherkeys, |
    {
        Hotkey, % "~*" A_LoopField, OnKeyPressed, useErrorLevel
        Hotkey, % "~*" A_LoopField " Up", OnKeyUp, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }

    if (ShowMouseButton=1) || (visualMouseClicks=1)
    {
        Loop, Parse, % "LButton|MButton|RButton", |
        Hotkey, % "~*" A_LoopField, OnMousePressed, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }

    for i, mod in ["LCtrl", "RCtrl", "LAlt", "RAlt", "LWin", "RWin"]
    {
        Hotkey, % "~*" mod, OnKeyPressed, useErrorLevel
        Hotkey, % "~*" mod " Up", OnModUp, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }

    If typed {
    for i, mod in ["LShift", "RShift"]
        Hotkey, % "~*" mod, OnKeyPressed, useErrorLevel
        Hotkey, % "~*" mod " Up", OnModUp, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }

    If (ShowSingleModifierKey=1) && (StickyKeys=0)
    {
      for i, mod in ["LShift", "RShift", "LCtrl", "RCtrl", "LAlt", "RAlt", "LWin", "RWin"]
        Hotkey, % "~*" mod, OnModPressed, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }

    If (ShowSingleModifierKey=1) && (StickyKeys=1)
    {
      for i, mod in ["LShift", "RShift"]
        Hotkey, % "~*" mod, OnModPressed, useErrorLevel
        if (errorlevel!=0) && (audioAlerts=1)
           soundbeep, 1900, 50
    }
}

ShowHotkey(HotkeyStr) {

    if (OSDautosize=1)
    {
        HotkeyTextTrimmed := RegExReplace(HotkeyStr, "[^a-zA-Z]", "")
        StringLeft, HotkeyTextTrimmed, HotkeyTextTrimmed, 5
        growthFactor := 1.25
        if HotkeyTextTrimmed is upper
           growthFactor := 1.0
        text_width := (StrLen(HotkeyStr)/growthFactor)*FontSize
        text_width := (text_width<70) ? 70 : text_width+15
    } else if OSDautosize=0
    {
        text_width := GuiWidth
    }

    GuiControl,     , HotkeyText, %HotkeyStr%
    GuiControl, Move, HotkeyText, w%text_width% left
    Gui, Show, NoActivate x%GuiX% y%GuiY% AutoSize, KeypressOSD
    visible := 1
    WinSet, AlwaysOnTop, On, KeypressOSD
    SetTimer, checkMousePresence, on, 400
}

GetKeyStr(letter := 0) {
    modifiers_temp := 0
    static modifiers := ["LCtrl", "RCtrl", "LAlt", "RAlt", "LShift", "RShift", "LWin", "RWin"]
    static clickers := ["LButton", "RButton", "MButton", "WheelUp", "WheelDown"]

    ; If any mod but shift, go ; If shift, check if not letter

    for i, mod in modifiers
    {
        if (mod = "LShift" && typed || mod = "RShift" && typed ? (!letter && GetKeyState(mod)) : GetKeyState(mod))
    ;    if GetKeyState(mod)
            prefix .= mod " + "
    }

    if (!prefix && !ShowSingleKey)
        throw

    key := SubStr(A_ThisHotkey, 3)

    if (key ~= "i)^(LCtrl|RCtrl|LShift|RShift|LAlt|RAlt|LWin|RWin)$") {
        if (ShowSingleModifierKey = 0) || (ShowSingleKey = 0) || (A_TickCount-tickcount_start > 2000) && visible
        {
            throw
        } else
        {
;           prefix := RTrim(prefix, "+ ")
;           keyCount := a
            key := ""
            if StickyKeys=0
               throw
        }

    prefix := CompactModifiers(prefix)

    } else
    {
        if StrLen(key)=1 || InStr(key, " up") && StrLen(key)=4 && typed
        {
            StringLeft, key, key, 1
            key := GetKeyChar(key, "A")
        } else if ( SubStr(key, 1, 2) = "sc" ) {
            key := SpecialSC(key)
        } else if (key = "Volume_Up") || (key = "Volume_Down") {
            soundbeep, 150, 40
        } else if (key = "PrintScreen") {
            if (HideAnnoyingKeys=1 && !prefix)
                throw
            key := "Print Screen"
        } else if (key = "WheelUp") {
            if (ShowMouseButton=0)
               throw
            key := "Wheel Up"
        } else if (key = "WheelDown") {
            if (ShowMouseButton=0)
               throw
            key := "Wheel Down"
        } else if (key = "MButton") {
            key := "Middle Click"
        } else if (key = "RButton") {
            key := "Right Click"
        } else if (key = "LButton") && IsDoubleClick() {
            key := "Double Click"
        } else if (key = "LButton") {
            if (HideAnnoyingKeys=1 && !prefix)
            {
                if !(substr(typed, 0)=" ") && typed && (ShowMouseButton=1) {
                    TypedLetter(" ")
                }
                throw
            }
            key := "Left Click"
        }
        {
            _key := (key = "Double-Click") ? "Left Click" : key
        }

        prefix := CompactModifiers(prefix)

        static pre_prefix, pre_key
        StringUpper, key, key, T
        StringUpper, pre_key, pre_key, T
        keyCount := (key=pre_key) && (prefix = pre_prefix) && (repeatCount<1.5) ? keyCount : 1
        global ShowKeyCountDelay := (ShowKeyCountFired = 0) ? 700 : 6000
        ShowKeyCountDelay := (ShowKeyCountFired=1) ? (ShowKeyCountDelay+keyCount*100) : ShowKeyCountDelay

        if (InStr(prefix, "+")) && (A_TickCount-tickcount_start < ShowKeyCountDelay) || (!letter) && (A_TickCount-tickcount_start < ShowKeyCountDelay)
        {
            if (ShowPrevKey=1) && (A_TickCount-tickcount_start < ShowPrevKeyDelay)
            {
                ShowPrevKeyValid := 1
                if InStr(pre_key, " up")  && StrLen(pre_key)=4
                {
                    StringLeft, pre_key, pre_key, 1
                }
            } else
            {
                ShowPrevKeyValid := 0
            }
            if (prefix != pre_prefix) {
                result := (ShowPrevKeyValid=1) ? prefix key " {" pre_prefix pre_key "}" : prefix key
            } else if (ShowPrevKeyValid=1) && (key != pre_key) || (ShowKeyCount=1) && (ShowPrevKeyValid=1)
            {
                keyCount := (key=pre_key) && (ShowKeyCount=1) ? (keyCount+1) : 1
                key := (keyCount>1) && (ShowKeyCount=1) ? (key " (" keyCount ")") : (key ", " pre_key)
            } else if (ShowPrevKeyValid=0)
            {
                keyCount := (key=pre_key) && (ShowKeyCount=1) ? (keyCount+1) : 1
                key := (keyCount>1) ? (key " (" keyCount ")") : (key)
            }
        } else {
            keyCount := 1
        }
        pre_prefix := prefix
        pre_key := _key
    }

    prefixed := prefix ? 1 : 0
    return result ? result : prefix . key
}

GetShiftedSymbol(symbol)
{
    symbolPairs_1 := {1:"!", 2:"@", 3:"#", 4:"$", 5:"%", 6:"^", 7:"&", 8:"*", 9:"(", 0:")", "-":"_", "=":"+", "[":"{", "]":"}", "\":"|", ";":":", "'":"""", ",":"<", ".":">", "/":"?", "``":"~"}

    if AutoDetectKBD=0
       kbLayoutSymbols := symbolPairs_1   ; this the default, English US

    if kbLayoutSymbols.hasKey(symbol) {
       symbol := kbLayoutSymbols[symbol]
    }

    return symbol
}

CompactModifiers(stringy)
{
    if DifferModifiers = 1
    {
        StringReplace, stringy, stringy, LCtrl + RAlt, AltGr, All
        StringReplace, stringy, stringy, LCtrl + RCtrl + RAlt, RCtrl + AltGr, All
        StringReplace, stringy, stringy, RAlt, AltGr, All
        StringReplace, stringy, stringy, LAlt, Alt, All
    } else if (DifferModifiers = 0)
    {
        StringReplace, stringy, stringy, LCtrl + RAlt, AltGr, All
        ; StringReplace, stringy, stringy, LCtrl + RCtrl + RAlt, RCtrl + AltGr, All
        StringReplace, stringy, stringy, LCtrl, Ctrl, All
        StringReplace, stringy, stringy, RCtrl, Ctrl, All
        StringReplace, stringy, stringy, LShift, Shift, All
        StringReplace, stringy, stringy, RShift, Shift, All
        StringReplace, stringy, stringy, LAlt, Alt, All
        StringReplace, stringy, stringy, LWin, WinKey, All
        StringReplace, stringy, stringy, RWin, WinKey, All
        StringReplace, stringy, stringy, Ctrl + Ctrl, Ctrl, All
        StringReplace, stringy, stringy, Shift + Shift, Shift, All
        StringReplace, stringy, stringy, WinKey + WinKey, WinKey, All
        StringReplace, stringy, stringy, RAlt, AltGr, All
    }
    return stringy
}

SpecialSC(sc) {
    GetSpecialKeysStates()

    GetKeyState, NumState, NumLock, T

    If (NumState="D" || NumLockForced=1)
    {
       k := {sc046: zcSCROL, sc145: "NUM LOCK ON", sc146: "Pause", sc123: "Genius LuxeMate Scroll", sc04E: "[ + ]", sc04A: "[ - ]", sc052: "[ 0 ]", sc04F: "[ 1 ]", sc050: "[ 2 ]", sc051: "[ 3 ]", sc04B: "[ 4 ]", sc04C: "[ 5 ]", sc04D: "[ 6 ]", sc047: "[ 7 ]", sc048: "[ 8 ]", sc049: "[ 9 ]", sc053: "[ . ]", sc037: "[ * ]", sc135: "[ / ]", sc11C: "[Enter]", sc149: "Page Up", sc151: "Page Down", sc153: "Delete", sc122: "Media_Play/Pause"}
    }
    else {
       k := {sc046: zcSCROL, sc145: "Num lock off", sc146: "Pause", sc123: "Genius LuxeMate Scroll", sc04E: "[ + ]", sc04A: "[ - ]", sc052: "[Insert]", sc04F: "[End]", sc050: "[Down]", sc051: "[Page Down]", sc04B: "[Left]", sc04C: "[Undefined]", sc04D: "[Right]", sc047: "[Home]", sc048: "[Up]", sc049: "[Page Up]", sc053: "[Delete]", sc037: "[ * ]", sc135: "[ / ]", sc11C: "[Enter]", sc149: "Page Up", sc151: "Page Down", sc153: "Delete", sc122: "Media_Play/Pause"}
    }
    return k[sc]
}

; <tmplinshi>: thanks to Lexikos: https://autohotkey.com/board/topic/110808-getkeyname-for-other-languages/#entry682236
; This enables partial support for non-English keyboard layouts.
; If the script initializes with the English keyboard layout, but then used with another one, this function gets proper key names,

GetKeyChar(Key, WinTitle:=0)
{
    thread := WinTitle=0 ? 0
        : DllCall("GetWindowThreadProcessId", "ptr", WinExist(WinTitle), "ptr", 0)
    hkl := DllCall("GetKeyboardLayout", "uint", thread, "ptr")
    vk := GetKeyVK(Key), sc := GetKeySC(Key)
    VarSetCapacity(state, 256, 0)
    VarSetCapacity(char, 4, 0)
    n := DllCall("ToUnicodeEx", "uint", vk, "uint", sc
        , "ptr", &state, "ptr", &char, "int", 2, "uint", 0, "ptr", hkl)
    return StrGet(&char, n, "utf-16")
}
global LangsBinded := 0

IdentifyKBDlayout() {
  VarSetCapacity(kbLayoutRaw, 32, 0)
  DllCall("GetKeyboardLayoutName", "Str", kbLayoutRaw)
  StringRight, kbLayout, kbLayoutRaw, 4

  #Include *i keypress-osd-languages.ini

  if (!FileExist("keypress-osd-languages.ini") && (AutoDetectKBD=1)) || (FileExist("keypress-osd-languages.ini") && (AutoDetectKBD=1) && (loadedLangz!=1))
  {
      soundbeep
      UrlDownloadToFile, http://marius.sucan.ro/media/files/blog/ahk-scripts/keypress-osd-languages.ini, keypress-osd-languages.ini
      ShowHotkey("Please wait. Downloading languages file.")
      langFileDownloading := 1
      IniWrite, %langFileDownloading%, IniFile, PermanentSettings, langFileDownloading
      Sleep, 5000
  }

  IniRead, langFileDownloading, IniFile, PermanentSettings, langFileDownloading
  IniRead, ReloadCounter, IniFile, PermanentSettings, ReloadCounter

  if ((loadedLangz!=1) && (AutoDetectKBD=1))
  {
     if (FileExist("keypress-osd-languages.ini") && (ReloadCounter>1))
     {
         ReloadCounter := 0
         IniWrite, %ReloadCounter%, IniFile, PermanentSettings, ReloadCounter
         MsgBox, Corrupt or old file: keypress-osd-languages.ini. The attempt to download it seems to have failed. See script file for a link to download it. Support for non-English keyboards is unavailable.
         ReloadError := 1
     } else if (FileExist("keypress-osd-languages.ini") && (langFileDownloading=1) && (ReloadError!=1))
     {
         langFileDownloading := 0
         ReloadCounter := ReloadCounter+1
         IniWrite, %langFileDownloading%, IniFile, PermanentSettings, langFileDownloading
         IniWrite, %ReloadCounter%, IniFile, PermanentSettings, ReloadCounter
         Sleep, 500
         Reload
     } else
     {
        MsgBox, Missing or corrupt file: keypress-osd-languages.ini. The attempt to download it seems to have failed. See script file for a link to download it. Support for non-English keyboards is now deactivated.
     }
  }
  
  if (loadedLangz=1)
  {
      ReloadCounter := 0
      IniWrite, %ReloadCounter%, IniFile, PermanentSettings, ReloadCounter
  }

  check_kbd := StrLen(LangName_%kbLayout%)>2 ? 1 : 0
  check_kbd_exact := StrLen(LangRaw_%kbLayoutRaw%)>2 ? 1 : 0
  if (check_kbd_exact=0)
  {
      partialKBDmatch = (Partial match)
  }

  if (check_kbd=0)
  {
      ShowHotkey("Unrecognized layout: (kbd " kbLayoutRaw ").")
      SetTimer, HideGUI, % -DisplayTime
      soundbeep, 500, 900
  }

  StringLeft, kbLayoutSupport, LangName_%kbLayout%, 1
  if (kbLayoutSupport="-") && (check_kbd=1)
  {
      ShowHotkey("Unsupported layout: " LangName_%kbLayout% " (kbd" kbLayout ").")
      SetTimer, HideGUI, % -DisplayTime
      soundbeep, 500, 900
  }

  IfInString, LangsBinded, %kbLayout%
  {
      KBDbinded := 1
  } else
  {
      LangsBinded := kbLayout "|" LangsBinded 
      StringLeft, LangsBinded, LangsBinded, 20
      KBDbinded := 0
  }

  if (kbLayoutSupport!="-") && (check_kbd=1) && (KBDbinded=0)
  {
      Loop, parse, LangChars_%kbLayout%, |
      {
         Hotkey, % "~*" A_LoopField, OnLetterPressed, useErrorLevel
         Hotkey, % "~*" A_LoopField " Up", OnKeyUp, useErrorLevel
         if (errorlevel!=0) && (audioAlerts=1)
             soundbeep, 1900, 50
      }
      if SilentDetection=0
      {
          ShowHotkey("Keyboard layout: " LangName_%kbLayout% " (kbd" kbLayout "). " partialKBDmatch)
          SetTimer, HideGUI, % -DisplayTime/3
      }
  }

    if (!symbolPairs_%kbLayoutRaw%)
    {
        RawNotMatch := 1
    } else
    {
        kbLayoutSymbols := symbolPairs_%kbLayoutRaw%
    }

    if (!symbolPairs_%kbLayout% && RawNotMatch=1)
    {
       kbLayoutSymbols := 0           ; undefined layout
    } else if (RawNotMatch=1)
    {
       kbLayoutSymbols := symbolPairs_%kbLayout%
    }

   if (ConstantAutoDetect=1) && (AutoDetectKBD=1) && (loadedLangz != 1)
      SetTimer, ConstantKBDchecker, 1500
}

ConstantKBDchecker() {
  SetFormat, Integer, H
  WinGet, WinID,, A
  ThreadID := DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
  NewInputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    if (InputLocaleID != NewInputLocaleID)
    {
        InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
        
        if SilentDetection=0
        ShowHotkey("Changed keyboard layout: " InputLocaleID)
      
        sleep, 350
        Reload
    }
}

IsDoubleClick(MSec = 300) {
    Return (A_ThisHotKey = A_PriorHotKey) && (A_TimeSincePriorHotkey < MSec)
}

IsDoubleClickEx(MSec = 300) {
    preHotkey := RegExReplace(A_PriorHotkey, "i) Up$")
    Return (A_ThisHotKey = preHotkey) && (A_TimeSincePriorHotkey < MSec)
}

HideGUI() {
    visible := 0
    Gui, Hide
    SetTimer, checkMousePresence, off, 300
}

checkMousePresence() {
    id := mouseIsOver()
    title := getWinTitleFromID(id)
    if title = KeypressOSD
       HideGUI()
}

mouseIsOver() {
    MouseGetPos,,, id
    return id
}

getWinTitleFromID(id) {
    WinGetTitle, title, % "ahk_id " id
    return title
}

+Pause::         ; Shift+Pause/Break
   Suspend, Permit
   Gui, Destroy
   sleep, 100
   CreateGUI()
   sleep, 100
   ShowHotkey("KeyPress OSD toggled")
   SetTimer, HideGUI, % -DisplayTime/6
   Sleep, DisplayTime/6+15
   Suspend
return

CreateGlobalShortcuts() {
   if (KeyboardShortcuts=1) {
      Hotkey, !+^F8, ToggleShowSingleKey
      Hotkey, !+^F9, TogglePosition
      Hotkey, !+^F10, EnableCustomKeys
      Hotkey, !+^F11, DetectLangNow
      Hotkey, !+^F12, ReloadScript
      Hotkey, !Pause, ToggleCapture2Text   ; Alt+Pause/Break
    }
}

ToggleShowSingleKey:
    ShowSingleKey := (!ShowSingleKey) ? true : false
    Gui, Destroy
    sleep, 100
    CreateGUI()
    sleep, 100
    IniWrite, %ShowSingleKey%, IniFile, PermanentSettings, ShowSingleKey
    ShowHotkey("Show single keys = " ShowSingleKey)
    SetTimer, HideGUI, % -DisplayTime
return

TogglePosition:
    GuiY := (GuiY = GuiYb) ? GuiYa : GuiYb
    Gui, Destroy
    sleep, 100
    CreateGUI()
    sleep, 100
    IniWrite, %GuiY%, IniFile, PermanentSettings, GuiY
    ShowHotkey("OSD position changed")
    SetTimer, HideGUI, % -DisplayTime
return

EnableCustomKeys:
    global CustomRegionalKeys := CustomRegionalKeys = 1 ? 0 : 1
    CustomMultiLangToggled := 1
    IniWrite, %CustomMultiLangToggled%, IniFile, PermanentSettings, CustomMultiLangToggled
    IniWrite, %CustomRegionalKeys%, IniFile, PermanentSettings, CustomRegionalKeys
    ShowHotkey("Custom Regional keys = " RegionalKeys)
    sleep, 1000
    Reload
return

DetectLangNow:
    global AutoDetectKBD := 1
    global ConstantAutoDetect := 0
    AutoDetectKBDToggled := 1
    IniWrite, %AutoDetectKBDToggled%, IniFile, PermanentSettings, AutoDetectKBDToggled
    IniWrite, %AutoDetectKBD%, IniFile, PermanentSettings, AutoDetectKBD
    IniWrite, %ConstantAutoDetect%, IniFile, PermanentSettings, ConstantAutoDetect
    ShowHotkey("Detecting keyboard layout...")
    sleep, 800
    Reload
return

ReloadScript:
    Gui, Destroy
    sleep, 100
    CreateGUI()
    sleep, 100
    ShowHotkey("OSD reinitializing...")
    sleep, 1500
    Reload
return

ToggleCapture2Text:        ; Alt+Pause/Break
    Capture2Text := (Capture2Text=1) ? 0 : 1
    if (Capture2Text=1)
    {
        SetTimer, capturetext, 2000
        ShowHotkey("Enabled automatic Capture2Text")
    } else
    {
        SetTimer, capturetext, off
        ShowHotkey("Disabled automatic Capture2Text")
    }
Return

capturetext()
{
    if ((A_TimeIdle < 1900) && !A_IsSuspended)
       Send, {Pause}             ; set here the keyboard shortcut configured in Capture2Text
}

ClipChanged(Type)
{
    sleep, 300
    if (type=1 && !A_IsSuspended)
    {
       troll := clipboard
       Stringleft, troll, troll, NumLetters*1.5
       StringReplace, troll, troll, `r`n, %A_SPACE%, All
       StringReplace, troll, troll, %A_TAB%, %A_SPACE%, All
       StringReplace, troll, troll, %A_SPACE%%A_SPACE%, , All
       ShowHotkey(troll)
       SetTimer, HideGUI, % -DisplayTime*1.5
    } else if (type=2 && !A_IsSuspended)
    {
       ShowHotkey("Clipboard data changed")
       SetTimer, HideGUI, % -DisplayTime/7
    }
}

CreateMouseGUI() {
    global

    Gui Mouser: +AlwaysOnTop -Caption +ToolWindow +E0x20
    Gui Mouser: Margin, 0, 0
}

ShowMouseClick(clicky)
{
    ; SetTimer, HideMouseClickGUI, % -DisplayTime/4
    SetTimer, HideMouseClickGUI, 900
    SetTimer, ShowMouseIdleLocation, off
    Gui Mouser: Destroy
    MouseClickCounter := (MouseClickCounter > 10) ? 1 : 11
    TransparencyLevel := 150 - MouseClickCounter*4
    BoxW := 16 + MouseClickCounter/3
    BoxH := 40
    MouseDistance := 15
    MouseGetPos, mX, mY
    mY := mY - BoxH
    if InStr(clicky, "LButton")
    {
       mX := mX - BoxW*2 - MouseDistance
    } else if InStr(clicky, "MButton")
    {
       BoxW := 45 + MouseClickCounter
       mX := mX - BoxW
    } else if InStr(clicky, "RButton")
    {
       mX := mX + MouseDistance
    } else if InStr(clicky, "Wheelup")
    {
       BoxW := 50 + MouseClickCounter
       BoxH := 15
       mX := mX - BoxW
       mY := mY + MouseDistance - 10
    } else if InStr(clicky, "Wheeldown")
    {
       BoxW := 50 + MouseClickCounter
       BoxH := 15
       mX := mX - BoxW
       mY := mY + BoxH*2 + MouseDistance + 10
    }

    InnerColor := "555555"
    OuterColor := "aaaaaa"
    BorderSize := 4
    RectW := BoxW - BorderSize*2
    RectH := BoxH - BorderSize*2

    CreateMouseGUI()

    Gui Mouser: Color, %OuterColor%  ; outer rectangle
    Gui Mouser: Add, Progress, x%BorderSize% y%BorderSize% w%RectW% h%RectH% Background%InnerColor% c%InnerColor%, 100   ; inner rectangle
    Gui Mouser: Show, NoActivate x%mX% y%mY% w%BoxW% h%BoxH%, MousarWin
    WinSet, Transparent, %TransparencyLevel%, MousarWin
    Sleep, 200
    WinSet, AlwaysOnTop, On, MousarWin
}

HideMouseClickGUI()
{
    Loop, {
       MouseDown := 0
       if GetKeyState("LButton","P")
          MouseDown := 1
       if GetKeyState("RButton","P")
          MouseDown := 1
       if GetKeyState("MButton","P")
          MouseDown := 1

       If (MouseDown=0)
       {
          Sleep, 250
          Gui Mouser: Hide
          MouseClickCounter := 20
          SetTimer, HideMouseClickGUI, off
          if (FlashIdleMouse=1)
             SetTimer, ShowMouseIdleLocation, on
          Break
       } else
       {
          WinSet, Transparent, 55, MousarWin
       }
    }
}

ShowMouseIdleLocation()
{
    If (A_TimeIdle > 9900) && !A_IsSuspended
    {
       Gui Mouser: Destroy
       Sleep, 300
       MouseGetPos, mX, mY
       BoxW := 40
       BoxH := 40
       mX := mX - BoxW
       mY := mY - BoxH
       BorderSize := 4
       RectW := BoxW - BorderSize*2
       RectH := BoxH - BorderSize*2
       InnerColor := "555555"
       OuterColor := "aaaaaa"
       CreateMouseGUI()
       Gui Mouser: Color, %OuterColor%  ; outer rectangle
       Gui Mouser: Add, Progress, x%BorderSize% y%BorderSize% w%RectW% h%RectH% Background%InnerColor% c%InnerColor%, 100   ; inner rectangle
       Gui Mouser: Show, NoActivate x%mX% y%mY% w%BoxW% h%BoxH%, MousarWin
       WinSet, Transparent, 170, MousarWin
       WinSet, AlwaysOnTop, On, MousarWin
    } Else
    {
        Gui Mouser: Hide
    }
}

; +SPACE::  Winset, Alwaysontop, , A
