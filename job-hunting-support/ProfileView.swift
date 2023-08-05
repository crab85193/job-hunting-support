//
//  ProfileView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct ProfileView: View {
    
    @State var year: Int = 0
    @State var showLogoutAlert = false
    @AppStorage("user_name") var name = ""
    @AppStorage("isLogin") var isLogin = false
    
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 80){
                VStack(spacing: 20)/*(alignment: .leading)*/{
                    Text("ユーザー名")
                    TextField("ユーザー名", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        .padding(.horizontal)  // 余白を追加
                    Text("卒業予定年度")
                    TextField("あなたの卒業予定年度", value: $year, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    /*
                    Text("Selected Tag in AnotherView: \(sharedData.selectedTag)")
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                     */
                }
                
                Button(action: {
                    showLogoutAlert = true;
                }){
                    Text("ログアウト")
                        .foregroundColor(Color.white)
                        .frame(width: 120, height: 40, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(50)
                        //.padding()
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(title: Text("本当にログアウトしますか？"),
                        message: Text("ログアウトすると、次回アプリを開いていただいた時に再度ログインしてもらう必要があります。"),
                        primaryButton: .destructive(Text("ログアウト")){
                            isLogin.toggle()
                            LoginView()
                        },
                        secondaryButton: .cancel(Text("キャンセル")){
                            print("Cancelで閉じる")
                        }
                    )
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
