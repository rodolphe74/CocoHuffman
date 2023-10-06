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

* FUNCTION printNode(): defined at HuffBuffer.c:16
_printNode	EQU	*
* Calling convention: Default
	PSHS	U
	LEAU	,S
* Formal parameter(s):
*      4,U:    2 bytes: n: struct NODE_STRUCT *
* Line HuffBuffer.c:18: if
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
L00114	EQU	*		then clause of if() started at HuffBuffer.c:18
* Line HuffBuffer.c:22
* Line HuffBuffer.c:19: if
	LDX	4,U		variable n
	LDD	3,X		member pValue of NODE_STRUCT
* optim: loadCmpZeroBeqOrBne
	BEQ	L00118		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00117 removed
* Line HuffBuffer.c:20
* Line HuffBuffer.c:20: function call: logOut()
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
L00118	EQU	*		else clause of if() started at HuffBuffer.c:19
* Line HuffBuffer.c:22
* Line HuffBuffer.c:22: function call: logOut()
	LEAX	S00104,PCR	"[x]"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	4,S
* Useless label L00119 removed
	BRA	L00120		jump over else clause
L00115	EQU	*		else clause of if() started at HuffBuffer.c:18
* Line HuffBuffer.c:24
* Line HuffBuffer.c:24: function call: logOut()
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
L00120	EQU	*		end of if() started at HuffBuffer.c:18
* Useless label L00100 removed
	LEAS	,U
	PULS	U,PC
* END FUNCTION printNode(): defined at HuffBuffer.c:16
funcend_printNode	EQU *
funcsize_printNode	EQU	funcend_printNode-_printNode
_compareBuffers	EXPORT


*******************************************************************************

* FUNCTION compareBuffers(): defined at HuffBuffer.c:27
_compareBuffers	EQU	*
* Calling convention: Default
	PSHS	U
	LEAU	,S
	LEAS	-17,S
* Formal parameter(s):
*      4,U:    2 bytes: first: unsigned char *
*      6,U:    2 bytes: firstSz: unsigned int
*      8,U:    2 bytes: second: unsigned char *
*     10,U:    2 bytes: secondSz: unsigned int
*     12,U:    2 bytes: testIdx: unsigned int
*     14,U:    2 bytes: cSz: unsigned int
* Local non-static variable(s):
*    -17,U:    2 bytes: k: int
*    -15,U:    5 bytes: $V00111: float
*    -10,U:    5 bytes: $V00112: float
*     -5,U:    5 bytes: $V00113: float
* Line HuffBuffer.c:29: if
	LDD	6,U		variable firstSz
	CMPD	10,U		variable secondSz
	BEQ	L00122		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00121 removed
* Line HuffBuffer.c:29
* Line HuffBuffer.c:30: function call: logOut()
	LEAX	S00106,PCR	"### messages sizes differ!\n"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	4,S
L00122	EQU	*		else clause of if() started at HuffBuffer.c:29
* Useless label L00123 removed
* Line HuffBuffer.c:32: for init
* Line HuffBuffer.c:32: init of variable k
	CLRA
	CLRB
	STD	-17,U		variable k
	LBRA	L00125		jump to for condition
L00124	EQU	*
* Line HuffBuffer.c:32: for body
* Line HuffBuffer.c:33: if
	LDD	-17,U		variable k
	LDX	8,U		pointer second
* optimizeLoadDX
	LDB	D,X		get r-value
	PSHS	B
	LDD	-17,U		variable k
	LDX	4,U		pointer first
* optimizeLoadDX
	LDB	D,X		get r-value
	CMPB	,S+		compare with LSB
	BEQ	L00129		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00128 removed
* Line HuffBuffer.c:33
* Line HuffBuffer.c:34: function call: logOut()
	LDD	-17,U		variable k
	LDX	8,U		pointer second
* optimizeLoadDX
	LDB	D,X		get r-value
	CLRA			promoting byte argument to word
	PSHS	B,A		argument 4 of logOut(): unsigned char
	LDD	-17,U		variable k
	LDX	4,U		pointer first
* optimizeLoadDX
	LDB	D,X		get r-value
	CLRA			promoting byte argument to word
	PSHS	B,A		argument 3 of logOut(): unsigned char
	LEAX	S00107,PCR	"%d<>%d\n"
* optim: optimizePshsOps
	LDB	#$01		optim: changeLoadDToLoadB
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	8,S
* Line HuffBuffer.c:35: function call: logOut()
	LDD	-17,U		variable `k', declared at HuffBuffer.c:32
	PSHS	B,A		argument 3 of logOut(): int
	LEAX	S00108,PCR	"### messages differ at %d\n"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	6,S
* Line HuffBuffer.c:36: return with value
	CLRA
	LDB	#$01		decimal 1 signed
	BRA	L00101		return (HuffBuffer.c:36)
L00129	EQU	*		else clause of if() started at HuffBuffer.c:33
* Useless label L00130 removed
* Useless label L00126 removed
* Line HuffBuffer.c:32: for increment(s)
	LDD	-17,U
	ADDD	#1
	STD	-17,U
L00125	EQU	*
* Line HuffBuffer.c:32: for condition
	LDD	-17,U		variable k
	CMPD	6,U		variable firstSz
	LBLO	L00124
* optim: branchToNextLocation
* Useless label L00127 removed
* Line HuffBuffer.c:39: function call: logOut()
	LDX	6,U		optim: transformPshsDPshsD
* optim: optimizePshsOps
	LDD	14,U		variable `cSz', declared at HuffBuffer.c:27
	PSHS	X,B,A		optim: optimizePshsOps
* Push right operand of div.
	LDD	14,U		variable `cSz', declared at HuffBuffer.c:27
	LEAX	-5,U		destination of cast
	LBSR	initSingleFromUnsignedWord
	PSHS	X
* Push left operand of div.
	LDD	10,U		variable `secondSz', declared at HuffBuffer.c:27
	LEAX	-10,U		destination of cast
	LBSR	initSingleFromUnsignedWord
	PSHS	X
	LEAX	-15,U		temporary destination, type float
	LBSR	divSingleSingle	preserves X
	LEAS	4,S
	LEAS	-5,S		pass float by value
	LBSR	push5ByteStruct	argument 4 of logOut(): float
	LDD	12,U		variable `testIdx', declared at HuffBuffer.c:27
	PSHS	B,A		argument 3 of logOut(): unsigned int
	LEAX	S00109,PCR	"### test %d (%f) all good! %d vs %d\n"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	15,S
* Line HuffBuffer.c:40: return with value
	CLRA
	CLRB
* optim: branchToNextLocation
L00101	EQU	*		end of compareBuffers()
	LEAS	,U
	PULS	U,PC
* END FUNCTION compareBuffers(): defined at HuffBuffer.c:27
funcend_compareBuffers	EQU *
funcsize_compareBuffers	EQU	funcend_compareBuffers-_compareBuffers
_main	EXPORT


*******************************************************************************

* FUNCTION main(): defined at HuffBuffer.c:43
_main	EQU	*
* Calling convention: Default
	PSHS	U
	LEAU	,S
	LEAS	-4110,S
* Local non-static variable(s):
*  -4110,U:    2 bytes: j: int
*  -4105,U:    2 bytes: i: int
*  -4103,U:    2 bytes: cidx: int
*  -4101,U:    2 bytes: bidx: int
*  -4099,U: 1024 bytes: buf: unsigned char[]
*  -3075,U: 2048 bytes: cbuf: unsigned char[]
*  -1027,U: 1024 bytes: back: unsigned char[]
*     -3,U:    2 bytes: sz: unsigned int
*     -1,U:    1 byte : u: unsigned char
* Line HuffBuffer.c:45: init of variable cidx
	CLRA
	CLRB
	STD	-4103,U		variable cidx
* Line HuffBuffer.c:46: init of variable bidx
* optim: stripExtraClrA_B
* optim: stripExtraClrA_B
	STD	-4101,U		variable bidx
* Line HuffBuffer.c:55: for init
* Line HuffBuffer.c:55: init of variable i
* optim: stripExtraClrA_B
* optim: stripExtraClrA_B
	STD	-4105,U		variable i
	LBRA	L00132		jump to for condition
L00131	EQU	*
* Line HuffBuffer.c:55: for body
* Line HuffBuffer.c:56: init of variable sz
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	B,A
* Line HuffBuffer.c:56: function call: rand()
	LBSR	_rand
	TFR	D,X		optim: stripExtraPulsX
	LDD	#$0400		decimal 1024 signed
* optim: stripExtraPulsX
	LBSR	SDIV16
	TFR	D,X		optim: stripExtraPulsX
* optim: removeClrAFromArrayIndexMul
	LDB	#$01		decimal 1 signed
* optim: stripExtraPulsX
	LBSR	MUL168
	ADDD	,S++
	STD	-4108,U		variable sz
* Line HuffBuffer.c:57: init of variable u
	CLR	-4106,U		variable u
* Line HuffBuffer.c:58: function call: memset()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:59: function call: memset()
	LDD	#$0800		constant expression: 2048 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-3075,U		address of array cbuf
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:60: function call: memset()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-1027,U		address of array back
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:61: for init
* Line HuffBuffer.c:61: init of variable j
	CLRA
	CLRB
	STD	-4110,U		variable j
	BRA	L00136		jump to for condition
L00135	EQU	*
* Line HuffBuffer.c:61: for body
* Line HuffBuffer.c:62: if
	LDX	-4110,U		left
	CLRA
	LDB	#$28		right
	LBSR	SDIV16
	ADDD	#0
	BNE	L00140		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00139 removed
* Line HuffBuffer.c:63
* Line HuffBuffer.c:63: assignment: =
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	B,A
* Line HuffBuffer.c:63: function call: rand()
	LBSR	_rand
	TFR	D,X		optim: stripExtraPulsX
	CLRA
	LDB	#$FE		decimal 254 signed
* optim: stripExtraPulsX
	LBSR	SDIV16
	ADDD	,S++
* Cast from `int' to byte: result already in B
	STB	-4106,U
L00140	EQU	*		else clause of if() started at HuffBuffer.c:62
* Useless label L00141 removed
* Line HuffBuffer.c:64: assignment: =
	LDB	-4106,U		variable `u', declared at HuffBuffer.c:57
	PSHS	B
	LDD	-4110,U		variable j
	LEAX	-4099,U		address of array buf
	LEAX	D,X		add offset
	LDB	,S+
	STB	,X
* Useless label L00137 removed
* Line HuffBuffer.c:61: for increment(s)
	LDD	-4110,U
	ADDD	#1
	STD	-4110,U
L00136	EQU	*
* Line HuffBuffer.c:61: for condition
	LDD	-4110,U		variable j
	CMPD	-4108,U		variable sz
	BLO	L00135
* optim: branchToNextLocation
* Useless label L00138 removed
* Line HuffBuffer.c:66: assignment: =
* Line HuffBuffer.c:66: function call: compress()
	LDX	#$01		optim: transformPshsDPshsD
* optim: optimizePshsOps
	LDD	#$0800		constant expression: 2048 decimal, signed
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-3075,U		address of array cbuf
* optim: optimizePshsOps
	LDD	-4108,U		variable `sz', declared at HuffBuffer.c:56
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of compress(): unsigned char[]
	LBSR	_compress
	LEAS	10,S
	STD	-4103,U
* Line HuffBuffer.c:70: function call: logOut()
* optim: storeLoad
	PSHS	B,A		argument 4 of logOut(): int
	LDD	-4108,U		variable `sz', declared at HuffBuffer.c:56
	PSHS	B,A		argument 3 of logOut(): unsigned int
	LEAX	S00110,PCR	"size:%lu cidx:%d"
* optim: optimizePshsOps
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	X,B,A		optim: optimizePshsOps
	LBSR	_logOut
	LEAS	8,S
* Line HuffBuffer.c:74: assignment: =
* Line HuffBuffer.c:74: function call: uncompress()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 4 of uncompress(): int
	LEAX	-1027,U		address of array back
* optim: optimizePshsOps
	LDD	-4103,U		variable `cidx', declared at HuffBuffer.c:45
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-3075,U		address of array cbuf
	PSHS	X		argument 1 of uncompress(): unsigned char[]
	LBSR	_uncompress
	LEAS	8,S
	STD	-4101,U
* Line HuffBuffer.c:79: function call: compareBuffers()
	LDY	-4103,U		optim: transformPshsXPshsX
* optim: optimizePshsOps
	LDX	-4105,U		optim: transformPshsDPshsD
* optim: optimizePshsOps
	LDD	-4101,U		variable `bidx', declared at HuffBuffer.c:46
	PSHS	Y,X,B,A		optim: optimizePshsOps
	LEAX	-1027,U		address of array back
* optim: optimizePshsOps
	LDD	-4108,U		variable `sz', declared at HuffBuffer.c:56
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of compareBuffers(): unsigned char[]
	LBSR	_compareBuffers
	LEAS	12,S
* Useless label L00133 removed
* Line HuffBuffer.c:55: for increment(s)
	LDD	-4105,U
	ADDD	#1
	STD	-4105,U
L00132	EQU	*
* Line HuffBuffer.c:55: for condition
	LDD	-4105,U		variable i
	CMPD	#$05
	LBLT	L00131
* optim: branchToNextLocation
* Useless label L00134 removed
* Line HuffBuffer.c:85: init of variable sz
	LDD	#$0400		1024
	STD	-3,U		variable sz
* Line HuffBuffer.c:86: init of variable u
	CLR	-1,U		variable u
* Line HuffBuffer.c:87: function call: memset()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:88: function call: memset()
	LDD	#$0800		constant expression: 2048 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-3075,U		address of array cbuf
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:89: function call: memset()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-1027,U		address of array back
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:90: for init
* Line HuffBuffer.c:90: init of variable j
	CLRA
	CLRB
	STD	-4105,U		variable j
	BRA	L00143		jump to for condition
L00142	EQU	*
* Line HuffBuffer.c:90: for body
* Line HuffBuffer.c:91: if
	LDX	-4105,U		left
	CLRA
	LDB	#$28		right
	LBSR	SDIV16
	ADDD	#0
	BNE	L00147		 (optim: condBranchOverUncondBranch)
* optim: condBranchOverUncondBranch
* Useless label L00146 removed
* Line HuffBuffer.c:92
* Line HuffBuffer.c:92: assignment: =
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	B,A
* Line HuffBuffer.c:92: function call: rand()
	LBSR	_rand
	TFR	D,X		optim: stripExtraPulsX
	CLRA
	LDB	#$FE		decimal 254 signed
* optim: stripExtraPulsX
	LBSR	SDIV16
	ADDD	,S++
* Cast from `int' to byte: result already in B
	STB	-1,U
L00147	EQU	*		else clause of if() started at HuffBuffer.c:91
* Useless label L00148 removed
* Line HuffBuffer.c:93: assignment: =
	LDB	-1,U		variable `u', declared at HuffBuffer.c:86
	PSHS	B
	LDD	-4105,U		variable j
	LEAX	-4099,U		address of array buf
	LEAX	D,X		add offset
	LDB	,S+
	STB	,X
* Useless label L00144 removed
* Line HuffBuffer.c:90: for increment(s)
	LDD	-4105,U
	ADDD	#1
	STD	-4105,U
L00143	EQU	*
* Line HuffBuffer.c:90: for condition
	LDD	-4105,U		variable j
	CMPD	-3,U		variable sz
	BLO	L00142
* optim: branchToNextLocation
* Useless label L00145 removed
* Line HuffBuffer.c:95: function call: computeDic()
	LDD	-3,U		variable `sz', declared at HuffBuffer.c:85
	PSHS	B,A		argument 2 of computeDic(): unsigned int
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of computeDic(): unsigned char[]
	LBSR	_computeDic
	LEAS	4,S
* Line HuffBuffer.c:100: assignment: =
* Line HuffBuffer.c:100: function call: compress()
	LDX	#$02		optim: transformPshsDPshsD
* optim: optimizePshsOps
	LDD	#$0800		constant expression: 2048 decimal, signed
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-3075,U		address of array cbuf
* optim: optimizePshsOps
	LDD	-3,U		variable `sz', declared at HuffBuffer.c:85
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of compress(): unsigned char[]
	LBSR	_compress
	LEAS	10,S
	STD	-4103,U
* Line HuffBuffer.c:101: assignment: =
* Line HuffBuffer.c:101: function call: uncompress()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 4 of uncompress(): int
	LEAX	-1027,U		address of array back
* optim: optimizePshsOps
	LDD	-4103,U		variable `cidx', declared at HuffBuffer.c:45
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-3075,U		address of array cbuf
	PSHS	X		argument 1 of uncompress(): unsigned char[]
	LBSR	_uncompress
	LEAS	8,S
	STD	-4101,U
* Line HuffBuffer.c:102: function call: compareBuffers()
	LDD	-4103,U		variable `cidx', declared at HuffBuffer.c:45
	PSHS	B,A		argument 6 of compareBuffers(): int
	CLRA
	CLRB
	PSHS	B,A		argument 5 of compareBuffers(): int
	LDD	-4101,U		variable `bidx', declared at HuffBuffer.c:46
	PSHS	B,A		argument 4 of compareBuffers(): int
	LEAX	-1027,U		address of array back
* optim: optimizePshsOps
	LDD	-3,U		variable `sz', declared at HuffBuffer.c:85
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of compareBuffers(): unsigned char[]
	LBSR	_compareBuffers
	LEAS	12,S
* Line HuffBuffer.c:106: for init
* Line HuffBuffer.c:106: init of variable i
	CLRA
	LDB	#$01		1
	STD	-4105,U		variable i
	LBRA	L00150		jump to for condition
L00149	EQU	*
* Line HuffBuffer.c:106: for body
* Line HuffBuffer.c:107: assignment: =
	CLRA
	LDB	#$01		decimal 1 signed
	PSHS	B,A
* Line HuffBuffer.c:107: function call: rand()
	LBSR	_rand
	TFR	D,X		optim: stripExtraPulsX
	LDD	#$0400		decimal 1024 signed
* optim: stripExtraPulsX
	LBSR	SDIV16
	TFR	D,X		optim: stripExtraPulsX
* optim: removeClrAFromArrayIndexMul
	LDB	#$01		decimal 1 signed
* optim: stripExtraPulsX
	LBSR	MUL168
	ADDD	,S++
	STD	-3,U
* Line HuffBuffer.c:108: function call: memset()
	LDD	#$0800		constant expression: 2048 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-3075,U		address of array cbuf
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:109: function call: memset()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 3 of memset(): int
	CLRA
* optim: removeClr
	PSHS	B,A		argument 2 of memset(): int
	LEAX	-1027,U		address of array back
	PSHS	X		argument 1 of memset(): unsigned char[]
	LBSR	_memset
	LEAS	6,S
* Line HuffBuffer.c:110: assignment: =
* Line HuffBuffer.c:110: function call: compress()
	CLRA
	CLRB
	PSHS	B,A		argument 5 of compress(): int
	LDD	#$0800		constant expression: 2048 decimal, signed
	PSHS	B,A		argument 4 of compress(): int
	LEAX	-3075,U		address of array cbuf
* optim: optimizePshsOps
	LDD	-3,U		variable `sz', declared at HuffBuffer.c:85
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of compress(): unsigned char[]
	LBSR	_compress
	LEAS	10,S
	STD	-4103,U
* Line HuffBuffer.c:111: assignment: =
* Line HuffBuffer.c:111: function call: uncompress()
	LDD	#$0400		constant expression: 1024 decimal, signed
	PSHS	B,A		argument 4 of uncompress(): int
	LEAX	-1027,U		address of array back
* optim: optimizePshsOps
	LDD	-4103,U		variable `cidx', declared at HuffBuffer.c:45
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-3075,U		address of array cbuf
	PSHS	X		argument 1 of uncompress(): unsigned char[]
	LBSR	_uncompress
	LEAS	8,S
	STD	-4101,U
* Line HuffBuffer.c:112: function call: compareBuffers()
	LDY	-4103,U		optim: transformPshsXPshsX
* optim: optimizePshsOps
	LDX	-4105,U		optim: transformPshsDPshsD
* optim: optimizePshsOps
	LDD	-4101,U		variable `bidx', declared at HuffBuffer.c:46
	PSHS	Y,X,B,A		optim: optimizePshsOps
	LEAX	-1027,U		address of array back
* optim: optimizePshsOps
	LDD	-3,U		variable `sz', declared at HuffBuffer.c:85
	PSHS	X,B,A		optim: optimizePshsOps
	LEAX	-4099,U		address of array buf
	PSHS	X		argument 1 of compareBuffers(): unsigned char[]
	LBSR	_compareBuffers
	LEAS	12,S
* Useless label L00151 removed
* Line HuffBuffer.c:106: for increment(s)
	LDD	-4105,U
	ADDD	#1
	STD	-4105,U
L00150	EQU	*
* Line HuffBuffer.c:106: for condition
	LDD	-4105,U		variable i
	CMPD	#$05
	LBLT	L00149
* optim: branchToNextLocation
* Useless label L00152 removed
* Line HuffBuffer.c:115: return with value
	CLRA
	CLRB
* optim: branchToNextLocation
* Useless label L00102 removed
	LEAS	,U
	PULS	U,PC
* END FUNCTION main(): defined at HuffBuffer.c:43
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
	FCC	"### messages sizes differ!"
	FCB	$0A
	FCB	0
S00107	EQU	*
	FCC	"%d<>%d"
	FCB	$0A
	FCB	0
S00108	EQU	*
	FCC	"### messages differ at %d"
	FCB	$0A
	FCB	0
S00109	EQU	*
	FCC	"### test %d (%f) all good! %d vs %d"
	FCB	$0A
	FCB	0
S00110	EQU	*
	FCC	"size:%lu cidx:%d"
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

* Importing 13 utility routine(s).
MUL16	IMPORT
MUL168	IMPORT
SDIV16	IMPORT
_compress	IMPORT
_computeDic	IMPORT
_logOut	IMPORT
_memset	IMPORT
_rand	IMPORT
_uncompress	IMPORT
divSingleSingle	IMPORT
initSingleFromUnsignedWord	IMPORT
push4ByteStruct	IMPORT
push5ByteStruct	IMPORT


*******************************************************************************

	END
