//
//  UserStoreModel.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/10.
//

import Foundation
struct UserStoreModel:Codable {
    var user:User?
    var userEvents:[String:[UserEvent]]?
    var orgList:[String:[Org]]?
    var repos:[String:[Repo]]?
    var trendings:[String:[Trending]]?
}
