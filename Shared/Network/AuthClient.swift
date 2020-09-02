//
//  AuthClient.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/13.
//

import Foundation
import KeychainAccess
import Combine
import SwiftUI
import Alamofire
public class AuthClient:ObservableObject,PersistentDataStore{
    
    public enum State:Equatable{
        case unknown,signnedOut,signInProgress
        case authenthicated(authToken:String)
    }
    
    static public let shared = AuthClient()
    
    private let keychainService = "com.csp.SwiftCXHub"
    private let keychainAuthTokenKey = "auth_token"
    private let keychainAuthEmailKey = "auth_email"
    private let keychainAuthPwdKey = "auth_password"
    @Published public var authStatus = State.unknown
    @Published public var email:String = ""
    @Published public var password:String = ""
    @Published public var headers:HTTPHeaders?
    @EnvironmentObject private var uiState:UIState
    
    let persistentedDataFileName: String = "UserData"
    typealias DataType = User
    
    private var disposeBag:[AnyCancellable] = []
    
    init() {
        let keychain = Keychain(service: keychainService)
        if let token = keychain[keychainAuthTokenKey]{//已经有了token
            authStatus = .authenthicated(authToken: token)
        }else{
            authStatus = .signnedOut
        }
        if let email = keychain[keychainAuthEmailKey]{//钥匙串中有username
            self.email = email
        }
        if let password = keychain[keychainAuthPwdKey]{//钥匙串中有password
            self.password = password
        }
        
        //状态编程signInProgress的时候重置headers，认证
        let cancallable = $authStatus.sink{canAuth in
            switch canAuth{
            case .signInProgress:
                //进行auth
                self.httpHeaders(username: self.email, password: self.password)
                self.makeAuthPublisher()
            default:
                break
            }
        }
        disposeBag.append(cancallable)
        
        
        ///根据email和password来确定headers
        self.httpHeaders(username: self.email, password: self.password)

    }
    public func httpHeaders(username:String,password:String){
        if !username.isEmpty,!password.isEmpty{
            let headers:HTTPHeaders = [
                .authorization(username: username, password: password),
                .contentType("application/json"),.accept("application/vnd.github.v3+json")
            ]
            self.headers = headers
        }
    }
    /// logout
    public func logout(){
        authStatus = .signnedOut
        let keychain = Keychain(service: keychainService)
        keychain[keychainAuthTokenKey] = nil
        keychain[keychainAuthEmailKey] = nil
        keychain[keychainAuthPwdKey] = nil
    }
    
    /// make auth
    public func makeAuthPublisher(){
        let cancelable = User.authorization()
            .sink(receiveCompletion: {error in
                if case .failure(let err) = error{
                    print("auth error is \(err.localizedDescription)")
                }else{
                    print("auth finished")
                }
            }, receiveValue: {model in
                if model != nil{//auth成功，得到值,获取个人信息
                    self.authStatus = .authenthicated(authToken: model!.token)
                    let keychain = Keychain(service: self.keychainService)
                    keychain[self.keychainAuthTokenKey] = model!.token
                    keychain[self.keychainAuthEmailKey] = self.email
                    keychain[self.keychainAuthPwdKey] = self.password
                }
                print("model is \(model.debugDescription)")
            })
        disposeBag.append(cancelable)
    }
    
    
}
