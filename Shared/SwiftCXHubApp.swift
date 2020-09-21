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
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            TabbarView()
            .environmentObject(uiState)
            .environmentObject(AuthClient.shared)
            .environmentObject(CurrentUserStore.shared)
            .environmentObject(RepoManager.shared)
            .sheet(item: $uiState.presentedRoute, content: {$0.makeSheet()})
            #else
            SideBarView()
                .environmentObject(uiState)
                .environmentObject(AuthClient.shared)
                .environmentObject(CurrentUserStore.shared)
                .environmentObject(RepoManager.shared)
                .sheet(item: $uiState.presentedRoute, content: {$0.makeSheet()})
            #endif
            
        }
    }
}
struct SideBarView:View {
    var body: some View{
        NavigationView{
            List{
                NavigationLink(destination:CurrentUserReceivedEventsListPage()){
                    Label("Events", systemImage: "list.bullet.rectangle")
                }
                NavigationLink(destination: DiscoverListPage(), label: {
                    Label("Discovery", systemImage: "flame")
                })
                NavigationLink(destination: MyRepoListPage(), label: {
                    Label("Repos", systemImage: "tray.circle")
                })
                NavigationLink(destination: MyProfilePage(), label: {
                    Label("About Me", systemImage: "person.circle")
                })
                
            }
            .listStyle(SidebarListStyle())
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

