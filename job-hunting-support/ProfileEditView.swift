//
//  ProfileEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct ProfileEditView: View {
    
    enum AlertType {
       case alert1
       case alert2
    }
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    @State var isSecure = false
    @State var response = ""
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    @Binding var LoginUser: User
    @State var editedUserData : User
    
    init(UserInfo: Binding<User>){
        _LoginUser = UserInfo
        _editedUserData = State(initialValue: UserInfo.wrappedValue)
    }

    var body: some View {
        ScrollView{
            VStack {
                VStack(spacing: 20){
                    Text("ユーザー名")
                    TextField("ユーザー名", text: $editedUserData.name)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .keyboardType(.asciiCapable)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        .frame(width: 300)
                        .padding(.trailing, 30)
                    
                    Text("パスワード")
                    HStack{
                        if isSecure {
                            TextField("パスワード入力", text: $editedUserData.password)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                                .keyboardType(.asciiCapable)
                                .autocapitalization(.none)
                                .frame(width: 300)
                        } else {
                            SecureField("パスワード入力", text: $editedUserData.password)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                                .keyboardType(.asciiCapable)
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
                    .padding(.leading, 8)
                    .padding(.bottom, 15)
                    
                    HStack{
                        Text("卒業予定年度")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("あなたの卒業予定年度を選択", selection: $editedUserData.graduation_year) {
                            Text("未選択").tag("1990-03-31")
                            Text("23卒").tag("2023-03-31")
                            Text("24卒").tag("2024-03-31")
                            Text("25卒").tag("2025-03-31")
                            Text("26卒").tag("2026-03-31")
                        }
                        .autocapitalization(.none)
                        .frame(width: 150, height:50)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("性別")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("あなたの性別を選択", selection: $editedUserData.sex) {
                            Text("未選択").tag("0")
                            Text("男性").tag("male")
                            Text("女性").tag("female")
                        }
                        .autocapitalization(.none)
                        .frame(width: 150, height:50)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("年齢")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Age", text: $editedUserData.age)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .autocapitalization(.none)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                    .padding(.trailing, 8)
                    .padding(.horizontal)
                }
                .padding(.all, 20)
                
                HStack{
                    Text("年齢")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Age", text: $editedUserData.age)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 65)
                }
                .padding(.all, 20)
            }
            .padding(.bottom, 50)
            .navigationTitle("プロフィールの編集")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("保存") {
                if ((editedUserData.name != "") && (editedUserData.password != "") && (editedUserData.graduation_year != "") && (editedUserData.age != "") && (editedUserData.sex != "0")){
                    //print("OK")
                    apiCall().EditUserInfoinServer(id: LoginUser.id, name: editedUserData.name, password: editedUserData.password, sex: editedUserData.sex, age: editedUserData.age, graduate: editedUserData.graduation_year) { response in
                        self.response = response
                        if response == "OK"{
                            //print("Complete")
                            //print(LoginUser)
                            LoginUser = editedUserData
                            //print("変更後")
                            //print(LoginUser)
                            SaveUserData(LoginUser)
                            DispatchQueue.main.async {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }  else {
                            //print("Error in Response")
                            alertType = .alert1
                            showAlert.toggle()
                        }
                    } else {
                        print("Notfull")
                        alertType = .alert2
                        showAlert.toggle()
                    }
                } else {
                    //print("Notfull")
                    alertType = .alert2
                    showAlert.toggle()
                }
                
            }.alert(isPresented: $showAlert) {
                switch alertType {
                    case .alert1:
                        return Alert(title: Text("エラーが発生しました。もう一度行ってください。"))
                    case .alert2:
                        return Alert(title: Text("すべての項目を入力してください。"))
                }
            })
        }
    }
}

/*
 struct ProfileEditView_Previews: PreviewProvider {
 static var previews: some View {
 ProfileEditView()
 }
 }
 */
