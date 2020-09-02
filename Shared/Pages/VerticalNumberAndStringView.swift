//
//  VerticalNumberAndStringView.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/9/1.
//

import SwiftUI

struct VerticalNumberAndStringView: View {
    var number:Int?
    var str:String
    var body: some View {
        return VStack{
            Text("\(number ?? 0)")
                .foregroundColor(.primary)
                .font(.system(size: 16))
            Text(str)
                .foregroundColor(.secondary)
                .font(.system(size: 14))
        }
        .padding()
    }
}

struct VerticalNumberAndStringView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalNumberAndStringView(number:2, str: "Stars")
    }
}
