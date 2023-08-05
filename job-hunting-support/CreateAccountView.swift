//
//  CreateAccountView.swift
//  job-hunting-support
//  
//  Created by Crab Anderson on 2023/06/22
//  
//

import SwiftUI

//卒業年度の値受け渡しのためのクラス
class SharedData: ObservableObject {
    @Published var selectedTag: String = ""
}

struct CreateAccountView: View {
    
    //@State private var name = ""
    @State private var password = ""
    @State private var isSecure = false
    @State var year = 0
    //ここから下の三つを追加した。
    @AppStorage("user_name") var name = ""
    @State var pushLoginButton: Bool = false
    @State var inputUserName: String = ""
    
    var body: some View {
        VStack(spacing: 70){
            Text("アカウント作成")
                .font(.largeTitle)
            
            VStack(spacing: 10){
                Text("あなたのユーザー名")
                TextField("UserName", text: $inputUserName)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 330)
                    .padding(.bottom, 30)
                
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
                .padding(.bottom, 30)
                
                Text("学年")
                Picker("好きな動物を選択", selection: $year) {
                    Text("23卒").tag(1)
                    Text("24卒").tag(2)
                    Text("25卒").tag(3)
                    Text("26卒").tag(4)
                }
            }
            
            Button{
                //ここに作成ボタンが押された時の処理
                name = inputUserName
                if name != "" {
                    ContentView()
                }
            }label: {
                Text("作成")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(50)
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
