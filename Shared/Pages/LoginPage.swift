//
//  LoginPage.swift
//  SwiftCXHub
//
//  Created by chenshipeng on 2020/8/12.
//

import SwiftUI
let screenWidth = UIScreen.main.bounds.width
struct LoginPage: View {
    @EnvironmentObject var user:AuthClient
    @Environment(\.presentationMode) var presentation
    var body: some View {
        GeometryReader {geo in
            VStack(){
                VStack{
                    TextField("Please input username", text: $user.email)
                        .padding(.vertical,15)
                        .frame(width:200,height: 50)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Please input password", text: $user.password)
                        .padding(.bottom,15)
                        .frame(width:200,height: 50)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action:{
                        print("username \(user.email),password \(user.password)")
                        if user.email.trim().count > 0 ,user.password.trim().count > 0{
                            user.authStatus = .signInProgress
                            presentation.wrappedValue.dismiss()
                        }
                    }){
                        Image(systemName: "flame")
                            .foregroundColor(.red)
                        Text("Login")
                            .foregroundColor(.secondary)
                    }
                    .frame(width:200,height:44)
                    .background(Color.secondary)
                    .cornerRadius(22)
                }
            }
            .frame(width:geo.size.width,height:geo.size.height)
            .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)))
            .opacity(0.3)
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 10, x: 3, y: 3)
        }
        .ignoresSafeArea(.all, edges: .all)

        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .environmentObject(AuthClient.shared)
    }
}
