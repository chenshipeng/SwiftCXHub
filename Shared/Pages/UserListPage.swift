//
//  UserListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/1.
//

import SwiftUI
enum UserListType:String {
    case stars,forks,watchers
}
struct UserListPage: View {
    var repo:Repo
    var listType:UserListType
    
    @EnvironmentObject var state:RepoManager
    
    var body: some View {
        ScrollView{
            if listType == .stars,let starUrl = repo.stargazers_url,let users = state.repoStarUserList[starUrl]{
                ForEach(users){user in
                    NavigationLink(destination:OwnerHomePage(loginName: user.login!)){
                        RemoteAvatarAndDesCell(imageName: user.avatar_url, des: user.login!)
                        Divider()
                    }
                }
            }else if listType == .watchers,let watchUrl = repo.subscribers_url,let users = state.repoWatchersList[watchUrl]{
                ForEach(users){user in
                    NavigationLink(destination:OwnerHomePage(loginName: user.login!)){
                        RemoteAvatarAndDesCell(imageName: user.avatar_url, des: user.login!)
                        Divider()
                    }
                }
            }else if listType == .forks,let forkUrl = repo.forks_url,let users = state.repoForksList[forkUrl]{
                ForEach(users){user in
                    VStack{
                        NavigationLink(destination:OwnerHomePage(loginName: user.owner!.login!)){
                            RemoteAvatarAndDesCell(imageName: user.owner!.avatar_url, des: user.owner!.login!)
                            Divider()
                            
                        }
                        
                    }
                    
                }
            }else{
                Text("No Data")
            }
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(listType.rawValue)
        .onAppear{
            if listType == .stars{
                state.repoStarsUserList(repo: repo)
            }else if listType == .forks{
                state.repoForksUserList(repo: repo)
            }else if listType == .watchers{
                state.repoWatchersUserList(repo: repo)
            }
        }
    }
}

struct UserListPage_Previews: PreviewProvider {
    static var previews: some View {
        UserListPage(repo: Repo(), listType: .stars)
    }
}
