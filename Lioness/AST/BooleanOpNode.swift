//
//  BooleanOpNode.swift
//  Lioness
//
//  Created by Louis D'hauwe on 15/10/2016.
//  Copyright © 2016 Silver Fox. All rights reserved.
//

import Foundation

public class BooleanOpNode: ASTNode {
	
	public let op: String
	public let lhs: ASTNode
	
	/// Can be nil, e.g. for 'not' operation
	public let rhs: ASTNode?
	
	public init(op: String, lhs: ASTNode, rhs: ASTNode? = nil) {
		self.op = op
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public override func compile(with ctx: BytecodeCompiler) throws -> BytecodeBody {
		
		let l = try lhs.compile(with: ctx)
		let r = try rhs?.compile(with: ctx)
		
		var bytecode = BytecodeBody()
		
		bytecode.append(contentsOf: l)
		
		if let r = r {
			bytecode.append(contentsOf: r)
		}
		
		let label = ctx.nextIndexLabel()
		
		var opTypes: [String : BytecodeInstructionType]
		
		opTypes = ["&&" : .and,
		           "||" : .or,
		           "==": .eq,
		           "!=": .neq,
		           "!" : .not]
		
		guard let type = opTypes[op] else {
			throw CompileError.unexpectedCommand
		}
		
		let operation = BytecodeInstruction(label: label, type: type)
		
		bytecode.append(operation)
		
		return bytecode
		
	}
	
	public override var description: String {
		if let rhs = rhs {
			return "BooleanOpNode(\(op), lhs: \(lhs), rhs: \(rhs))"
		}
		
		return "BooleanOpNode(\(op), lhs: \(lhs)"
	}
	
	public override var nodeDescription: String? {
		return op
	}
	
	public override var childNodes: [ASTChildNode] {
		
		var children: [ASTChildNode]  = [ASTChildNode(connectionToParent: "lhs", node: lhs)]
		
		if let rhs = rhs {
			children.append(ASTChildNode(connectionToParent: "rhs", node: rhs))
		}
		
		return children
	}
	
}
