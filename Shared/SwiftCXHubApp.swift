//
//  SwiftCXHubApp.swift
//  Shared
//
//  Created by chenshipeng on 2020/8/6.
//

import SwiftUI
import Combine



@main
struct SwiftCXHubApp: App {
    @StateObject private var authClient = AuthClient.shared
    @StateObject private var uiState = UIState()
    var body: some Scene {
        WindowGroup {
            TabbarView()
            .environmentObject(uiState)
            .environmentObject(AuthClient.shared)
            .environmentObject(CurrentUserStore.shared)
            .environmentObject(RepoManager.shared)
            .sheet(item: $uiState.presentedRoute, content: {$0.makeSheet()})
        }
    }
}
struct TabbarView:View {
    enum Tab:Int {
        case hometab
        case discovery
        case repos
        case profile
    }
    @State var selectedTab = Tab.hometab
    @EnvironmentObject var uistate:UIState
    func tabbarItem(text:String,image:String) -> some View{
        VStack{
            Image(systemName: image)
            Text(text)
        }
    }
    var body: some View{
        //这里使用Zstack是为了显示其他的内容，比如完整的提示
        ZStack(alignment: .center){
            TabView(selection:$selectedTab){
                CurrentUserReceivedEventsListPage()
                    .tabItem{
                    self.tabbarItem(text: "Events", image: "list.bullet.rectangle")
                }
                .tag(Tab.hometab)
                
                DiscoverListPage()
                    .tabItem {
                        self.tabbarItem(text: "Discovery", image: "flame")
                        
                    }
                    .tag(Tab.discovery)
                MyRepoListPage()
                    .tabItem {
                        self.tabbarItem(text: "Repos", image: "tray.circle")
                    }
                    .tag(Tab.repos)
                MyProfilePage()
                    .tabItem {
                        self.tabbarItem(text: "About Me", image: "person.circle")
                    }
                    .tag(Tab.profile)
                    
            }
            
            
        }
            
        .accentColor(.primary)
            
            if let toast = uistate.toast,toast.0{
                Text(toast.1)
                    .font(.system(size: 17))
                    .foregroundColor(Color(UIColor.label))
                    .background(Color.primary)
                    .opacity(0.5)
                    .padding()
                    .cornerRadius(5)
            }
        }
    }

