//
//  UserEventsListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/26.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage
struct UserEventsListPage: View {
    var login:String
    @EnvironmentObject var userStore:CurrentUserStore
    var body: some View {
        List{
            if let events = userStore.userEvents[login]{
                ForEach(events){event in
                    NavigationLink(destination:RepoDetailPage(repoUrl: event.repo!.url!)){
                        VStack{
                            makeUserEventCell(event)
                                .padding()
                        }
                    }
                }
            }
        }
        .background(Color.clear)
        .animation(.interactiveSpring())
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text("User Events"))
        .onAppear{
            userStore.userEvents(username: login)
        }
    }
}

struct UserEventsListPage_Previews: PreviewProvider {
    static var previews: some View {
        UserEventsListPage(login: "chenshipeng")
    }
}
