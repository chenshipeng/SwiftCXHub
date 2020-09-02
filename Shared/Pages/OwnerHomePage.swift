//
//  OwnerHomePage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/21.
//

import SwiftUI

struct OwnerHomePage: View {
    var loginName:String
    @EnvironmentObject var userStore:CurrentUserStore
    var body: some View {
        ScrollView{
            if let user = userStore.users[loginName]{
                UserHeader(user: user)
                SectionHeader()
                VStack(alignment:.leading){
                    NavigationLink(destination:UserEventsListPage(login: loginName)){
                        AvatarAndDesCell(imageName: "events", des: "Events")
                            .padding(.leading,10)
                    }
                    NavigationLink(destination:OrgListPage(login: loginName)){
                        AvatarAndDesCell(imageName: "organization", des: "Organizations")
                    }
                    NavigationLink(destination:RepoListPage(login: loginName)){
                        AvatarAndDesCell(imageName: "repository", des: "Repositories")
                    }
                }
                Spacer()
                
            }
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(Text(loginName))
        .navigationBarItems(trailing: followButton())
        .onAppear{
            userStore.getUserInfo(login: loginName)
        }
    }
    private func followButton() -> some View {
        if let followed = userStore.usersFollowed[loginName]{
           return  Button(action:{
                print("clicked follow")
            userStore.follow(login: loginName, method: followed ? .delete : .put)
            }){
                Text(followed ? "unFollow" : "Follow")
            }
        }else{
            return Button(action:{
                
            }){
                Text("")
            }
            
        }
        
    }
}

struct OwnerHomePage_Previews: PreviewProvider {
    static var previews: some View {
        OwnerHomePage(loginName: "chenshipeng")
    }
}
