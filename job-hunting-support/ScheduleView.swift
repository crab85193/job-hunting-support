//
//  ScheduleView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Text("ここにスケジュール名が表示される。")
                        .listRowBackground(Color.gray.opacity(0.2))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .navigationTitle("スケジュール")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ScheduleAddView()) {
                        Text("追加")
                    }
                }
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
