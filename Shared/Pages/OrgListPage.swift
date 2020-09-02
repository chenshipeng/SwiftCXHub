//
//  OrgListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/27.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage
struct OrgListPage: View {
    var login:String
    @EnvironmentObject var userStore:CurrentUserStore
    var body: some View {
        ScrollView{
            List{
                if let orgs = userStore.orgList[login]{
                    ForEach(orgs){org in
                        VStack(alignment:.leading){
                            HStack{
                                if let urlString = org.avatar_url,let url = URL(string: urlString){
                                    KFImage(url)
                                        .resizable()
                                        .frame(width:60,height:60)
                                        .cornerRadius(30)
                                        .background(RoundedRectangle(cornerRadius: 30)
                                                        .stroke(Color.purple))
                                }
                                Text(org.login ?? "")
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
                }
            }
            
        }
        .animation(.interactiveSpring())
        .navigationBarTitle(Text(login))
        .onAppear{
            userStore.orgList(userLogin:login)
        }
    }
}

struct OrgListPage_Previews: PreviewProvider {
    static var previews: some View {
        OrgListPage(login: "chenshipeng")
    }
}
