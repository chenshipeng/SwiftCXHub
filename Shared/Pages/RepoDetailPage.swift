//
//  RepoDetailPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/20.
//

import SwiftUI
import struct Kingfisher.KFImage
struct RepoDetailPage: View {
    var repoUrl:String
    @EnvironmentObject var repoManager:RepoManager
    var body: some View {
        ScrollView{
            if let repo = repoManager.repoDetails[repoUrl]{
                RepoHeader(repo: repo)
                SectionHeader()
                VStack(alignment:.leading){
                    NavigationLink(destination:OwnerHomePage(loginName: repo.owner!.login!)){
                        AvatarAndDesCell(imageName: "owner", des: "Owner")
                    }
                    SectionHeader()
                }.padding(.leading,10)
                
                VStack(alignment:.leading){
                    NavigationLink(destination:RepoEventsListPage(repo: repo)){
                        AvatarAndDesCell(imageName: "events", des: "Events")
                    }
                    Divider()
                    NavigationLink(destination:RepoIssuesPage(repo: repo)){
                        AvatarAndDesCell(imageName: "issue_icon", des: "Issues")
                    }
                    Divider()
                    AvatarAndDesCell(imageName: "readme", des: "Readme")
                    SectionHeader()
                }.padding(.leading,10)
                VStack(alignment:.leading){
                    NavigationLink(destination:BranchListPage(repo: repo)){
                        AvatarAndDesCell(imageName: "commit", des: "Commits")
                    }
                    Divider()
                }.padding(.leading,10)
                
            }
        }
        .animation(.interactiveSpring())
        .navigationBarTitle("Repo Detail")
        .navigationBarItems(trailing: starButton())
        .onAppear{
            repoManager.getRepoInfo(url: repoUrl)
        }
    }
    private func starButton() -> some View {
        if let starred = repoManager.repoStarred[repoUrl]{
           return  Button(action:{
                print("clicked star")
            let repo = repoManager.repoDetails[repoUrl]!
            repoManager.starRepo(owner: repo.owner!.login!, repoName: repo.name!, repoUrl: repoUrl, method: starred ? .delete : .put)
            }){
                Text(starred ? "unStar" : "Star")
            }
        }else{
            return Button(action:{
                
            }){
                Text("")
            }
            
        }
        
    }
}

struct RepoDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailPage(repoUrl: "")
    }
}
