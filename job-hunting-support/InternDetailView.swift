//
//  InternDetailView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/06.
//
import SwiftUI

struct InternDetailView: View {

    //表示確認用
    @State var testCompanyName = ""
    @State var testMemo = ""
    @State var testStartDate = Date()
    @State var testFinishDate = Date()
    private let dateFormatter = DateFormatter()
    init(){
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("企業名")
                    TextField("企業名", text: $testCompanyName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        .padding(.horizontal)  // 余白を追加
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)

                HStack{
                    Text("インターン\n開始日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $testStartDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .labelsHidden()
                }
                .padding(.all, 20)

                HStack{
                    Text("インターン\n終了日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $testFinishDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
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
                .padding(.bottom, 30)
            }
            .navigationTitle("インターンの詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InternEditView()) {
                        Text("編集")
                    }
                }
            }
        }
    }
}

struct InternDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternDetailView()
    }
}
