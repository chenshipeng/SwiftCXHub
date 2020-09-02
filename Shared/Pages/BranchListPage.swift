//
//  BranchListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/2.
//

import SwiftUI

struct BranchListPage: View {
    var repo:Repo
    @EnvironmentObject var repoStore:RepoManager
    var body: some View {
        ScrollView{
            if let branches = repoStore.repoBranches[repo.id!]{
                ForEach(branches){branch in
                    NavigationLink(destination:CommitListPage(repo: repo, branch: branch)){
                        HStack{
                            Text(branch.name ?? "")
                                .font(.system(size: 15))
                                .padding()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing,10)
                        }
                        .frame(height:44)
                    }
                }
            }else{
                Text("Loading")
            }
        }.animation(.interactiveSpring())
        .navigationBarTitle(Text("Branches"))
        .onAppear{
            repoStore.branches(repo: repo)
        }
    }
}

struct BranchListPage_Previews: PreviewProvider {
    static var previews: some View {
        BranchListPage(repo: Repo())
    }
}
