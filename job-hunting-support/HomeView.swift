//
//  HomeView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

//  後々リスト表示ができてきたらここにカテゴリー別に表示するものを作る。
//  (もしかしたらHomeViewを削除してListViewをメインに作っていくかも？)

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer().frame(height: 50)
                Text("予定")
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
