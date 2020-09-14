//
//  MyRepoListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/14.
//

import SwiftUI
import struct Kingfisher.KFImage
struct MyRepoListPage: View {
    @EnvironmentObject var userStore:CurrentUserStore
    private func textV(repo:Repo) -> some View{
        VStack{
            HStack{
                Text(repo.name ?? "")
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .accessibility(sortPriority: 1)
                Spacer()
                Text("Stars:\(repo.stargazers_count ?? 0)")
                    .fontWeight(.light)
                    .lineLimit(1)
                    .accessibility(sortPriority: 2)
            }
            HStack{
                Text(repo.owner?.login ?? "")
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .accessibility(sortPriority: 1)
                Spacer()
                Text("Lan:\(repo.language ?? "")")
                    .fontWeight(.light)
                    .lineLimit(1)
                    .accessibility(sortPriority: 2)
            }
            Text(repo.description ?? "")
                .lineLimit(3)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
    }
    var body: some View {
        NavigationView{
            List{
                if userStore.myRepos.count > 0{
                    ForEach(userStore.myRepos){repo in
                        NavigationLink(destination:RepoDetailPage(repoUrl: repo.url!)){
                            VStack{
                                HStack{
                                    if let avatar = repo.owner?.avatar_url,let url = URL(string: avatar){
                                        KFImage(url)
                                            .resizable()
                                            .frame(width:60,height:60)
                                            .clipShape(Circle())
                                    }else{
                                        Circle()
                                            .frame(width:60,height:60)
                                            .background(RoundedRectangle(cornerRadius: 30)
                                                            .stroke(Color.purple))
                                    }
                                    textV(repo: repo)
                                    
                                }
                            }
                            .padding(.all)
                        }
                    }
                }
            }
            .background(Color.clear)
            .animation(.interactiveSpring())
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("My Repos"))
            .onAppear{
                userStore.getMyRepos()
            }
        }
    }
}

struct MyRepoListPage_Previews: PreviewProvider {
    static var previews: some View {
        MyRepoListPage()
    }
}
