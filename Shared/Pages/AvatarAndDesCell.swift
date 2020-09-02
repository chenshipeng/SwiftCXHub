//
//  AvatarAndDesCell.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/21.
//

import SwiftUI
import struct Kingfisher.KFImage
struct AvatarAndDesCell: View {
    var imageName:String
    var des:String
    var showAccessArrow:Bool = true
    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .frame(width:20,height:20)
                .cornerRadius(10)
                .padding(.leading,5)
            Text(des)
                .foregroundColor(.primary)
                .font(.body)
                .fontWeight(.medium)
            if showAccessArrow{
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing,10)
            }
        }
        .frame(height:44)
    }
}
struct RemoteAvatarAndDesCell: View {
    var imageName:String?
    var des:String
    var showAccessArrow:Bool = true
    var body: some View {
        HStack{
            if let str = imageName,str.count > 0,let url = URL(string: str){
                KFImage(url)
                    .resizable()
                    .frame(width:30,height:30)
                    .cornerRadius(15)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.purple))
                    .padding(.leading,5)
            }else{
                Circle()
                    .frame(width:30,height:30)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.purple))
                    .padding(.leading,5)
            }
            
            Text(des)
                .foregroundColor(.primary)
                .font(.body)
                .fontWeight(.medium)
            if showAccessArrow{
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing,10)
            }
        }
        .frame(height:44)
    }
}
struct AvatarAndDesCell_Previews: PreviewProvider {
    static var previews: some View {
        AvatarAndDesCell(imageName: "owner", des: "owner")
    }
}
