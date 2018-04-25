implementation module BuiltinABCInstructions

import StdMisc
import StdOverloaded

import Text

import Cloogle

import CloogleDB

builtin_abc_instructions :: [ABCInstructionEntry]
builtin_abc_instructions =
	[ i_ccall
	, i_centry
	, i_halt
	, i_instruction
	, i_load_i
	, i_load_si16
	, i_load_si32
	, i_load_ui8
	, i_no_op
	, d_d
	, d_o
	: [{zero & aie_instruction=i} \\ i <- other_instructions]
	]

instance zero ABCInstructionEntry
where
	zero =
		{ aie_instruction = undef
		, aie_arguments   = []
		, aie_description = "There is no documentation for this ABC instruction yet."
		}

LABEL   :== ABCArgument ABCTypeLabel  False
LABEL_  :== ABCArgument ABCTypeLabel  True
STRING  :== ABCArgument ABCTypeString False
STRING_ :== ABCArgument ABCTypeString True
INT     :== ABCArgument ABCTypeInt    False
INT_    :== ABCArgument ABCTypeInt    True

i_ccall :: ABCInstructionEntry
i_ccall =
	{ zero
	& aie_instruction = "ccall"
	, aie_arguments   = [LABEL, STRING]
	, aie_description = "Calls a C function."
	}

i_centry :: ABCInstructionEntry
i_centry =
	{ zero
	& aie_instruction = "centry"
	, aie_arguments   = [LABEL, LABEL, STRING]
	, aie_description = "Adds code to call a Clean function from C." +
		"Usually it is not needed to write this instruction yourself. It is generated with the `foreign export` construct.\n\n" +
		"The first label is the name of the C function to generate. The second label is the Clean function to link it to.\n\n" +
		"The string argument indicates the type. For more information, see {{`ccall`}}."
	}

i_halt :: ABCInstructionEntry
i_halt =
	{ zero
	& aie_instruction = "halt"
	, aie_description = "Terminates the program immediately."
	}

i_instruction :: ABCInstructionEntry
i_instruction =
	{ zero
	& aie_instruction = "instruction"
	, aie_arguments   = [INT]
	, aie_description = "Adds the raw argument as a word in the generated object file."
	}

i_load_i :: ABCInstructionEntry
i_load_i =
	{ zero
	& aie_instruction = "load_i"
	, aie_arguments   = [INT]
	, aie_description = "Take the top of the B-stack as a pointer and read an integer from that pointer with the argument as offset.\n\n" +
		"See also {{`load_si16`}}, {{`load_si32`}}, {{`load_ui8`}}."
	}

i_load_si16 :: ABCInstructionEntry
i_load_si16 =
	{ zero
	& aie_instruction = "load_si16"
	, aie_arguments   = [INT]
	, aie_description = "Take the top of the B-stack as a pointer and read a 16-bit signed integer from that pointer with the argument as offset.\n\n" +
		"See also {{`load_i}}, {{`load_si32`}}, {{`load_ui8`}}."
	}

i_load_si32 :: ABCInstructionEntry
i_load_si32 =
	{ zero
	& aie_instruction = "load_si32"
	, aie_arguments   = [INT]
	, aie_description = "Take the top of the B-stack as a pointer and read a 32-bit signed integer from that pointer with the argument as offset.\n\n" +
		"This instruction is only available on 64-bit systems. On 32-bit systems, {{`load_i`}} has the same effect.\n\n" +
		"See also {{`load_i`}}, {{`load_si16`}}, {{`load_ui8`}}."
	}

i_load_ui8 :: ABCInstructionEntry
i_load_ui8 =
	{ zero
	& aie_instruction = "load_ui8"
	, aie_arguments   = [INT]
	, aie_description = "Take the top of the B-stack as a pointer and read a 8-bit unsigned integer from that pointer with the argument as offset.\n\n" +
		"See also {{`load_i`}}, {{`load_si16`}}, {{`load_si32`}}."
	}

i_no_op :: ABCInstructionEntry
i_no_op =
	{ zero
	& aie_instruction = "no_op"
	, aie_description = "Do nothing. This is for example useful in the `cast` function:\n\n" +
		"```clean\ncast :: .a -> .b\ncast _ = code {\n\tno_op\n}\n```"
	}

d_d :: ABCInstructionEntry
d_d =
	{ zero
	& aie_instruction = ".d"
	, aie_arguments   = [INT, INT, STRING_]
	, aie_description = "Indicates how many stack elements are on the stack when a jump follows." +
		"The first integer is the number of elements on the A-stack; the second that of B-stack elements." +
		"The optional third argument indicates the type of the B-stack elements, e.g. `bbi` for two booleans and an integer."
	}

d_o :: ABCInstructionEntry
d_o =
	{ zero
	& aie_instruction = ".o"
	, aie_arguments   = [INT, INT, STRING_]
	, aie_description = "Indicates how many stack elements are 'given back' to a calling function when a {{`rtn`}} follows." +
		"The first integer is the number of elements on the A-stack; the second that of B-stack elements." +
		"The optional third argument indicates the type of the B-stack elements, e.g. `bbi` for two booleans and an integer."
	}

/**
 * Instructions without documentation yet
 */
other_instructions :: [String]
other_instructions =
	[ "absR"
	, "acosR"
	, "add_args"
	, "addI"
	, "addLU"
	, "addR"
	, "andB"
	, "and%"
	, "asinR"
	, "atanR"
	, "build"
	, "buildB"
	, "buildC"
	, "buildI"
	, "buildR"
	, "buildAC"
	, "buildB_b"
	, "buildC_b"
	, "buildF_b"
	, "buildI_b"
	, "buildR_b"
	, "buildh"
	, "build_r"
	, "build_u"
	, "catS"
	, "call"
	, "cmpS"
	, "ceilingR"
	, "CtoAC"
	, "copy_graph"
	, "cosR"
	, "code_channelP"
	, "create"
	, "create_array"
	, "create_array_"
	, "create_channel"
	, "currentP"
	, "CtoI"
	, "decI"
	, "del_args"
	, "divI"
	, "divLU"
	, "divR"
	, "divU"
	, "entierR"
	, "eqB"
	, "eqB_a"
	, "eqB_b"
	, "eqC"
	, "eqC_a"
	, "eqC_b"
	, "eqD_b"
	, "eqI"
	, "eqI_a"
	, "eqI_b"
	, "eqR"
	, "eqR_a"
	, "eqR_b"
	, "eqAC_a"
	, "eq_desc"
	, "eq_desc_b"
	, "eq_nulldesc"
	, "eq_symbol"
	, "exit_false"
	, "expR"
	, "fill"
	, "fill1"
	, "fill2"
	, "fill3"
	, "fill1_r"
	, "fill2_r"
	, "fill3_r"
	, "fillcaf"
	, "fillcp"
	, "fillcp_u"
	, "fill_u"
	, "fillh"
	, "fillB"
	, "fillB_b"
	, "fillC"
	, "fillC_b"
	, "fillF_b"
	, "fillI"
	, "fillI_b"
	, "fillR"
	, "fillR_b"
	, "fill_a"
	, "fill_r"
	, "floordivI"
	, "getWL"
	, "get_desc_arity"
	, "get_desc_flags_b"
	, "get_desc0_number"
	, "get_node_arity"
	, "gtC"
	, "gtI"
	, "gtR"
	, "gtU"
	, "in"
	, "incI"
	, "is_record"
	, "ItoC"
	, "ItoP"
	, "ItoR"
	, "jmp"
	, "jmp_ap"
	, "jmp_ap_upd"
	, "jmp_upd"
	, "jmp_eval"
	, "jmp_eval_upd"
	, "jmp_false"
	, "jmp_not_eqZ"
	, "jmp_true"
	, "jrsr"
	, "jsr"
	, "jsr_ap"
	, "jsr_eval"
	, "lnR"
	, "log10R"
	, "ltC"
	, "ltI"
	, "ltR"
	, "ltU"
	, "modI"
	, "mulI"
	, "mulR"
	, "mulUUL"
	, "negI"
	, "negR"
	, "new_ext_reducer"
	, "new_int_reducer"
	, "newP"
	, "notB"
	, "not%"
	, "orB"
	, "or%"
	, "out"
	, "pop_a"
	, "pop_b"
	, "powR"
	, "print"
	, "printD"
	, "print_char"
	, "print_int"
	, "print_real"
	, "print_r_arg"
	, "print_sc"
	, "print_symbol"
	, "print_symbol_sc"
	, "pushcaf"
	, "push_finalizers"
	, "pushA_a"
	, "pushB"
	, "pushB_a"
	, "pushC"
	, "pushC_a"
	, "pushD"
	, "pushD_a"
	, "pushF_a"
	, "pushI"
	, "pushI_a"
	, "pushL"
	, "pushLc"
	, "pushR"
	, "pushR_a"
	, "pushzs"
	, "push_a"
	, "push_b"
	, "push_a_b"
	, "push_arg"
	, "push_arg_b"
	, "push_args"
	, "push_args_u"
	, "push_array"
	, "push_arraysize"
	, "push_b_a"
	, "push_node"
	, "push_node_u"
	, "push_a_r_args"
	, "push_t_r_a"
	, "push_t_r_args"
	, "push_r_args"
	, "push_r_args_a"
	, "push_r_args_b"
	, "push_r_args_u"
	, "push_r_arg_D"
	, "push_r_arg_t"
	, "push_r_arg_u"
	, "push_wl_args"
	, "pushZ"
	, "pushZR"
	, "putWL"
	, "randomP"
	, "release"
	, "remI"
	, "remU"
	, "replace"
	, "repl_arg"
	, "repl_args"
	, "repl_args_b"
	, "repl_r_args"
	, "repl_r_args_a"
	, "rotl%"
	, "rotr%"
	, "rtn"
	, "RtoI"
	, "select"
	, "send_graph"
	, "send_request"
	, "set_continue"
	, "set_defer"
	, "set_entry"
	, "set_finalizers"
	, "setwait"
	, "shiftl%"
	, "shiftr%"
	, "shiftrU"
	, "sinR"
	, "sincosR"
	, "sliceS"
	, "sqrtR"
	, "stop_reducer"
	, "subI"
	, "subLU"
	, "addIo"
	, "mulIo"
	, "subIo"
	, "subR"
	, "suspend"
	, "tanR"
	, "testcaf"
	, "truncateR"
	, "update_a"
	, "updatepop_a"
	, "update_b"
	, "updatepop_b"
	, "updateS"
	, "update"
	, "xor%"
	, ".algtype"
	, ".caf"
	, ".code"
	, ".comp"
	, ".a"
	, ".depend"
	, ".desc"
	, ".desc0"
	, ".descn"
	, ".descexp"
	, ".descs"
	, ".end"
	, ".endinfo"
	, ".export"
	, ".keep"
	, ".inline"
	, ".impdesc"
	, ".implab"
	, ".implib"
	, ".impmod"
	, ".impobj"
	, ".module"
	, ".n"
	, ".nu"
	, ".newlocallabel"
	, ".n_string"
	, ".pb"
	, ".pd"
	, ".pe"
	, ".pl"
	, ".pld"
	, ".pn"
	, ".pt"
	, ".record"
	, ".start"
	, ".string"
	]