//
//  RepoListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/27.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage
struct RepoListPage: View {
    let login:String
    @EnvironmentObject var userStore:CurrentUserStore
    fileprivate func repoCell(_ repo: Repo) -> some View {
        return VStack(alignment:.leading){
            HStack{
                if let urlString = repo.owner?.avatar_url,let url = URL(string: urlString){
                    KFImage(url)
                        .resizable()
                        .frame(width:60,height:60)
                        .cornerRadius(30)
                        .background(RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.purple))
                }
                Text(repo.owner?.login ?? "")
                    .foregroundColor(.primary)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing,10)
            }
            .frame(height:44)
        }
    }
    
    var body: some View {
        ScrollView{
            List{
                if let repos = userStore.repos[login]{
                    ForEach(repos,id:\.self){repo in
                        Text(repo.description ?? "")
                    }
                }
            }.background(Color.clear)
            .animation(.interactiveSpring())
            .listStyle(InsetGroupedListStyle())
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(Text(login))
        .onAppear{
            userStore.repos(login: login)
        }
    }
}

struct RepoListPage_Previews: PreviewProvider {
    static var previews: some View {
        RepoListPage(login: "chenshipeng")
    }
}
