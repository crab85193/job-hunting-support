//
//  FirstView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct FirstView: View {
    
    @State private var pushSignUp = false
    
    var body: some View {
        NavigationView {
            VStack {
                // 画面遷移を行うボタン
                NavigationLink(destination: ContentView()) {
                    Text("画面遷移ボタン")
                }
                
                // その他のビューコンテンツ
                // ...
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
   static var previews: some View {
       FirstView()
   }
}
