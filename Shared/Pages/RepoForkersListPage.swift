//
//  RepoForkersListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/1.
//

import SwiftUI

struct RepoForkersListPage: View {
    var repo:Repo
    @EnvironmentObject var state:RepoManager
    var body: some View {
        ScrollView{
            if let users = state.repoForksList[repo.forks_url!]{
                ForEach(users){user in
                    VStack(alignment:.leading){
                        RemoteAvatarAndDesCell(imageName: user.owner!.avatar_url, des: user.owner!.login!)
                        Divider()
                    }
                    
                }
            }else{
                Text("No Data")
            }
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(Text("Forkers"))
        .onAppear{
            state.repoForksUserList(repo: repo)
        }
    }
}

struct RepoForkersListPage_Previews: PreviewProvider {
    static var previews: some View {
        RepoForkersListPage(repo: Repo())
    }
}
