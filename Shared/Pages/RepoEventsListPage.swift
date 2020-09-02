//
//  RepoEventsListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/26.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage
struct RepoEventsListPage: View {
    var repo:Repo
    @EnvironmentObject var repoManager:RepoManager
    var body: some View {
        List{
            if let events = repoManager.repoEvents[repo.events_url!]{
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
        .navigationBarTitle(Text("Repo Events"))
        .onAppear{
            guard let url = repo.events_url else{return}
            repoManager.getRepoEvents(url: url)
        }
    }
}

struct RepoEventsListPage_Previews: PreviewProvider {
    static var previews: some View {
        RepoEventsListPage(repo: Repo())
    }
}
