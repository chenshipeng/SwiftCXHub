//
//  Endpoint.swift
//  SwiftCXHub
//
//  Created by chenshipeng on 2020/8/12.
//

import Foundation
public protocol Endpoint{
    func path() -> String
}
enum Auth:Endpoint {
    case auth
    func path() -> String {
        return "/authorizations"
    }
}
enum RepoEndPoint:Endpoint {
    case issues(repo:Repo)
    case branches(repo:Repo)
    case commits(repo:Repo,branch:Branch)
    func path() -> String {
        switch self {
        case .issues(let repo):
            return "/repos/\(repo.owner!.login!)/\(repo.name!)/issues"
        case .branches(let repo):
            return "/repos/\(repo.owner!.login!)/\(repo.name!)/branches"
        case .commits(let repo, let branch):
            return "/repos/\(repo.owner!.login!)/\(repo.name!)/commits?sha=\(branch.commit!.sha!)"
        }
    }
}
enum UserEndpoint:Endpoint {
    case myInfo
    case receivedEvents(username:String)
    case ifStarredRepo(owner:String,repoName:String)
    case userInfo(login:String)
    case followed(login:String)
    case following(selfLogin:String,userLogin:String)
    case usersEvents(userLogin:String)
    case orgList(userLogin:String)
    case repos(userLogin:String)
    case followers(userLogin:String)
    case followings(userLogin:String)
    func path() -> String {
        switch self {
        case .myInfo:
            return "/user"
        case .receivedEvents(let username):
            return "/users/\(username)/received_events"
        case .ifStarredRepo(let owner,let repoName):
            return "/user/starred/\(owner)/\(repoName)"
        case .userInfo(let login):
            return "/users/\(login)"
        case .followed(let login):
            return "/user/following/\(login)"
        case .following(let selfLogin, let userLogin):
            return "/users/\(selfLogin)/following/\(userLogin)"
        case .usersEvents(let userLogin):
            return "/users/\(userLogin)/events"
        case .orgList(let userLogin):
            return "/users/\(userLogin)/orgs"
        case .repos(let userLogin):
            return "/users/\(userLogin)/repos"
        case .followers(let userLogin):
            return "/users/\(userLogin)/followers"
        case .followings(let userLogin):
            return "/users/\(userLogin)/folowing"
        }
    }
}
