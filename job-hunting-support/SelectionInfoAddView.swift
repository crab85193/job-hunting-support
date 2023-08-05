//
//  SelectionInfoAddView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct SelectionInfoAddView: View {

    //テスト用
    @State private var selection = 1
    @State private var resultselection = 1
    @State var testSelectionInfoMemo = ""

    var body: some View {
        VStack{
            HStack{
                Text("企業情報")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $selection, label: Text("企業情報")) {
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
                Text("合否")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $resultselection, label: Text("企業情報")) {
                    Text("未確定").tag(1)
                    Text("合格").tag(2)
                    Text("不合格").tag(3)
                    Text("保留").tag(4)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)

            HStack{
                Text("メモ")
                    .padding()
                TextField("メモ", text:$testSelectionInfoMemo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
            }
        }
    }
}

struct SelectionInfoAddView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionInfoAddView()
    }
}
