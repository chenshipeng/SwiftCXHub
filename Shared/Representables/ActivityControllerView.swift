//
//  ActivityControllerView.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/19.
//

import Foundation
import SwiftUI
public struct ActivityControllerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]?
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityControllerView>) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        controller.completionWithItemsHandler = { _, _, _, _ in
            self.presentation.wrappedValue.dismiss()
        }
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController,
                                       context: UIViewControllerRepresentableContext<ActivityControllerView>) {

    }
}
