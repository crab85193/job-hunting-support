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
    @State private var pushLogin = false
    @State var pushCreate = false
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = false

    var body: some View {
        VStack(spacing: 70){
            NavigationStack{
                VStack{
                    Text("ログイン")
                        .font(.largeTitle)
                        .padding(50)
                    
                    VStack(spacing: 10){
                        Text("あなたのユーザー名")
                        TextField("ユーザー名", text: $name)
                            .autocapitalization(.none)  // 最初の文字が大文字になるのを防ぐ
                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            .frame(width: 330)
                            .padding(20)  // 余白を追加
                        
                        Text("パスワード")
                        HStack{
                            if isSecure {
                                TextField("パスワード入力", text: $password)
                                    .autocapitalization(.none)
                                    .frame(width: 300)
                            } else {
                                SecureField("パスワード入力", text: $password)
                                    .autocapitalization(.none)
                                    .frame(width: 300)
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
                    .padding(30)
                    
                    Button{
                        //ここにログインボタンが押された時の処理
                        
                    }label: {
                        Text("ログイン")
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 40, alignment: .center)
                            .background(Color.orange)
                            .cornerRadius(50)
                            .padding()
                    }
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width:300, height: 0.5)
                        .padding(30)

                }.navigationDestination(isPresented: $pushCreate){
                    CreateAccountView()
                }
                Button{
                    pushCreate.toggle()
                }label: {
                Text("初めての方はこちら")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(50)
                    .padding()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
