//
//  ScheduleAddView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct ScheduleAddView: View {
    
    //表示確認用
    @State var scheduleName = ""
    @State var testMemo = ""
    @State var testCompanyName = ""
    @State var testStartDate = Date()
    @State var testFinishDate = Date()
    private let dateFormatter = DateFormatter()
    init(){
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }
    @State private var selection1 = 1
    @State private var selection2 = 1
    @State private var categorySelection = 1
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("スケジュール名")
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                TextField("スケジュール名", text:$scheduleName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .autocapitalization(.none)
                
                HStack{
                    Text("カテゴリー")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $categorySelection, label: Text("インターン情報")) {
                        Text("なし").tag(1)
                        Text("カテゴリー1").tag(2)
                        Text("カテゴリー2").tag(3)
                        Text("カテゴリー3").tag(4)
                        Text("カテゴリー4").tag(5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)
                
                HStack{
                    Text("インターン情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $selection1, label: Text("インターン情報")) {
                        Text("なし").tag(1)
                        Text("インターンリスト1").tag(2)
                        Text("インターンリスト2").tag(3)
                        Text("インターンリスト3").tag(4)
                        Text("インターンリスト4").tag(5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)
                
                HStack{
                    Text("企業情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $selection2, label: Text("企業情報")) {
                        Text("なし").tag(1)
                        Text("企業リスト1").tag(2)
                        Text("企業リスト2").tag(3)
                        Text("企業リスト3").tag(4)
                        Text("企業リスト4").tag(5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 20)
                
                HStack{
                    Text("スケジュール\n開始日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $testStartDate, displayedComponents: .date)
                        .labelsHidden()
                }
                .padding(.all, 20)
                
                HStack{
                    Text("スケジュール\n終了日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $testFinishDate, displayedComponents: .date)
                        .labelsHidden()
                }
                .padding(.all, 20)
                
                HStack{
                    Text("メモ")
                        //.font(.title2)
                        .padding()
                    TextField("メモ", text:$testMemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("スケジュールを追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("作成") {
                //企業リスト画面に戻る
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ScheduleAddView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleAddView()
    }
}
