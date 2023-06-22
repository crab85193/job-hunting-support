//
//  LoginView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct LoginView: View {
    
    @State private var name = ""
    @State private var password = ""
    @State private var isSecure = true

    var body: some View {
        VStack(spacing: 70){
            Text("ログイン")
                .font(.largeTitle)
            
            VStack(spacing: 10){
                Text("あなたのユーザー名")
                TextField("ユーザー名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding()  // 余白を追加
                
                Text("パスワード")
                HStack{
                    if isSecure {
                        TextField("パスワード入力", text: $password)
                            .frame(width: 330)
                    } else {
                        SecureField("パスワード入力", text: $password)
                            .frame(width: 330)
                    }

                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill")
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
            
            Button{
                //ここにログインボタンが押された時の処理
            }label: {
                Text("ログイン")
            }
            
            Rectangle()
                    .foregroundColor(.black)
                    .frame(width:300, height: 0.5)
            
            Button{
                //ここに初めての方はこちらボタンが押された時の処理
            }label: {
                Text("初めての方はこちら")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
