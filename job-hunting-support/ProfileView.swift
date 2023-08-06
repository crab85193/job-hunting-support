//
//  ProfileView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct ProfileView: View {
    
    @State var showLogoutAlert = false
    @AppStorage("isLogin") var isLogin = false
    @State var viewSex : String = ""
    
    @State var LoginUser: User = (LoadUserData() ?? User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31"))

    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 80){
                VStack(spacing: 20)/*(alignment: .leading)*/{
                    HStack{
                        Text("ユーザー名")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(LoginUser.name)")
                    }
                    .padding(.all, 20)
                    
                    HStack{
                        Text("卒業予定年度")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(LoginUser.graduation_year)")
                    }
                    .padding(.all, 20)
                    
                    HStack{
                        Text("性別")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(LoginUser.sex)")
                    }
                    .padding(.all, 20)
                    
                    HStack{
                        Text("年齢")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(LoginUser.age)")
                    }
                    .padding(.all, 20)
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
                            UserDefaults.resetStandardUserDefaults()
                            LoginView()
                        },
                        secondaryButton: .cancel(Text("キャンセル")){
                            print("Cancelで閉じる")
                        }
                    )
                }
            }
            .navigationTitle("プロフィール")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileEditView(UserInfo: $LoginUser)) {
                        Text("編集")
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
