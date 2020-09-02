//
//  User.swift
//  SwiftCXHub
//
//  Created by chenshipeng on 2020/8/12.
//

import Foundation
public struct User:Codable,Identifiable {
    var public_repos:Int?
    var organizations_url:String?
    var repos_url:String?
    var starred_url:String?
    var type:String?
    var bio:String?
    var gists_url:String?
    var followers_url:String?
    public var id:Int?
    var blog:String?
    var followers:Int?
    var following:Int?
    var company:String?
    var url:String?
    var name:String?
    var updated_at:String?
    var public_gists:Int?
//    var site_admin:Int?
    var email:String?
    var gravatar_id:String?
    var html_url:String?
    var avatar_url:String?
    var login:String?
    var location:String?
    var created_at:String?
    var subscriptions_url:String?
    var following_url:String?
    var received_events_url:String?
    var events_url:String?
//    var hireable:Int?
}
