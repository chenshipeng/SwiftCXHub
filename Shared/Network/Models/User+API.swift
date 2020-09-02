//
//  UserModel.swift
//  SwiftCXHub
//
//  Created by chenshipeng on 2020/8/12.
//

import Foundation
import Combine
import Alamofire
extension User{
    static public func authorization()->AnyPublisher<AuthModel?,AFError>{
        let params = ["client_id":"d67855104c8fb56c68e0",
                      "client_secret":"8ea0db7827776e711f65e6520f59b4a4c080af6d",
                      "scopes": ["user", "repo", "gist", "notifications"],
                      "note": "admin_script"] as [String : Any]
        return API.shared.request(endpoint: Auth.auth,httpMethod: .post, params: params)
    }
    static public func fetchMe()->AnyPublisher<User,AFError>{
        return API.shared.request(endpoint: UserEndpoint.myInfo,httpMethod: .get, params: nil)
    }
    static public func userEvents(username:String,page:Int) -> AnyPublisher<[UserEvent],AFError>{
        return API.shared.request(endpoint: UserEndpoint.receivedEvents(username: username), httpMethod: .get, params: ["page":page])
    }
    static public func checkIfStarredRepo(owner:String,repoName:String,method:HTTPMethod) -> AnyPublisher<Bool,AFError>{
        return API.shared.request(endpoint: UserEndpoint.ifStarredRepo(owner: owner, repoName: repoName),httpMethod: method, params: nil)
    }
    static public func getUserInfo(login:String) -> AnyPublisher<User,AFError>{
        return API.shared.request(endpoint: UserEndpoint.userInfo(login: login), params: nil)
    }
    static public func follow(login:String,method:HTTPMethod) -> AnyPublisher<Bool,AFError>{
        return API.shared.request(endpoint: UserEndpoint.followed(login: login),httpMethod: method, params: nil)
    }
    static public func checkIfFollowing(selfLogin:String,userLogin:String) -> AnyPublisher<Bool,AFError>{
        return API.shared.request(endpoint: UserEndpoint.following(selfLogin: selfLogin, userLogin: userLogin),httpMethod: .get, params: nil)
    }
    static public func userEvents(userLogin:String) -> AnyPublisher<[UserEvent],AFError>{
        return API.shared.request(endpoint: UserEndpoint.usersEvents(userLogin: userLogin), params: ["page":1])
    }
    static public func orgList(userLogin:String) -> AnyPublisher<[Org],AFError>{
        return API.shared.request(endpoint: UserEndpoint.orgList(userLogin: userLogin), params: nil)
    }
    static public func repos(userLogin:String) -> AnyPublisher<[Repo],AFError>{
        return API.shared.request(endpoint: UserEndpoint.repos(userLogin: userLogin), params: nil)
    }
    
    static public func followers(userLogin:String) -> AnyPublisher<[Owner],AFError>{
        return API.shared.request(endpoint: UserEndpoint.followers(userLogin: userLogin), params: nil)
    }
    static public func followings(userLogin:String) -> AnyPublisher<[Owner],AFError>{
        return API.shared.request(endpoint: UserEndpoint.followings(userLogin: userLogin), params: nil)
    }
}
