//
//  BooleanNode.swift
//  Lioness
//
//  Created by Louis D'hauwe on 15/10/2016.
//  Copyright © 2016 Silver Fox. All rights reserved.
//

import Foundation

public class BooleanNode: ASTNode {
	
	/// Either 0 (false) or 1 (true)
	public let value: UInt8
	
	public var boolValue: Bool {
		return value == 1
	}
	
	public init?(value: UInt8) {
		
		if value != 0 && value != 1 {
			return nil
		}
		
		self.value = value
	}
	
	public init(bool: Bool) {
		
		if bool == true {
			
			self.value = 1

		} else {
			
			self.value = 0

		}
		
	}
	
	public override func compile(with ctx: BytecodeCompiler) throws -> BytecodeBody {
		
		let i = self.value
		let label = ctx.nextIndexLabel()
		return [BytecodeInstruction(label: label, type: .pushConst, arguments: ["\(i)"])]
		
	}
	
	public override var description: String {
		return "BooleanNode(\(value))"
	}
	
	public override var nodeDescription: String? {
		if boolValue == true {
			return "true"
		} else {
			return "false"
		}
	}
	
	public override var childNodes: [ASTChildNode] {
		return []
	}
	
}
