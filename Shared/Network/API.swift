//
//  File.swift
//  SwiftCXHub
//
//  Created by chenshipeng on 2020/8/12.
//

import Foundation
import Alamofire
import SwifterSwift
import Combine
import SwiftUI
public class API {
    static public let shared = API()
    static public let BaseURL = "https://api.github.com"
    
    
    private let decoder:JSONDecoder
    
    private var userHeaderCancellable:AnyCancellable?
    private var disposeBags:[AnyCancellable?] = []
    private var headers:HTTPHeaders?
    init() {
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let cancellable = AuthClient.shared.$headers.sink{headers in
            self.headers = headers
        }
        disposeBags.append(cancellable)
    }
    
    public func request<T:Codable>(endpoint:Endpoint,httpMethod:HTTPMethod = .get,params:[String:Any]?) -> AnyPublisher<T,AFError>{
        print("headers are \(String(describing: self.headers)),url is \(API.BaseURL + endpoint.path())")
        return AF.request(URL(string: API.BaseURL + endpoint.path())!,method: httpMethod,parameters: params, encoding: httpMethod == HTTPMethod.post ? JSONEncoding.default : URLEncoding.queryString,headers: self.headers)
            .responseJSON{json in
                switch json.result{
                case .success(let json):
                    print("json is \(json)")
                case .failure(let error):
                    print("error is \(error),code \(String(describing: error.responseCode))")
                }
            }
            .publishDecodable(type: T.self,decoder: decoder).value()
            .eraseToAnyPublisher()
    }
    public func request<T:Codable>(url:String,httpMethod:HTTPMethod = .post,params:[String:Any]?) -> AnyPublisher<T,AFError>{
        return AF.request(URL(string: url)!,method: httpMethod,parameters: params, encoding: httpMethod == HTTPMethod.post ? JSONEncoding.default : URLEncoding.queryString,headers: self.headers)
            .responseJSON{json in
                switch json.result{
                case .success(let json):
                    print("json is \(json)")
                case .failure(let error):
                    print("error is \(error),code \(String(describing: error.responseCode))")
                }
            }
            .publishDecodable(type: T.self,decoder: decoder).value()
            .eraseToAnyPublisher()
    }
    public func request(endpoint:Endpoint,httpMethod:HTTPMethod = .post,params:[String:Any]?) -> AnyPublisher<Bool,AFError>{
        print("headers are \(String(describing: self.headers)),url is \(API.BaseURL + endpoint.path())")
        let subject = PassthroughSubject<Bool,AFError>()
        let cancellable = AF.request(URL(string: API.BaseURL + endpoint.path())!,method: httpMethod,parameters: params, encoding: httpMethod == HTTPMethod.post ? JSONEncoding.default : URLEncoding.queryString,headers: self.headers)
            .publishData().sink{data in
                print("status code is \(data.response?.statusCode)")
                guard let data = data.response?.statusCode else {return subject.send(false)}
                subject.send(data == 204)
            }
        disposeBags.append(cancellable)
        return subject.eraseToAnyPublisher()
    }
}
public struct AuthModel:Codable {
    let token:String
    let id:Int
    let url:String
    let scopes:[String]
    let token_last_eight:String
    let hashed_token:String
    let note:String?
    let note_url:String?
}
