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
    @State var selectionuser = [user]()
    @State var login_User: user = user(name: "", password: "", sex: "", age: "", graduate: "")
    //ここから下の三つを追加した。
    @AppStorage("user_name") var name = ""
    @AppStorage("isLogin") var isLogin = false
    @State var pushLoginButton: Bool = false
    @State var inputUserName: String = ""
    @State private var showAlert = false
    @State var alertType: AlertType = .alert1
    
    var body: some View {
        //Viewは仮置き
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
                
                Text("卒業年度")
                Picker("あなたの卒業予定年度を選択", selection: $year) {
                                    Text("未選択").tag("0")
                                    Text("23卒").tag("2023")
                                    Text("24卒").tag("2024")
                                    Text("25卒").tag("2025")
                                    Text("26卒").tag("2026")
                }.padding(.bottom, 30)
                
                Text("性別")
                Picker("あなたの性別を選択", selection: $sex) {
                                    Text("未選択").tag("0")
                                    Text("男性").tag("male")
                                    Text("女性").tag("female")
                }.padding(.bottom, 30)
                
                Text("年齢")
                TextField("Age", text: $age)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 75)//調整頼む
                    .padding(.bottom, 30)
            }
            
            Button{
                //ここに作成ボタンが押された時の処理
                if ((inputUserName != "") && (password != "") && ((year != "") && (year != "0")) && ((sex != "") && (sex != "0")) && (age != "")){
                    print("OK")
                    apiCall().addUserInfotoServer(name: inputUserName, password: password, sex: sex, age: age, graduate: year+"/3/31") { response in
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
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
