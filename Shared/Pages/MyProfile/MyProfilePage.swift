//
//  MyProfilePage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/18.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MyProfilePage: View {
    @EnvironmentObject var userStore:CurrentUserStore
    @State var showSheet = false
    @State var url:String = "https://github.com/chenshipeng?tab=repositories"
    var body: some View {
        NavigationView{
            ZStack(alignment:.topLeading){
                
                VStack(alignment:.leading){
                    Text("Chenshipeng")
                        .font(.headline)
                        .padding(.top,10)
                        .padding(.bottom,10)
                    Text("A iOSer,and recently learning Flutter and SwiftUI,also like Design.")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .lineLimit(3)
                        .font(.system(size: 17))
                        .padding(.bottom,10)
                    Text("Github:")
                        .padding(.bottom,1)
                    HStack{
                        Button(action:{
                            url = "https://github.com/chenshipeng?tab=repositories"
                            showSheet.toggle()
                        }){
                            Image("github60")
                                .frame(width:30,height: 30)
                                .padding(.top,5)
                        }
                        
                    }.padding(.bottom,1)
                    HStack(alignment:.bottom){
                        Button(action:{
                            url = "https://apps.apple.com/us/app/cxhub-for-github/id1437613635?l=zh&ls=1"
                            showSheet.toggle()
                        }){
                            Text("App Download")
                                .foregroundColor(.blue)
                                .font(.system(size: 15))
                                .underline()
                        }
                    }
                    
                }
                .frame(width:300,height:300)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 10)
                
                if let urlString = userStore.currentUser?.avatar_url,let url = URL(string: urlString){
                    KFImage(url)
                        .resizable()
                        .frame(width:60,height:60)
                        .cornerRadius(30)
                        .background(RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.purple))
                        .offset(x: 120, y: -30)
                        .shadow(radius: 30)
                }else{
                    Circle()
                        .frame(width:60,height:60)
                        .background(RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.purple))
                        .offset(x:120, y: -30)
                        .shadow(radius: 30)
                }
                
            }
            .animation(.spring())
            .navigationBarTitle(Text("About Me"))
            .sheet(isPresented: $showSheet, content: {SafariView(url: URL(string: url)!)})
            
        }
        .background(Color(UIColor.secondarySystemBackground))
        
    }
}

struct MyProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        MyProfilePage()
    }
}
