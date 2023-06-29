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
    @State private var isSecure = true
    @State private var year = 0
    
    var body: some View {
        VStack(spacing: 70){
            Text("アカウント作成")
                .font(.largeTitle)
            
            VStack(spacing: 10){
                Text("あなたのユーザー名")
                TextField("ユーザー名", text: $name)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 330)
                    .padding()
                
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
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
