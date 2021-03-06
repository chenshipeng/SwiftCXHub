//
//  Trending.swift
//  CXHub
//
//  Created by 陈仕鹏 on 2018/9/20.
//  Copyright © 2018 csp. All rights reserved.
//

import Foundation
public struct Trending: Codable,Identifiable,Hashable {
    var pulls_url: String?
    var subscribers_url: String?
    var tags_url: String?
    var open_issues: String?
    var has_projects: Bool?
    var clone_url: String?
    var size: String?
    var git_url: String?
    var git_tags_url: String?
    var subscribers_count: Int?
    public var id: String?
    var default_branch: String?
    var author:String?
    var avatar:String?
    var issue_events_url: String?
    var archived: Bool?
    var downloads_url: String?
    var comments_url: String?
    var homepage: String?
    var teams_url: String?
    var url: String?
    var has_pages: Bool?
    var hooks_url: String?
    var html_url: String?
    var issues_url: String?
    var full_name: String?
    var fork: Bool?
    var description: String?
//    var license: License?
    var notifications_url: String?
    var ssh_url: String?
    var stargazers_count: String?
    var issue_comment_url: String?
    var compare_url: String?
    var languages_url: String?
    var watchers: String?
    var milestones_url: String?
    var branches_url: String?
    var collaborators_url: String?
    var has_issues: Bool?
    var network_count: String?
    var archive_url: String?
    var created_at: String?
    var forks: Int?
    var stars:Int?
    var open_issues_count: String?
    var assignees_url: String?
    var labels_url: String?
    var forks_count: String?
    var events_url: String?
    var blobs_url: String?
    var has_downloads: Bool?
    var svn_url: String?
    var forks_url: String?
    var `private`: Bool?
    var releases_url: String?
    var language: String?
    var languageColor:String?
    var pushed_at: String?
    var contents_url: String?
    var statuses_url: String?
//    var owner: Owner?
    var git_refs_url: String?
    var stargazers_url: String?
    var name: String?
    var contributors_url: String?
    var updated_at: String?
    var subscription_url: String?
    var trees_url: String?
    var keys_url: String?
    var has_wiki: Bool?
    var git_commits_url: String?
    var commits_url: String?
    var watchers_count: String?
//    var organization: Owner?
    var deployments_url: String?
    var merges_url: String?
    var node_id: String?
    var builtBy:[BuiltBy]?
    public static func == (lhs: Trending, rhs: Trending) -> Bool {
        return lhs.url == rhs.url
    }
    public func hash(into hasher: inout Hasher) {
        
    }
}
extension Trending{
    static func staticTrending()->Trending{
        var trending = Trending()
        trending.name = "AltStore"
        trending.description = "AltStore is an alternative app store for non-jailbroken iOS devices."
        trending.url = "https://github.com/rileytestut/AltStore"
        trending.stars = 3036
        trending.languageColor = "#ffac45"
        trending.forks = 273
        trending.language = "Swift"
        trending.avatar = "https://github.com/rileytestut.png"
        trending.author = "rileytestut"
        return trending
    }
}
public struct BuiltBy:Codable{
    public var avatar:String?
    public var href:String?
    public var username:String?
}
