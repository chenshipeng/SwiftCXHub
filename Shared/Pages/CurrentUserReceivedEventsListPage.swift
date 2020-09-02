//
//  HomeTab.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/14.
//

import SwiftUI
import Alamofire
import Combine
import struct Kingfisher.KFImage

public func makeUserEventCell(_ event: UserEvent) -> some View {
    return HStack(alignment:.center){
        if let urlString = event.actor?.avatar_url,let url = URL(string: urlString){
            KFImage(url)
                .resizable()
                .frame(width:60,height:60)
                .cornerRadius(30)
                .background(RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.purple))
        }
        VStack(alignment:.leading){
            Text(event.created_at?.string(withFormat: "yyyy-MM-dd") ?? "")
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .padding(.bottom,1)
            
            
            Text(event.actionDes)
                .foregroundColor(.primary)
                .font(.system(size: 16))
        }
        .padding(.trailing,10)
    }
}

struct CurrentUserReceivedEventsListPage: View {
    @State var page = 1
    @EnvironmentObject var auth:AuthClient
    @EnvironmentObject var currentUser:CurrentUserStore
    
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    if currentUser.username.count > 0,let events = currentUser.userEvents[currentUser.username]{
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
                .navigationBarTitle(Text("Events"))
            }  
        }
        
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserReceivedEventsListPage()
    }
}



