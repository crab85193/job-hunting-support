//
//  CreateAccountView.swift
//  job-hunting-support
//  
//  Created by Crab Anderson on 2023/06/22
//  
//

import SwiftUI

struct CreateAccountView: View {
    
    @State private var name = ""
    @State private var password = ""
    @State private var year = 0
    
    var body: some View {
        VStack(spacing: 70){
            Text("アカウント作成")
                .font(.largeTitle)
            
            VStack(spacing: 10){
                Text("あなたのユーザー名")
                TextField("ユーザー名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding()  // 余白を追加
                
                Text("パスワード")
                TextField("パスワード", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding()  // 余白を追加
                
                Text("学年")
                
                Picker("好きな動物を選択", selection: $year) {
                    Text("学部1年次").tag(1)
                    Text("学部2年次").tag(2)
                    Text("学部3年次").tag(3)
                    Text("学部4年次").tag(4)
                }
            }
            
            Button{
                //ここにログインボタンが押された時の処理
            }label: {
                Text("作成")
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
