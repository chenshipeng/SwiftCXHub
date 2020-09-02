//
//  UIState.swift
//  SwiftCXHub (iOS)
//
//  Created by chenshipeng on 2020/8/14.
//

import Foundation
import SwiftUI
import Combine
class UIState: ObservableObject {
    public static let shared = UIState()
    enum Route:Identifiable {
        case login
        
        var id:String{
            switch self {
            case .login:
                return "login"
            }
        }
        @ViewBuilder
        func makeSheet() -> some View{
            switch self {
            case .login:
                LoginPage()
                    .environmentObject(AuthClient.shared)
            }
        }
    }
    @Published var presentedRoute:Route?
    @Published var toast:(Bool,String)?
    
    
    private var disposeBag:[AnyCancellable] = []

    init() {
        let cancallable = AuthClient.shared.$authStatus.sink{canAuth in
            switch canAuth{
            case .signnedOut,.unknown:
                self.presentedRoute = .login
            default:
                break
            }
        }
        disposeBag.append(cancallable)
    }
}
