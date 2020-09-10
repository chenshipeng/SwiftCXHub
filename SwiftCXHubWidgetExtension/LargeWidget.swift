//
//  LargeWidget.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/10.
//

import SwiftUI
import WidgetKit
struct LargeWidget: View {
    var trendings:[Trending]
    var body: some View{
        GeometryReader{proxy in
            VStack{
                ForEach(trendings,id:\.self){trending in
                    VStack(alignment:.leading){
                        Text(trending.name ?? "")
                            .foregroundColor(Color(hexString:trending.languageColor!))
                        Text(trending.description ?? "")
                        VStack(alignment:.leading){
                            HStack{
                                StarAndGlobeView(trending: trending)
                                ForkAndAuthorView(trending: trending)
                            }
                        }
                        Divider()
                    }
                    .widgetURL(URL(string: "https://api.github.com/repos/\( trending.author!)/\(trending.name!)")!)
                }
            }
            .padding()
            .frame(height:proxy.frame(in: .global).height)
            
        }
        
        
    }
}
struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget(trendings: [Trending.staticTrending(),Trending.staticTrending(),Trending.staticTrending()])
    }
}

struct StarAndGlobeView: View {
    var trending:Trending
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Image(systemName:"star.circle")
                    .frame(width:20,height:20)
                    .foregroundColor(Color(hexString:trending.languageColor!))
                if trending.stars! > 1000 {
                    Text(String(format: "%.1fK", Float(trending.stars!)/1000.0))
                        .lineLimit(1)
                }else{
                    Text("\(trending.stars ?? 0)")
                        .lineLimit(1)
                }
            }
            
            HStack{
                Image(systemName:"globe")
                    .frame(width:20,height:20)
                    .foregroundColor(Color(hexString:trending.languageColor!))
                
                Text(trending.language ?? "")
                    .lineLimit(1)
            }
        }
    }
}

struct ForkAndAuthorView: View {
    var trending:Trending
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Image(systemName:"arrow.triangle.branch")
                    .frame(width:20,height:20)
                    .foregroundColor(Color(hexString:trending.languageColor!))
                
                if trending.forks! > 1000 {
                    Text(String(format: "%.1fK", Float(trending.forks!)/1000.0))
                        .lineLimit(1)
                }else{
                    Text("\(trending.forks ?? 0)")
                        .lineLimit(1)
                }
            }
            
            HStack{
                Image(systemName:"person.circle")
                    .frame(width:20,height:20)
                    .foregroundColor(Color(hexString:trending.languageColor!))
                
                Text(trending.author ?? "")
                    .lineLimit(1)
            }
        }
    }
}
