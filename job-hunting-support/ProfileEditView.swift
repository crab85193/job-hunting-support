//
//  ProfileEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct ProfileEditView: View {
    
    @AppStorage("user_name") var name = ""
    @State var year: Int = 0
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Text("ユーザー名")
                TextField("ユーザー名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding(.horizontal)  // 余白を追加
                Text("卒業予定年度")
                TextField("あなたの卒業予定年度", value: $year, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 50)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("プロフィールの編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileEditView()) {
                        Text("保存")
                    }
                }
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
