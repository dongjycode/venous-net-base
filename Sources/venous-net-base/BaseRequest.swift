//
//  File.swift
//
//
//  Created by jdq on 2022/9/1.
//

import Alamofire
import Foundation

public struct BaseRequest {
   public static func request<T: Codable, K: Encodable>(url: URLConvertible, headers: HTTPHeaders? = nil, parameters: K?, decodable: T) async -> Result<T, NetWorkError> {
        if NetworkReachabilityManager.default?.status == .notReachable {
            return .failure(.init(code: -989898, message: ErrorCodeDesc.parser(-989898)))
        }
        let result = await AF.request(url,
                                      method: .post,
                                      parameters: parameters,
                                      encoder: JSONParameterEncoder.default,
                                      headers: headers,
                                      interceptor: nil,
                                      requestModifier: nil).serializingDecodable(T.self).response
        guard let res = result.value else {
            return .failure(NetWorkError(code: -1, message: "request error"))
        }
        return .success(res)
    }

    static func retCodeHandler(retCode: Int?) -> NetWorkError? {
        guard retCode != 0 else { return nil }
        return NetWorkError(code: retCode, message: ErrorCodeDesc.parser(retCode))
    }
}

public struct BaseResponse: Codable {
    var action: String?
    var retCode: Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case action = "Action"
        case retCode = "RetCode"
        case message = "Message"
    }
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.action = try container.decodeIfPresent(String.self, forKey: .action)
        self.retCode = try container.decodeIfPresent(Int.self, forKey: .retCode)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.action, forKey: .action)
        try container.encodeIfPresent(self.retCode, forKey: .retCode)
        try container.encodeIfPresent(self.message, forKey: .message)
    }
}
