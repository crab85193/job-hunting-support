//
//  SelectionInfoAddView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct SelectionInfoAddView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    //新規作成時の初期値
    @State private var companySelection = "1"
    @State private var resultSelection = "1"
    @State var newMemo = ""

    var body: some View {
        VStack{
            HStack{
                Text("企業情報")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $companySelection, label: Text("企業情報")) {
                    Text("未選択").tag("1")
                    Text("企業リスト1").tag("2")
                    Text("企業リスト2").tag("3")
                    Text("企業リスト3").tag("4")
                    Text("企業リスト4").tag("5")
                }
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)

            HStack{
                Text("合否")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $resultSelection, label: Text("企業情報")) {
                    Text("未選択").tag("1")
                    Text("合格").tag("2")
                    Text("不合格").tag("3")
                    Text("保留").tag("4")
                }
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)
            
            HStack{
                VStack{
                    Text("メモ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $newMemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .frame(width: 350, height: 200)
                }.padding()
            }
            .navigationTitle("選考情報の追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("作成") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SelectionInfoAddView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionInfoAddView()
    }
}
