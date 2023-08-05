//
//  SelectionInfoView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct SelectionInfoView: View {
    
    //カレンダー表示に関する変数
    @State var date = Date()
    private let dateFormatter = DateFormatter()
    init(){
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }
    
    var body: some View {
        NavigationView{
            List{
                //ここに選考情報
                Section(/*header: Text("選考情報").font(.title3)*/){
                    Text("選考中の企業はありません。")
                        .listRowBackground(Color.gray.opacity(0.2))
                }
                
                //カレンダーセクション
                Section(header: Text("カレンダー").font(.title3)){
                    DatePicker("Calendar", selection: $date)
                        .labelsHidden()
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(width: 300, height: 400)
                    //Text(dateFormatter.string(from: date))
                    //    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color.gray.opacity(0.2))
            }
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .navigationTitle("選考情報")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SelectionInfoAddView()) {
                        Text("追加")
                    }
                }
            }
        }
    }
}

struct SelectionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionInfoView()
    }
}
