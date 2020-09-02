//
//  UserHeader.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/21.
//

import SwiftUI
import struct Kingfisher.KFImage

struct UserHeader: View {
    var user:User
    var body: some View {
        VStack{
            //repo name and des
            HStack{
                if let urlString = user.avatar_url,let url = URL(string: urlString){
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
                    Text(user.name ?? "")
                        .foregroundColor(.primary)
                        .font(.system(size: 15))
                        .padding(.bottom,1)
                    Text(user.login ?? "")
                        .foregroundColor(.primary)
                        .font(.system(size: 16))
                }
                .padding(.trailing,10)
                .padding(.leading,15)
                Spacer()
                
                Text(user.location ?? "")
                    .padding(.trailing,10)
            }
            .padding(.bottom,10)
            Divider()
            HStack{
                NavigationLink(destination:FollowersListPage(login: user.login!)){
                    VStack{
                        Text("\(user.followers ?? 0)")
                            .foregroundColor(.primary)
                            .font(.system(size: 16))
                        Text("Followers")
                            .foregroundColor(.secondary)
                            .font(.system(size: 14))
                    }
                    .padding()
                }
                Divider()
                NavigationLink(destination:FollowingListPage(login: user.login!)){
                    VStack{
                        Text("\(user.following ?? 0)")
                            .foregroundColor(.primary)
                            .font(.system(size: 16))
                        Text("Followings")
                            .foregroundColor(.secondary)
                            .font(.system(size: 14))
                    }
                    .padding()
                }
                
                
            }
        }
    }
}

struct UserHeader_Previews: PreviewProvider {
    static var previews: some View {
        UserHeader(user: User())
    }
}
