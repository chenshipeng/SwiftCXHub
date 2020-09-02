//
//  Branch.swift
//  ManageYourStars
//
//  Created by 陈仕鹏 on 2018/9/13.
//  Copyright © 2018 csp. All rights reserved.
//

import UIKit
public struct Branch: Codable,Identifiable {
    public var id = UUID()
    var name:String?
    var commit:Commit?
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case commit
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        commit = try container.decode(Commit.self, forKey: .commit)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(commit, forKey: .commit)
        try container.encode(id, forKey: .id)
    }
}
