//
//  MediumWidget.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/8.
//

import SwiftUI
import WidgetKit
struct MediumWidget: View {
    var trending:Trending
    var body: some View{
        VStack(alignment:.leading){
            Text(trending.name ?? "")
                .foregroundColor(Color(hexString:trending.languageColor!))
            Text(trending.description ?? "")
                .lineLimit(2)
            VStack(alignment:.leading){
                HStack{
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
        }
        .padding()
        .widgetURL(URL(string: "https://api.github.com/repos/\( trending.author!)/\(trending.name!)")!)
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget(trending: Trending.staticTrending())
    }
}
