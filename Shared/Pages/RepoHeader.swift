//
//  RepoHeader.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/21.
//

import SwiftUI
import struct Kingfisher.KFImage
struct RepoHeader: View {
    var repo:Repo
    
    var body: some View {
        VStack{
            //repo name and des
            HStack{
                if let urlString = repo.owner?.avatar_url,let url = URL(string: urlString){
                    KFImage(url)
                        .resizable()
                        .frame(width:40,height:40)
                        .cornerRadius(20)
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.purple))
                        .padding(.leading,20)
                }else{
                    Circle()
                        .frame(width:40,height:40)
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.purple))
                        .padding(.leading,20)
                }
                VStack(alignment:.leading){
                    Text(repo.name ?? "")
                        .foregroundColor(.primary)
                        .font(.system(size: 15))
                        .padding(.bottom,1)
                    Text(repo.description ?? "")
                        .foregroundColor(.primary)
                        .font(.system(size: 16))
                }
                .padding(.trailing,10)
                .padding(.leading,15)
                Spacer()
            }
            .padding(.bottom,10)
            Divider()
            HStack{
                NavigationLink(destination:UserListPage(repo: repo, listType: .stars)){
                    VerticalNumberAndStringView(number: repo.stargazers_count, str: "Stars")
                }
                NavigationLink(destination:UserListPage(repo: repo, listType: .forks)){
                    VerticalNumberAndStringView(number: repo.forks_count, str: "Forks")
                }
                NavigationLink(destination:UserListPage(repo: repo, listType: .watchers)){
                    VerticalNumberAndStringView(number: repo.watchers_count, str: "Watchers")
                }
            }
        }
    }
}

struct RepoHeader_Previews: PreviewProvider {
    static var previews: some View {
        RepoHeader(repo: Repo())
    }
}
