//
//  BytecodeExecutionInstruction.swift
//  Lioness
//
//  Created by Louis D'hauwe on 08/02/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation

public extension BytecodeInstruction {

	var executionInstruction: BytecodeExecutionInstruction {
		return BytecodeExecutionInstruction(label: label, type: type, arguments: arguments)
	}

}

/// ```BytecodeExecutionInstruction``` is a simplified version of ```BytecodeInstruction```,
/// in that it has no string members, and is a struct.
/// This eliminates reference counting which leads to improved performance.
public struct BytecodeExecutionInstruction {

	let label: Int

	let type: BytecodeInstructionType

	let arguments: [InstructionArgumentType]

	init(label: Int, type: BytecodeInstructionType, arguments: [InstructionArgumentType] = []) {
		self.label = label
		self.type = type
		self.arguments = arguments
	}

}
