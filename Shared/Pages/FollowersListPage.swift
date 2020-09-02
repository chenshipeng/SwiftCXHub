//
//  FollowersListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/2.
//

import SwiftUI

struct FollowersListPage: View {
    var login:String
    
    @EnvironmentObject var userStore:CurrentUserStore
    var body: some View {
        ScrollView{
            if  let users = userStore.followers[login]{
                ForEach(users){user in
                    NavigationLink(destination:OwnerHomePage(loginName: user.login!)){
                        RemoteAvatarAndDesCell(imageName: user.avatar_url, des: user.login!)
                        Divider()
                    }
                }
            }else{
                Text("Loading")
            }
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(Text("Followers"))
        .onAppear{
            userStore.followers(login: login)
        }
    }
}

struct FollowersListPage_Previews: PreviewProvider {
    static var previews: some View {
        FollowersListPage(login: "chenshipeng")
    }
}
