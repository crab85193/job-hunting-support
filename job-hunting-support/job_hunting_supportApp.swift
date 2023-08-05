//
//  job_hunting_supportApp.swift
//  job-hunting-support
//
//  Created by Crab Anderson on 2023/06/22.
//

import SwiftUI

@main
struct YourApp: App {
    @AppStorage("user_name") var name = ""
    @AppStorage("isLogin") var isLogin = false
    
    var body: some Scene {
        WindowGroup {
            if isLogin {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
