//
//  LoginView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI


struct LoginView: View {
    
    //@State private var name = ""
    @State private var password = ""
    @State private var isSecure = false
    @State private var pushLogin = false
    @State var pushCreate = false
    //ここから下の三つを追加した。
    @AppStorage("user_name") var name = ""
    @AppStorage("isLogin") var isLogin = false
    @State var login_User: User = User(name: "", password: "", sex: "", age: "", graduate: "")
    @State var pushLoginButton: Bool = false
    @State var inputUserName: String = ""
    @State var selectionuser = [User]()
    @State private var NotExistAlert = false

    var body: some View {
        
        ZStack{
            BackGroundCircle()
                .offset(x: 130, y:-300)
            BackGroundCircle()
                .offset(x: -130, y: 420)
            
            VStack(spacing: 70){
                VStack{
                    Text("ログイン")
                        .font(.largeTitle)
                        //.padding(50)
                    
                    VStack(spacing: 10){
                        Text("あなたのユーザー名")
                        TextField("ユーザー名", text: $inputUserName)
                            .autocapitalization(.none)  // 最初の文字が大文字になるのを防ぐ
                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            .keyboardType(.asciiCapable)
                            .frame(width: 300)
                            .padding(.trailing, 30)
                            .padding(.bottom, 20)  // 余白を追加
                        
                        Text("パスワード")
                        HStack{
                            if isSecure {
                                TextField("パスワード", text: $password)
                                    .autocapitalization(.none)
                                    .keyboardType(.asciiCapable)
                                    .frame(width: 300)
                            } else {
                                SecureField("パスワード", text: $password)
                                    .autocapitalization(.none)
                                    .keyboardType(.asciiCapable)
                                    .frame(width: 300)
                                
                            }
                            
                            Button(action: {
                                isSecure.toggle()
                            }) {
                                Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill")
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 20)
                    }
                    .padding(30)
                    
                    Button{
                        //ここにログインボタンが押された時の処理
                        apiCall().getUserFromNameAndPassword(name: inputUserName, password: password) { (user) in
                            self.selectionuser = user
                            if selectionuser.count == 1 {
                                print("正常に動作してる")
                                login_User = selectionuser[0]
                                print(login_User)
                                SaveUserData(login_User)
                                isLogin.toggle()
                            } else {
                                print("そんなユーザーは存在しない")
                                NotExistAlert = true
                            }
                            name = inputUserName
                            if isLogin {
                                ContentView()
                            }
                        }
                    }label: {
                        Text("ログイン")
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 40, alignment: .center)
                            .background(Color.orange)
                            .cornerRadius(50)
                    }.alert(isPresented: $NotExistAlert) {
                        Alert(title: Text("名前もしくはパスワードが違います"))
                    }
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width:300, height: 0.5)
                        .padding(30)
                    
                    Button(action: {
                        pushCreate = true
                        if pushCreate{
                            CreateAccountView()
                        }
                    }) {
                        Text("初めての方はこちら")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 40, alignment: .center)
                            .background(Color.green)
                            .cornerRadius(50)
                    }
                    .fullScreenCover(isPresented: $pushCreate) { //フルスクリーンの画面遷移
                        CreateAccountView()
                    }
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

struct BackGroundCircle: View {
    var body: some View {
        Circle()
            .fill(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .green.opacity(0.2)]), startPoint: .leading, endPoint: .trailing))
    }
}
