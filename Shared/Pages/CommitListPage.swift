//
//  CommitListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/2.
//

import SwiftUI
import struct Kingfisher.KFImage
struct CommitListPage: View {
    var repo:Repo
    var branch:Branch
    @EnvironmentObject var repoStore:RepoManager
    var body: some View {
        ScrollView{
            if let commits = repoStore.commits["\(repo.id!)\(branch.commit!.sha!)"]{
                ForEach(commits){commit in
                    VStack(){
                        HStack{
                            if let str = commit.author?.avatar_url,str.count > 0,let url = URL(string: str){
                                KFImage(url)
                                    .resizable()
                                    .frame(width:30,height:30)
                                    .cornerRadius(15)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.purple))
                                    .padding(.leading,5)
                                    .padding(.trailing,10)
                            }else{
                                Circle()
                                    .frame(width:30,height:30)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.purple))
                                    .padding(.leading,5)
                                    .padding(.trailing,10)
                            }
                            VStack(alignment:.leading){
                                Text(commit.commit?.author?.name ?? "")
                                    .font(.body)
                                    .foregroundColor(Color(UIColor.label))
                                    .padding(.bottom,5)
                                if let date = commit.commit?.author?.date{
                                    Text(timeAgoSince(date))
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                        .padding(.bottom,5)
                                }
                                Text(commit.commit?.message ?? "")
                                    .lineLimit(3)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor.secondaryLabel))
                                    .padding(.bottom,5)
                            }
                            Spacer()
                        }
                        Divider()
                    }
                }
            }else{
                Text("Loading")
            }
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(Text("Commits"))
        .onAppear{
            repoStore.commits(repo: repo, branch: branch)
        }
    }
}
