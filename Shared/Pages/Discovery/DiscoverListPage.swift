//
//  DiscoverListPage.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/4.
//

import SwiftUI
import Combine
import SwifterSwift
import struct Kingfisher.KFImage
enum DisLanguage:String,CaseIterable {
    
    case javascript,java,php,ruby,python,css,cpp,c,objectiveC,swift,shell,r,perl,lua,html,scala,go
}
struct DiscoverListPage: View {
    @State private var selectedTab:DiscoveryTypes = .daily
    @State private var language = "swift"
    @EnvironmentObject private var userStore:CurrentUserStore
    @State private var menuShow = false
    fileprivate func trendingBottom(_ trending:Trending) -> some View {
        return VStack(alignment:.leading){
            Text(trending.name!)
                .padding(.bottom,10)
            Text(trending.description ?? "")
                .font(.system(size: 14))
                .padding(.bottom,10)
            VStack(alignment:.leading){
                HStack{
                    Image(systemName:"star.circle")
                        .frame(width:20,height:20)
                        .cornerRadius(10)
                        .foregroundColor(Color(UIColor(hexString: trending.languageColor!)!))
                    Text("\(trending.stars ?? 0)")
                        .lineLimit(1)
                    
                    Image(systemName:"arrow.triangle.branch")
                        .frame(width:20,height:20)
                        .cornerRadius(10)
                        .foregroundColor(Color(UIColor(hexString: trending.languageColor!)!))
                        .padding(.leading,40)
                    Text("\(trending.forks ?? 0)")
                        .lineLimit(1)
                }
                HStack{
                    Image(systemName:"globe")
                        .frame(width:20,height:20)
                        .cornerRadius(10)
                        .foregroundColor(Color(UIColor(hexString: trending.languageColor!)!))
                    Text(trending.language ?? "")
                        .lineLimit(1)
                    
                    Image(systemName:"person.circle")
                        .frame(width:20,height:20)
                        .cornerRadius(10)
                        .foregroundColor(Color(UIColor(hexString: trending.languageColor!)!))
                        .padding(.leading,80)
                    Text(trending.author ?? "")
                        .lineLimit(1)
                }
            }
            
        }
        .padding(.trailing,15)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    Section(header:seg){
                        if let trendings = userStore.trendings[language+selectedTab.rawValue]{
                            ForEach(trendings,id:\.self){trending in
                                HStack{
                                    if let urlString = trending.avatar,let url = URL(string: urlString){
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
                                    NavigationLink(destination:RepoDetailPage(repoUrl:trending.url!)){
                                        trendingBottom(trending)
                                    }
                                    
                                }
                                
                            }
                           
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Discovery"))
                .onAppear{
                    userStore.trending(lan:language,type:.daily)
                    userStore.trending(lan:language,type:.weekly)
                    userStore.trending(lan:language,type:.monthly)
                }
                .toolbar {
                    ToolbarItem(placement:.primaryAction){
                        Menu {
                            ForEach(DisLanguage.allCases,id:\.self){lan in
                                Button(lan.rawValue,action:{
                                    if lan == .objectiveC{
                                        language = "Objective-C"
                                    }else{
                                        language = lan.rawValue
                                    }
                                    loadData()
                                })
                            }
                        }
                        label:{
                            Text(language)
                        }
                    }
                }
            }
            
            
        }
    }
    private func loadData(){
        userStore.trending(lan:language,type:.daily)
        userStore.trending(lan:language,type:.weekly)
        userStore.trending(lan:language,type:.monthly)
    }
    private var languageSelectBtn:some View{
        Button(action:{
            menuShow.toggle()
        },label:{
            Text(language)
        })
    }
    private var seg:some View{
        Picker(selection: $selectedTab, label: Text("")) {
            ForEach(DiscoveryTypes.allCases, id: \.self) { tab in
                Text(LocalizedStringKey(tab.rawValue.capitalized))
                    .textCase(nil)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
public enum DiscoveryTypes:String,CaseIterable {
    case daily,weekly,monthly
}
struct DiscoverListPage_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverListPage()
    }
}
