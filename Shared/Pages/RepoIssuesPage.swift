//
//  RepoIssuesPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/2.
//

import SwiftUI
import SwifterSwift
import Foundation
struct RepoIssuesPage: View {
    var repo:Repo
    @EnvironmentObject var repoStore:RepoManager
    var body: some View {
        ScrollView{
            if let issues = repoStore.issuesList[repo.id!]{
                ForEach(issues){issue in
                    VStack(alignment:.leading){
                        HStack{
                            Text("#\(issue.number!)")
                                .font(.system(size: 15))
                                .foregroundColor(.red)
                                .padding()
                            VStack(alignment:.leading){
                                Text(issue.title ?? "")
                                    .lineLimit(3)
                                    .font(.caption)
                                    .foregroundColor(Color(UIColor.label))
                                    .padding()
                                HStack{
                                    Image(systemName:"gear")
                                        .frame(width:10,height:10)
                                    Text(issue.state ?? "")
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)
                                        .padding(.leading,2)
                                        .padding(.trailing,40)
                                    
                                    Image(systemName:"clock")
                                        .frame(width:10,height:10)
                                    Text(timeAgoSince(issue.updated_at!))
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)
                                        .padding(.leading,2)
                                }
                            }
                        }
                        Divider()
                    }
                }
            }else{
                Text("Loading")
            }
        }.animation(.interactiveSpring())
        .navigationBarTitle(Text("Issues"))
        .onAppear{
            repoStore.issues(repo: repo)
        }
    }
}
public func timeAgoSince(_ date: Date) -> String {
    
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    
    if let year = components.year, year >= 2 {
        return "\(year) years ago"
    }
    
    if let year = components.year, year >= 1 {
        return "Last year"
    }
    
    if let month = components.month, month >= 2 {
        return "\(month) months ago"
    }
    
    if let month = components.month, month >= 1 {
        return "Last month"
    }
    
    if let week = components.weekOfYear, week >= 2 {
        return "\(week) weeks ago"
    }
    
    if let week = components.weekOfYear, week >= 1 {
        return "Last week"
    }
    
    if let day = components.day, day >= 2 {
        return "\(day) days ago"
    }
    
    if let day = components.day, day >= 1 {
        return "Yesterday"
    }
    
    if let hour = components.hour, hour >= 2 {
        return "\(hour) hours ago"
    }
    
    if let hour = components.hour, hour >= 1 {
        return "An hour ago"
    }
    
    if let minute = components.minute, minute >= 2 {
        return "\(minute) minutes ago"
    }
    
    if let minute = components.minute, minute >= 1 {
        return "A minute ago"
    }
    
    if let second = components.second, second >= 3 {
        return "\(second) seconds ago"
    }
    
    return "Just now"
    
}
struct RepoIssuesPage_Previews: PreviewProvider {
    static var previews: some View {
        RepoIssuesPage(repo: Repo())
    }
}
