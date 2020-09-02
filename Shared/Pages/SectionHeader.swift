//
//  SectionHeader.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/21.
//

import SwiftUI

struct SectionHeader: View {
    var body: some View {
        Rectangle()
            .frame(height:5)
            .background(Color.gray).opacity(0.2)
            .padding(.leading,-10)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader()
    }
}
