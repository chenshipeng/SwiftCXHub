//
//  Issue.swift
//  ManageYourStars
//
//  Created by 陈仕鹏 on 2018/9/6.
//  Copyright © 2018 csp. All rights reserved.
//

import UIKit
public struct Issue: Codable ,Identifiable{
    var state: String?
//    var labels: [Any]?
    var user: User?
    var updated_at: Date?
    var node_id: String?
    var body: String?
//    var closed_at: Any?
    var html_url: String?
    var locked: Bool?
    var number: Int?
    var author_association: String?
//    var assignees: [Any]?
//    var milestone: Any?
    var labels_url: String?
    public var id: Int?
    var created_at: Date?
    var comments: Int?
    var title: String?
    var comments_url: String?
//    var assignee: Any?
    var events_url: String?
    var url: String?
    var repository_url: String?
}
