* 6809 assembly program generated by cmoc 0.1.85


	SECTION	start


program_start	EXPORT
_main	IMPORT
INILIB	IMPORT
_exit	IMPORT
program_start	EQU	*
	LDD	#-1024		stack space in bytes
	LBSR	INILIB		initialize standard library and global variables
	LBSR	_main		call main()
	PSHS	B,A		send main() return value to exit()
	LBSR	_exit		use LBSR to respect calling convention


	ENDSECTION




	SECTION	code


_NO_NODE	IMPORT
_memory	IMPORT
_lastIndex	IMPORT
_occurences	IMPORT
_occurencesCount	IMPORT
_rootNode	IMPORT
_dictionary	IMPORT
___va_arg	IMPORT
_abs	IMPORT
_addChildLeft	IMPORT
_addChildRight	IMPORT
_adddww	IMPORT
_atoff	IMPORT
_atoi	IMPORT
_atol	IMPORT
_atoui	IMPORT
_atoul	IMPORT
_bsearch	IMPORT
_changePrintfFormat	IMPORT
_cmpdww	IMPORT
_compareLong	IMPORT
_compress	IMPORT
_computeDic	IMPORT
_createNode	IMPORT
_createTree	IMPORT
_debugTree	IMPORT
_decodeDic	IMPORT
_delay	IMPORT
_divdwb	IMPORT
_divdww	IMPORT
_divmod16	IMPORT
_divmod8	IMPORT
_dwtoa	IMPORT
_enableCMOCFloatSupport	IMPORT
_encodeDic	IMPORT
_exit	IMPORT
_findDicCode	IMPORT
_findMinNode	IMPORT
_findOccurences	IMPORT
_ftoa	IMPORT
_getLastIndex	IMPORT
_getNode	IMPORT
_huffInit	IMPORT
_initBitField	IMPORT
_isalnum	IMPORT
_isalpha	IMPORT
_isdigit	IMPORT
_isspace	IMPORT
_itoa10	IMPORT
_labs	IMPORT
_logOut	IMPORT
_ltoa10	IMPORT
_memchr	IMPORT
_memcmp	IMPORT
_memcpy	IMPORT
_memichr	IMPORT
_memicmp	IMPORT
_memmove	IMPORT
_memset	IMPORT
_memset16	IMPORT
_mulwb	IMPORT
_mulww	IMPORT
_printf	IMPORT
_putchar	IMPORT
_putstr	IMPORT
_qsort	IMPORT
_rand	IMPORT
_readbits	IMPORT
_readline	IMPORT
_readword	IMPORT
_sbrk	IMPORT
_sbrkmax	IMPORT
_setConsoleOutHook	IMPORT
_set_null_ptr_handler	IMPORT
_set_stack_overflow_handler	IMPORT
_sprintf	IMPORT
_sqrt16	IMPORT
_sqrt32	IMPORT
_srand	IMPORT
_strcat	IMPORT
_strchr	IMPORT
_strcmp	IMPORT
_strcpy	IMPORT
_stricmp	IMPORT
_strlen	IMPORT
_strlwr	IMPORT
_strncmp	IMPORT
_strncpy	IMPORT
_strreplace	IMPORT
_strstr	IMPORT
_strtof	IMPORT
_strtol	IMPORT
_strtoul	IMPORT
_strupr	IMPORT
_subdww	IMPORT
_tolower	IMPORT
_toupper	IMPORT
_treeInit	IMPORT
_ultoa10	IMPORT
_uncompress	IMPORT
_updateDic	IMPORT
_utoa10	IMPORT
_vprintf	IMPORT
_vsprintf	IMPORT
_writebits	IMPORT
_zerodw	IMPORT
_printNode	EXPORT


*******************************************************************************

* FUNCTION printNode(): defined at main.c:26
_printNode	EQU	*
* Calling convention: Default
	PSHS	U
	LEAU	,S
* Formal parameter(s):
*      4,U:    2 bytes: n: struct NODE_STRUCT *
* Line main.c:28: if
	LDX	4,U		variable n
	LDD	5,X		member left of NODE_STRUCT
* optim: loadCmpZeroBeqOrBne
	BNE	L00114
* optim: branchToNextLocation
* Useless label L00116 removed
	LDX	4,U		variable n
	LDD	7,X		member right of NODE_STRUCT
* optim: loadCmpZeroBeqOrBne
	BEQ	L00115		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
L00114	EQU	*		then clause of if() started at main.c:28
* Line main.c:32
* Line main.c:29: if
	LDX	4,U		variable n
	LDD	3,X		member pValue of NODE_STRUCT
* optim: loadCmpZeroBeqOrBne
	BEQ	L00118		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00117 removed
* Line main.c:30
* Line main.c:30: function call: logOut()
	LDX	4,U		variable n
	LDD	3,X		member pValue of NODE_STRUCT
* Emitted no code to cast `void *' to `struct VALUE_STRUCT *'
	TFR	D,X
	LEAS	-4,S		pass unsigned long by value
	LBSR	push4ByteStruct	argument 3 of logOut(): unsigned long
	LEAX	S00103,PCR	"[%lu]"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	8,S
	BRA	L00120		jump over else clause
L00118	EQU	*		else clause of if() started at main.c:29
* Line main.c:32
* Line main.c:32: function call: logOut()
	LEAX	S00104,PCR	"[x]"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	4,S
* Useless label L00119 removed
	BRA	L00120		jump over else clause
L00115	EQU	*		else clause of if() started at main.c:28
* Line main.c:34
* Line main.c:34: function call: logOut()
	LDX	4,U		variable n
	LDD	3,X		member pValue of NODE_STRUCT
* Emitted no code to cast `void *' to `struct VALUE_STRUCT *'
	TFR	D,X
	LDB	4,X		member ch of VALUE_STRUCT
	CLRA			promoting byte argument to word
	PSHS	B,A		argument 3 of logOut(): unsigned char
	LEAX	S00105,PCR	"(%d)"
* optim: optimizePshsOps
	LDB	#$01		optim: changeLoadDToLoadB
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
L00120	EQU	*		end of if() started at main.c:28
* Useless label L00100 removed
	LEAS	,U
	PULS	U,PC
* END FUNCTION printNode(): defined at main.c:26
funcend_printNode	EQU *
funcsize_printNode	EQU	funcend_printNode-_printNode
_debugNodeWithArg	EXPORT


*******************************************************************************

* FUNCTION debugNodeWithArg(): defined at main.c:37
_debugNodeWithArg	EQU	*
* Calling convention: Default
	PSHS	U
	LEAU	,S
* Formal parameter(s):
*      4,U:    2 bytes: n: struct NODE_STRUCT *
*      6,U:    2 bytes: arg: void *
* Line main.c:38: function call: logOut()
* Line main.c:38: conditional expression
	LDD	6,U		variable `arg', declared at main.c:37
* optim: loadCmpZeroBeqOrBne
	BEQ	L00122		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00121 removed
	LDD	6,U		variable `arg', declared at main.c:37
* Emitted no code to cast `void *' to `char *'
	TFR	D,X
	LDB	,X		indirection
	BRA	L00123		end of true expression of conditional
L00122	EQU	*
	LDB	#$2A		decimal 42 signed
L00123	EQU	*
	SEX			promoting byte argument to word
	PSHS	B,A		argument 5 of logOut(): char
	LDX	4,U		variable n
	LDD	3,X		member pValue of NODE_STRUCT
* Emitted no code to cast `void *' to `struct VALUE_STRUCT *'
	TFR	D,X
	LDB	4,X		member ch of VALUE_STRUCT
	CLRA			promoting byte argument to word
	PSHS	B,A		argument 4 of logOut(): unsigned char
	LDX	4,U		variable n
	LDD	3,X		member pValue of NODE_STRUCT
* Emitted no code to cast `void *' to `struct VALUE_STRUCT *'
	TFR	D,X
	LEAS	-4,S		pass unsigned long by value
	LBSR	push4ByteStruct	argument 3 of logOut(): unsigned long
	LEAX	S00106,PCR	"[%lu][%c], arg=%c"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	12,S
	CLRB
* optim: branchToNextLocation
* Useless label L00101 removed
	LEAS	,U
	PULS	U,PC
* END FUNCTION debugNodeWithArg(): defined at main.c:37
funcend_debugNodeWithArg	EQU *
funcsize_debugNodeWithArg	EQU	funcend_debugNodeWithArg-_debugNodeWithArg
_main	EXPORT


*******************************************************************************

* FUNCTION main(): defined at main.c:45
_main	EQU	*
* Calling convention: Default
	PSHS	U
	LEAU	,S
	LEAS	-1119,S
* Local non-static variable(s):
*  -1119,U:    2 bytes: i: int
*  -1117,U:    5 bytes: message: unsigned char[]
*  -1112,U:    2 bytes: u: int
*  -1110,U:    2 bytes: x: int
*  -1108,U:   80 bytes: indentString: char[]
*  -1028,U:  512 bytes: compressedOutput: unsigned char[]
*   -516,U:    2 bytes: sz: int
*   -514,U:  512 bytes: uncompressedOutput: unsigned char[]
*     -2,U:    2 bytes: diffIdx: int
* Line main.c:49: function call: huffInit()
	LBSR	_huffInit
* Line main.c:51: init of variable message
	LDD	#5		length of string literal + terminating NUL
	PSHS	B,A		push length to _memcpy
	LEAY	S00107,PCR	optim: transformPshsXPshsX
* optim: optimizePshsOps
	LEAX	-1117,U		byte array message
	PSHS	Y,X		optim: optimizePshsOps
	LBSR	_memcpy
	LEAS	6,S
* Line main.c:58: function call: logOut()
	LEAY	-1117,U		optim: transformPshsXPshsX
* optim: optimizePshsOps
	LEAX	S00108,PCR	"compressing:[%s]"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	Y,X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
* Line main.c:60: function call: findOccurences()
	CLRA
	LDB	#$05		constant expression: 5 decimal, unsigned
	PSHS	B,A		argument 2 of findOccurences(): unsigned int
	LEAX	-1117,U		address of array message
	PSHS	X		argument 1 of findOccurences(): unsigned char[]
	LBSR	_findOccurences
	LEAS	4,S
* Line main.c:62: init of variable u
	CLRA
	CLRB
	STD	-1112,U		variable u
* Line main.c:63: function call: logOut()
	LEAY	-1112,U		optim: transformPshsXPshsX
* optim: optimizePshsOps
	LEAX	S00109,PCR	"before:%p"
* optim: optimizePshsOps
	LDB	#$01		optim: removeAndOrMulAddSub
	PSHS	Y,X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
* Line main.c:64: function call: createTree()
	LEAX	_occurences+0,PCR	address of array occurences
	PSHS	X		argument 1 of createTree(): struct VALUE_STRUCT[]
	LBSR	_createTree
	LEAS	2,S
* Line main.c:65: init of variable x
	CLRA
	CLRB
	STD	-1110,U		variable x
* Line main.c:66: function call: logOut()
	LEAY	-1110,U		optim: transformPshsXPshsX
* optim: optimizePshsOps
	LEAX	S00110,PCR	"after:%p"
* optim: optimizePshsOps
	LDB	#$01		optim: removeAndOrMulAddSub
	PSHS	Y,X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
* Line main.c:68: function call: memset()
	CLRA
	LDB	#$50		decimal 80 signed
	PSHS	B,A		argument 3 of memset(): int
* optim: stripExtraClrA_B
	CLRB
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-1108,U		address of array indentString
	PSHS	X		argument 1 of memset(): char[]
	LBSR	_memset
	LEAS	6,S
* Line main.c:70: function call: debugTree()
	CLRA
	CLRB
	PSHS	B,A		argument 4 of debugTree(): int
	LEAX	_printNode,PCR	address of printNode(), defined at main.c:26
	PSHS	X		optim: optimizeTfrPush
* optim: optimizeTfrPush
	LEAX	-1108,U		address of array indentString
* optim: optimizePshsOps
	LDD	_rootNode+0,PCR	variable `rootNode', declared at Huffman.h:33
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_debugTree
	LEAS	8,S
* Line main.c:73: function call: updateDic()
	LDD	_occurencesCount+0,PCR	variable `occurencesCount', declared at Huffman.h:32
	PSHS	B,A		argument 3 of updateDic(): unsigned int
	LEAX	_occurences+0,PCR	address of array occurences
* optim: optimizePshsOps
	LDD	_rootNode+0,PCR	variable `rootNode', declared at Huffman.h:33
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_updateDic
	LEAS	6,S
* Line main.c:100: init of variable sz
* Line main.c:100: function call: compress()
	LDX	#$01		optim: transformPshsDPshsD
* optim: optimizePshsOps
	LDD	#$0200		constant expression: 512 decimal, unsigned
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-1028,U		address of array compressedOutput
* optim: optimizePshsOps
	CLRA
	LDB	#$05		constant expression: 5 decimal, unsigned
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-1117,U		address of array message
	PSHS	X		argument 1 of compress(): unsigned char[]
	LBSR	_compress
	LEAS	10,S
	STD	-516,U		variable sz
* Line main.c:101: function call: logOut()
* optim: storeLoad
	PSHS	B,A		argument 3 of logOut(): int
	LEAX	S00111,PCR	"compressed size:%d"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
* Line main.c:105: assignment: =
* Line main.c:105: function call: uncompress()
	LDD	#$0200		constant expression: 512 decimal, unsigned
	PSHS	B,A		argument 4 of uncompress(): unsigned int
	LEAX	-514,U		address of array uncompressedOutput
* optim: optimizePshsOps
	LDD	#$0200		constant expression: 512 decimal, unsigned
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-1028,U		address of array compressedOutput
	PSHS	X		argument 1 of uncompress(): unsigned char[]
	LBSR	_uncompress
	LEAS	8,S
	STD	-516,U
* Line main.c:108: init of variable diffIdx
	LDD	#$FFFF		65535
	STD	-2,U		variable diffIdx
* Line main.c:109: for init
* Line main.c:109: init of variable i
	CLRA
	CLRB
	STD	-1119,U		variable i
	BRA	L00125		jump to for condition
L00124	EQU	*
* Line main.c:112: for body
* Line main.c:110: if
	LDD	-1119,U		variable i
	LEAX	-514,U		address of array uncompressedOutput
* optimizeLoadDX
	LDB	D,X		get r-value
	PSHS	B
	LDD	-1119,U		variable i
	LEAX	-1117,U		address of array message
* optimizeLoadDX
	LDB	D,X		get r-value
	CMPB	,S+		compare with LSB
	BEQ	L00129		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00128 removed
* Line main.c:111
* Line main.c:111: assignment: =
* optim: stripConsecutiveLoadsToSameReg
	LDD	-1119,U
	STD	-2,U
L00129	EQU	*		else clause of if() started at main.c:110
* Useless label L00130 removed
* Useless label L00126 removed
* Line main.c:109: for increment(s)
	LDD	-1119,U
	ADDD	#1
	STD	-1119,U
L00125	EQU	*
* Line main.c:109: for condition
	LDD	-1119,U		variable i
	CMPD	#$05
	BLO	L00124
* optim: branchToNextLocation
* Useless label L00127 removed
* Line main.c:112: if
	LDD	-2,U		variable diffIdx
	CMPD	#$FFFF
	BLE	L00132		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00131 removed
* Line main.c:113
* Line main.c:113: function call: logOut()
	LDD	-2,U		variable `diffIdx', declared at main.c:108
	PSHS	B,A		argument 3 of logOut(): int
	LEAX	S00112,PCR	"Messages differ at %d"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
	BRA	L00133		jump over else clause
L00132	EQU	*		else clause of if() started at main.c:112
* Line main.c:115
* Line main.c:115: function call: logOut()
	LEAX	S00113,PCR	"No difference between uncompressed and compressed message"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	4,S
L00133	EQU	*		end of if() started at main.c:112
* Line main.c:121: return with value
	CLRA
	CLRB
* optim: branchToNextLocation
* Useless label L00102 removed
	LEAS	,U
	PULS	U,PC
* END FUNCTION main(): defined at main.c:45
funcend_main	EQU *
funcsize_main	EQU	funcend_main-_main


	ENDSECTION




	SECTION	initgl_start


INITGL	EXPORT
INITGL	EQU	*


	ENDSECTION




	SECTION	initgl




*******************************************************************************

* Initialize global variables.


	ENDSECTION




	SECTION	rodata


string_literals_start	EQU	*


*******************************************************************************

* STRING LITERALS
S00103	EQU	*
	FCC	"[%lu]"
	FCB	0
S00104	EQU	*
	FCC	"[x]"
	FCB	0
S00105	EQU	*
	FCC	"(%d)"
	FCB	0
S00106	EQU	*
	FCC	"[%lu][%c], arg=%c"
	FCB	0
S00107	EQU	*
	FCB	$C3
	FCB	$A9
	FCB	$C3
	FCB	$A0
	FCB	0
S00108	EQU	*
	FCC	"compressing:[%s]"
	FCB	0
S00109	EQU	*
	FCC	"before:%p"
	FCB	0
S00110	EQU	*
	FCC	"after:%p"
	FCB	0
S00111	EQU	*
	FCC	"compressed size:%d"
	FCB	0
S00112	EQU	*
	FCC	"Messages differ at %d"
	FCB	0
S00113	EQU	*
	FCC	"No difference between uncompressed and compressed message"
	FCB	0
string_literals_end	EQU	*


*******************************************************************************

* READ-ONLY GLOBAL VARIABLES


	ENDSECTION




	SECTION	rwdata


* Statically-initialized global variables
* Statically-initialized local static variables


	ENDSECTION




	SECTION	bss


bss_start	EQU	*
* Uninitialized global variables
* Uninitialized local static variables
bss_end	EQU	*


	ENDSECTION




	SECTION	initgl_end


	RTS			end of global variable initialization


	ENDSECTION




*******************************************************************************



	SECTION	program_end


program_end	EXPORT
program_end	EQU	*


	ENDSECTION




*******************************************************************************

* Importing 11 utility routine(s).
_compress	IMPORT
_createTree	IMPORT
_debugTree	IMPORT
_findOccurences	IMPORT
_huffInit	IMPORT
_logOut	IMPORT
_memcpy	IMPORT
_memset	IMPORT
_uncompress	IMPORT
_updateDic	IMPORT
push4ByteStruct	IMPORT


*******************************************************************************

	END
