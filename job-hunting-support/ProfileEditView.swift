//
//  ProfileEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct ProfileEditView: View {
    //画面遷移
    @Environment(\.presentationMode) var presentationMode

    @AppStorage("user_name") var name = ""
    @State var year: Int = 0
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    @State var LoginUser: User = (LoadUserData() ?? User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31"))

    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Text("ユーザー名")
                TextField("ユーザー名", text: $LoginUser.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding(.horizontal)  // 余白を追加
                Text("卒業予定年度")
                Picker("あなたの卒業予定年度を選択", selection: $LoginUser.graduation_year) {
                    Text("未選択").tag("1990-03-31")
                    Text("23卒").tag("2023-03-31")
                    Text("24卒").tag("2024-03-31")
                    Text("25卒").tag("2025-03-31")
                    Text("26卒").tag("2026-03-31")
                }.padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 50)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("プロフィールの編集")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: ProfileEditView()) {
//                        Text("保存")
//                    }
//                }
//            }
            .navigationBarItems(trailing: Button("保存") {
                print(LoginUser)
                SaveUserData(LoginUser)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
