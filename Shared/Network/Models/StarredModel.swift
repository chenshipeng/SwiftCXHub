//
//  StarredModel.swift
//  ManageYourStars
//
//  Created by 陈仕鹏 on 2017/8/31.
//  Copyright © 2017年 csp. All rights reserved.
//

import Foundation
public struct StarredModel:Codable,Identifiable {
    var pulls_url: String?
    var subscribers_url: String?
    var tags_url: String?
    var open_issues: Int?
    var has_projects: Bool?
    var clone_url: String?
    var size: Int?
    var git_url: String?
    var git_tags_url: String?
    public var id: Int?
    var default_branch: String?
    var issue_events_url: String?
//    var mirror_url: Any?
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
    var license: License?
    var notifications_url: String?
    var ssh_url: String?
    var stargazers_count: Int?
    var issue_comment_url: String?
    var compare_url: String?
    var languages_url: String?
    var watchers: Int?
    var milestones_url: String?
    var branches_url: String?
    var collaborators_url: String?
    var has_issues: Bool?
    var archive_url: String?
    var forks: Int?
    var created_at: String?
    var assignees_url: String?
    var open_issues_count: Int?
    var labels_url: String?
    var forks_count: Int?
    var events_url: String?
    var blobs_url: String?
    var has_downloads: Bool?
    var svn_url: String?
    var forks_url: String?
    var `private`: Bool?
    var releases_url: String?
    var language: String?
    var pushed_at: String?
    var contents_url: String?
    var statuses_url: String?
    var owner: Owner?
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
    var watchers_count: Int?
    var deployments_url: String?
    var merges_url: String?
    var node_id: String?
    
}
