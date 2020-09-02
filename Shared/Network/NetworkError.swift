//
//  NetworkError.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/13.
//

import Foundation
import Combine
import Alamofire
public enum NetworkError :Error {
    case unknown(data:Data)
    case message(reason:String,data:Data)
    case parseError(reason:Error)
    case cxhubError(error:CXHubError,data:Data)
    
    
    static private let decoder = JSONDecoder()
    
    static func processResponse(data:Data,response:URLResponse) throws -> Data{
        guard let response = response as? HTTPURLResponse else {throw NetworkError.unknown(data: data)}
        
        if response.statusCode == 404{
            throw NetworkError.message(reason: "Resource not found", data: data)
        }
        if 200 ... 299 ~= response.statusCode{
            return data
        }else{
            do {
                let error = try decoder.decode(CXHubError.self, from: data)
                throw NetworkError.cxhubError(error: error, data: data)
            } catch _ {
                throw NetworkError.unknown(data: data)
            }
        }
        
    }
}
public struct CXHubError:Decodable{
    public let message:String?
    public let ducomentUrl:String?
    static public func processNetworkError(error:NetworkError) -> CXHubError{
        switch error {
        case let .cxhubError(error: error, data: _):
            return error
        default:
            return CXHubError(message: "Unknown error", ducomentUrl: "")
        }
    }
}
