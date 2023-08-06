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
    
    enum AlertType {
       case alert1
       case alert2
       case alert3
    }
    //@State private var name = ""
    @State private var password = ""
    @State private var isSecure = false
    @State var year = ""
    @State var sex = ""
    @State var age = ""
    @State var response = ""
    @State var selectionuser = [User]()
    @State var login_User: User = User(name: "", password: "", sex: "", age: "", graduate: "")
    //ここから下の三つを追加した。
    @AppStorage("user_name") var name = ""
    @AppStorage("isLogin") var isLogin = false
    @State var pushLoginButton: Bool = false
    @State var inputUserName: String = ""
    @State private var showAlert = false
    @State var alertType: AlertType = .alert1
    
    // 画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 50){
            // 戻るボタン
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blue)
                }
                .padding(.leading, 16)
                Spacer()
            }
            .background(Color(UIColor.systemBackground))
            
            Text("アカウント作成")
                .font(.largeTitle)
            
            VStack{
                Text("あなたのユーザー名")
                TextField("UserName", text: $inputUserName)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 330)
                    .padding(.bottom, 20)
                
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
                .padding(.bottom, 20)
                
                HStack{
                    Text("卒業年度")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker("あなたの卒業予定年度を選択", selection: $year) {
                        Text("未選択").tag("0")
                        Text("23卒").tag("2023-03-31")
                        Text("24卒").tag("2024-03-31")
                        Text("25卒").tag("2025-03-31")
                        Text("26卒").tag("2026-03-31")
                    }
                }
                .padding(.horizontal,30)
                .padding(.bottom, 15)
                
                HStack{
                    Text("性別")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker("あなたの性別を選択", selection: $sex) {
                        Text("未選択").tag("0")
                        Text("男性").tag("male")
                        Text("女性").tag("female")
                    }
                }
                .padding(.horizontal,30)
                .padding(.bottom, 15)
                
                HStack{
                    Text("年齢")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Age", text: $age)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 85)
                }
                .padding(.horizontal, 30)
            }
            
            Button{
                //ここに作成ボタンが押された時の処理
                if ((inputUserName != "") && (password != "") && ((year != "") && (year != "0")) && ((sex != "") && (sex != "0")) && (age != "")){
                    print("OK")
                    apiCall().addUserInfotoServer(name: inputUserName, password: password, sex: sex, age: age, graduate: year) { response in
                        self.response = response
                        if response == "OK"{
                            apiCall().getUserFromNameAndPassword(name: inputUserName, password: password) { (user) in
                                self.selectionuser = user
                                if selectionuser.count == 1 {
                                    print("正常動作")
                                    login_User = selectionuser[0]
                                    print(login_User)
                                    SaveUserData(login_User)
                                    isLogin.toggle()
                                } else {
                                    print("Error")
                                    alertType = .alert1
                                    showAlert.toggle()
                                }
                                name = inputUserName
                                print("Login動作完了 ")
                                if isLogin{
                                    inputUserName = ""
                                    password = ""
                                    year = ""
                                    sex = ""
                                    age = ""
                                    ContentView()
                                }
                            }
                        } else {
                            print("Error発生")
                            alertType = .alert2
                            showAlert.toggle()
                        }
                        }
                } else {
                    print("NotOK")
                    alertType = .alert3
                    showAlert.toggle()
                }
            }label: {
                Text("作成")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(50)
            }.alert(isPresented: $showAlert) {
                switch alertType {
                    case .alert1:
                        return Alert(title: Text("エラーが発生しました。もう一度行ってください。"))
                    case .alert2:
                        return Alert(title: Text("このユーザー名は使用不可です。"))
                    case .alert3:
                        return Alert(title: Text("すべての項目を入力または選択してください。"))
                }
            }
            .padding(.bottom, 25)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
