//
//  SelectionInfoDetailView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/06.
//

import SwiftUI

struct SelectionInfoDetailView: View {

    //テスト用
    @State private var sompanySelection = "1"
    @State var viewCompanyDetail : Bool = false
    @State private var resultselection = "0"
    @State var selectionInfoMemo = ""
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("企業情報")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button(action: {
                        viewCompanyDetail = true
                        if viewCompanyDetail {
                            //選択した企業の詳細情報画面に遷移
                        }
                    }) {
                        Text("XX株式会社")
                    }
                     /*
                    Picker(selection: $companySelection, label: Text("企業情報")) {
                        Text("未選択").tag("1")
                        Text("企業リスト1").tag("2")
                        Text("企業リスト2").tag("3")
                        Text("企業リスト3").tag("4")
                        Text("企業リスト4").tag("5")
                    }
                      */
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 30)
                
                HStack{
                    Text("合否")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if resultselection == "2" {
                        Text("合格")
                    } else if resultselection == "1" {
                        Text("不合格")
                    } else {
                        Text("未選択")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 30)
                
                HStack{
                    Text("メモ")
                        .padding(30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("メモ", text:$selectionInfoMemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 220)
                        .padding(.trailing, 30)
                        .autocapitalization(.none)
                }
                .navigationTitle("スケジュールの詳細")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SelectionInfoEditView()) {
                            Text("編集")
                        }
                    }
                }
            }
        }
    }
}

struct SelectionInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionInfoDetailView()
    }
}
