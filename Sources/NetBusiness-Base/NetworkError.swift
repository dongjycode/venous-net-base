//
//  File.swift
//
//
//  Created by jdq on 2022/9/1.
//

import Foundation

public struct NetWorkError: Error {
    public var code: Int?
    public var message: String?

    public init(code: Int? = nil, message: String? = nil) {
        self.code = code
        self.message = message
    }
}
