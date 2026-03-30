# BasicC2

Technical reference for developers who want to understand, modify, or rebuild the project

### Window Layout

```
+------------------------------------------+
| BasicC2 - CodedByABOLHB          [_][X]  |
+------------------------------------------+
| IP    | Host   | OS    | User   | UAC    |  <- ListView (hLV)
|       |        |       |        |        |
|       |        |       |        |        |
+------------------------------------------+
| [Builder] [About]                        |  <- Button bar (BTN_BAR_H=28)
+------------------------------------------+
| Listening :4444 | 505 client(s)          |  <- StatusBar (hSB)
+------------------------------------------+
```
---

## Source Files

| File | Lines | Purpose |
|------|-------|---------|
| `BasicC2.asm` | ~1934 | Server - UI, networking, builder, monitor, shell |
| `BasicC2.inc` | ~440 | Constants, structures, Win32 API prototypes |
| `BasicC2.rc` | ~52 | Resource script - dialogs, icon, embedded stub |
| `Stub.asm` | ~993 | Client stub - connect, commands, capture, persist |
| `Stub.rc` | 1 | Client resource (manifest reference) |
| `Stub.manifest` | 11 | Client manifest (asInvoker) |
| `MasonIcon.ico` | - | Application icon |

## Build Requirements

- MASM32 SDK at `C:\masm32`
- Windows x86/x64

## Build Commands

```batch
cd C:\path\to\source

C:\masm32\bin\rc /i C:\masm32\include BasicC2.rc
C:\masm32\bin\cvtres /machine:x86 BasicC2.res
C:\masm32\bin\ml /c /coff /Cp /nologo BasicC2.asm
C:\masm32\bin\link /SUBSYSTEM:WINDOWS /LIBPATH:C:\masm32\lib BasicC2.obj BasicC2.res kernel32.lib user32.lib gdi32.lib comctl32.lib ws2_32.lib comdlg32.lib shell32.lib msvcrt.lib
del BasicC2.obj
```

| Step | Tool | What it does |
|------|------|-------------|
| 1 | `rc` | Compiles .rc into .res (dialogs, icon, embedded Stub files as RCDATA) |
| 2 | `cvtres` | Converts .res to COFF object for linker |
| 3 | `ml` | Assembles .asm to .obj (x86 machine code) |
| 4 | `link` | Links .obj + .res + Win32 libs into BasicC2.exe |

## Libraries

| Library | Used by | Functions |
|---------|---------|-----------|
| kernel32 | Both | CreateThread, CreateFile, ReadFile, WriteFile, VirtualAlloc, CreateProcess, Sleep, GetModuleFileName |
| user32 | Server | CreateWindowEx, SendMessage, MessageBox, DialogBoxParam, SetTimer, GetCursorPos, TrackPopupMenu |
| gdi32 | Both | GetDC, BitBlt, StretchBlt, GetDIBits, StretchDIBits, CreateCompatibleDC/Bitmap |
| comctl32 | Server | InitCommonControlsEx (ListView, StatusBar) |
| ws2_32 | Both | WSAStartup, socket, bind, listen, accept, connect, send, recv, select, setsockopt |
| comdlg32 | Server | GetOpenFileName (file browser for Run File) |
| shell32 | Both | ShellExecuteA (client Run File), IsUserAnAdmin (client UAC check) |
| advapi32 | Client | RegOpenKeyEx, RegSetValueEx, GetUserName |
| msvcrt | Both | wsprintfA (string formatting) |

## Server Architecture (BasicC2.asm)

### Entry Point and Init

```
start -> GetModuleHandle -> InitCommonControlsEx -> WSAStartup
      -> PortDlgProc (ask port) -> RegisterMainClass -> CreateMainWindow
      -> FireServer -> MsgPump (message loop)
```

### Procedures

| Procedure | Purpose |
|-----------|---------|
| `PortDlgProc` | Dialog callback for port selection at startup |
| `RegisterMainClass` | Registers WNDCLASSEX for main window |
| `CreateMainWindow` | Creates main window centered on screen, context menu |
| `CreateListView` | Creates SysListView32 with extended styles |
| `AddListViewColumns` | Adds 5 columns: IP, Host, OS, User, UAC |
| `CreateStatusBar` | Creates msctls_statusbar32 |
| `UpdateStatusBar` | Updates status text with port and client count |
| `WndProc` | Main window message handler (WM_CREATE, WM_SIZE, WM_COMMAND, WM_NOTIFY, WM_TIMER, WM_CLOSE) |
| `MsgPump` | Standard GetMessage/TranslateMessage/DispatchMessage loop |
| `FireServer` | Creates TCP socket, binds, listens, spawns AcceptLoop thread |
| `KillServer` | Closes socket, disconnects all clients |
| `AcceptLoop` | Background thread: accept() loop, sets TCP keepalive, receives greeting, calls PushClient |
| `NetRecv` | Receives length-prefixed message (4-byte header + payload) |
| `NetSend` | Sends length-prefixed text message |
| `NetSendRaw` | Sends length-prefixed binary data with chunked send (32KB chunks) |
| `PushClient` | Registers new client: dedup by IP, zero struct, copy IP, parse greeting, add to ListView |
| `GrabDeviceID` | Extracts device ID from greeting (text before first `\|`) |
| `GrabFields` | Parses `(OS: ...)`, `(User: ...)`, `(WinVer: ...)` from greeting string |
| `PushListView` | Inserts client data into ListView as a new row |
| `FindPoolIndex` | Maps ListView row index to pool array index |
| `RemoveClient` | Closes socket, marks inactive, updates status |
| `StaleCheck` | Timer callback: checks all sockets with getsockopt(SO_ERROR) + select() + recv(MSG_PEEK) |
| `BuilderProc` | Dialog callback for Builder (host, port, persistence checkboxes) |
| `RunBuild` | Extracts resources, generates config, compiles stub, cleans up |
| `GenStub` | Writes client_config.inc and client_host.inc |
| `WriteBuildBat` | Writes _build.bat with ml/link commands |
| `StubWrite` | Helper: writes string to file handle |
| `ExtractResource` | Extracts RCDATA resource to file |
| `StartLiveMonitor` | Creates monitor window and screenshot thread |
| `MonitorWndProc` | Monitor window: WM_PAINT uses StretchDIBits to render BMP |
| `LiveMonitorThread` | Background thread: sends mason_screenshot_fast, receives BMP, posts WM_USER_FRAME |
| `RegisterShellClass` | Registers window class for remote shell |
| `ShowShellWnd` | Creates remote shell window |
| `ShellWndProc` | Shell window: output edit + input edit + send button, handles Enter key |
| `DoRunFile` | Opens file dialog, uploads file to client, client executes it |
| `DoDisconnect` | Sends mason_kill_process, removes client |
| `NukeAllClients` | Closes all sockets, resets pool |

### Data Structures

```asm
MasonClient STRUCT          ; 646 bytes per client
    active      DWORD       ; 1=connected, 0=free slot
    sock        DWORD       ; TCP socket handle
    deviceID    BYTE[64]    ; parsed from greeting
    ip          BYTE[128]   ; IP address string
    hostname    BYTE[128]   ; hostname
    osName      BYTE[128]   ; "Windows 10", "Windows 11", etc
    userName    BYTE[128]   ; logged in user
    winVer      BYTE[128]   ; UAC status "True"/"False"
MasonClient ENDS

pool MasonClient 256 dup(<>) ; max 256 clients
```

### Network Protocol

```
Message format:  [4 bytes big-endian length][N bytes payload]

Server -> Client commands:
  "mason_screenshot_fast"  -> client sends back BMP data
  "mason_kill_process"     -> client exits
  "mason_uploadrun"        -> triggers file upload sequence
  "<any text>"             -> executed as shell command

Upload sequence:
  Server: send "mason_uploadrun"
  Client: send "READY"
  Server: send [filename length][filename]
  Server: send [file data length][file data]
  Client: saves to %TEMP%, executes, sends "OK"
```

### Connection Health Check (StaleCheck)

Runs every 2 seconds via WM_TIMER:

```
For each active client:
  1. getsockopt(SO_ERROR) -> if error, mark dead
  2. select(readfds, timeout=0) -> if SOCKET_ERROR, mark dead
  3. If select returns 0 (no activity), skip (alive)
  4. If select > 0, recv(MSG_PEEK, 1 byte):
     - returns 0 -> connection closed, mark dead
     - returns SOCKET_ERROR:
       - WSAGetLastError == 10035 (WOULDBLOCK) -> alive
       - else -> dead
  5. After loop, if any removed: rebuild ListView
```

## Client Architecture (Stub.asm)

### Entry Point

```
start -> WSAStartup -> GatherInfo -> Persist (if enabled)
      -> VirtualAlloc (capture buffer)
      -> Main loop: socket -> DoConnect -> DoGreeting -> DoCmdLoop
      -> On disconnect: closesocket -> Sleep(3000) -> retry
```

### Procedures

| Procedure | Purpose |
|-----------|---------|
| `GatherInfo` | gethostname, GetUserName, RtlGetVersion (OS), IsUserAnAdmin (UAC), GetModuleFileName |
| `ResolveHost` | inet_addr first, falls back to gethostbyname for DNS |
| `DoConnect` | Creates sockaddr_in, resolves host, connect() |
| `DoGreeting` | Sends `ID_<host> \| from <host> (OS: <os>) (User: <user>) (WinVer: <uac>) \| .` |
| `DoCmdLoop` | Receives commands in loop, dispatches to handlers |
| `CaptureScreen` | GetDC(NULL) -> StretchBlt to 800x450 -> GetDIBits -> NetSendRaw (BMP header + pixels) |
| `StartShell` | Creates cmd.exe with stdin/stdout pipes (persistent shell) |
| `ShellExecCmd` | Writes command to stdin pipe, reads output from stdout pipe with PeekNamedPipe |
| `HandleUploadRun` | Receives filename + file data, saves to %TEMP%, ShellExecuteA |
| `SendText` | lstrlenA + NetSendRaw |
| `NetSendRaw` | 4-byte header + chunked send (32KB) |
| `NetRecvRaw` | Chunked recv (32KB) |
| `PersistSchtask` | Copies to %APPDATA%, creates schtasks /sc minute /mo 1 |
| `PersistRegistry` | HKCU\Software\Microsoft\Windows\CurrentVersion\Run |

### OS Detection

Uses `RtlGetVersion` from ntdll.dll (bypasses compatibility shim):

| Major.Minor | Build | Result |
|-------------|-------|--------|
| 10.x | >= 22000 | Windows 11 |
| 10.x | < 22000 | Windows 10 |
| 6.3 | - | Windows 8.1 |
| 6.2 | - | Windows 8 |
| 6.1 | - | Windows 7 |
| 6.0 | - | Windows Vista |
| 5.x | - | Windows XP |

### Screen Capture Flow

```
GetDC(NULL) -> hScreenDC
CreateCompatibleDC(hScreenDC) -> hMemDC
GetSystemMetrics(SM_CXSCREEN/SM_CYSCREEN) -> screen size
CreateCompatibleBitmap(hScreenDC, 800, 450) -> hBmp
SelectObject(hMemDC, hBmp)
SetStretchBltMode(hMemDC, HALFTONE)
StretchBlt(hMemDC, 0,0,800,450, hScreenDC, 0,0,scrW,scrH, SRCCOPY)
Setup BITMAPINFOHEADER (24-bit, 800x450)
GetDIBits(hMemDC, hBmp, ...) -> pixel data
NetSendRaw(socket, BITMAPINFOHEADER+pixels, CAP_TOTAL)
Cleanup: SelectObject, DeleteObject, DeleteDC, ReleaseDC
```

### Persistent Shell

```
CreatePipe -> stdin (hInR, hShellInW)
CreatePipe -> stdout (hShellOutR, hOutW)
STARTUPINFO: hStdInput=hInR, hStdOutput=hOutW, hStdError=hOutW
CreateProcess("cmd.exe", ...) -> hShellProc
Close parent-side handles (hInR, hOutW)

For each command:
  WriteFile(hShellInW, command + CRLF)
  Loop: PeekNamedPipe -> ReadFile until no more output
  SendText(output)
```

### Builder Config Files

`client_config.inc`:
```asm
C2_PORT         equ 4444
DO_PERSIST_STARTUP  equ 1
DO_PERSIST_REGISTRY equ 0
```

`client_host.inc`:
```asm
szHostEnc   db "192.168.1.100", 0
```

These are generated by GenStub and included by Stub.asm at compile time via `include` directives

## Resource Embedding

The server embeds Stub.asm, Stub.rc, and Stub.manifest as RCDATA resources:

```rc
IDR_STUB_ASM  RCDATA  "Stub.asm"      ; ID 200
IDR_STUB_RC   RCDATA  "Stub.rc"       ; ID 201
IDR_STUB_MAN  RCDATA  "Stub.manifest" ; ID 202
```

At build time, `ExtractResource` uses FindResourceA -> LoadResource -> LockResource -> WriteFile to extract them to the output directory
