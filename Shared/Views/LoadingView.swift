//
//  LoadingView.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/19.
//

import SwiftUI

struct RowLoadingView: View {
    var body: some View {
        HStack{
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RowLoadingView()
    }
}
