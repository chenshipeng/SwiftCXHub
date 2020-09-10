//
//  SmallWidget.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/8.
//

import SwiftUI
import WidgetKit
struct SmallWidget: View {
    var trending:Trending
    var body: some View{
        VStack(alignment:.leading){
            Text(trending.name ?? "")
                .foregroundColor(Color(hexString:trending.languageColor!))
            Text(trending.description ?? "")
            HStack{
                HStack{
                    Image(systemName:"star.circle")
                        .frame(width:10,height:10)
                        .cornerRadius(5)
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
                    Image(systemName:"arrow.triangle.branch")
                        .frame(width:10,height:10)
                        .cornerRadius(5)
                        .foregroundColor(Color(hexString:trending.languageColor!))
                    if trending.forks! > 1000 {
                        Text(String(format: "%.1fK", Float(trending.forks!)/1000.0))
                            .lineLimit(1)
                    }else{
                        Text("\(trending.forks ?? 0)")
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding()
        .widgetURL(URL(string: "https://api.github.com/repos/\( trending.author!)/\(trending.name!)")!)
    }
}
