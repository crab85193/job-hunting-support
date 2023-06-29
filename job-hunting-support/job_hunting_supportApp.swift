//
//  job_hunting_supportApp.swift
//  job-hunting-support
//
//  Created by Crab Anderson on 2023/06/22.
//

import SwiftUI

@main
struct YourApp: App {
    
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            LoginView()
            /*  今はLoginViewを強制表示しているが、後々起動時の画面指定を行う
            if isFirstLaunch {
                LoginView()
                    .onAppear {
                        isFirstLaunch = false // 初回起動フラグをfalseに設定
                    }
            } else {
                ContentView()
            }
             */
        }
    }
}
