//
//  InternEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct InternEditView: View {

    //表示確認用
    @State var testCompanyName = ""
    @State var testMemo = ""
    @State var testStartDate = Date()
    @State var testFinishDate = Date()
    private let dateFormatter = DateFormatter()
    init(){
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            HStack{
                Text("企業名")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("企業名", text: $testCompanyName)
                    .frame(width: 250)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                
            }
            .padding()

            HStack{
                Text("インターン開始日")
                    .frame(maxWidth: .infinity, alignment: .leading)
                DatePicker("Calendar", selection: $testStartDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                    .labelsHidden()
            }
            .padding()

            HStack{
                Text("インターン終了日")
                    .frame(maxWidth: .infinity, alignment: .leading)
                DatePicker("Calendar", selection: $testFinishDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                    .labelsHidden()
            }
            .padding()
            
            HStack{
                VStack{
                    Text("メモ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $testMemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .frame(width: 350, height: 200)
                }.padding()
            }
            
            .navigationTitle("リストを追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("追加") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct InternEditView_Previews: PreviewProvider {
    static var previews: some View {
        InternEditView()
    }
}
