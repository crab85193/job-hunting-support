//
//  SelectionInfoDetailView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/06.
//

import SwiftUI

struct SelectionInfoDetailView: View {
    
    @State var CompanyList : [Corporate_info]
    @Binding var SelectionInfo : Selection
    
    init(companyList: [Corporate_info], selection: Binding<Selection>){
        _SelectionInfo = selection
        CompanyList = companyList
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("企業名")
                    .font(.headline)
                    .padding()
                if let viewCompany = CompanyList.first(where: {$0.id == SelectionInfo.corporate_info}){
                    Text("\(viewCompany.name)")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text("未選択")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            
            /*
             こちらにする可能性あり(本選考の詳細画面から、企業情報の詳細を確認できる)
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
             */
            HStack{
                Text("合否")
                    .font(.headline)
                    .padding()
                if SelectionInfo.result != "" {
                    if SelectionInfo.result == "0"{
                        Text("未選択")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else if SelectionInfo.result == "pass"{
                        Text("合格")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else if SelectionInfo.result == "fail"{
                        Text("不合格")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    } else if SelectionInfo.result == "none"{
                        Text("保留")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                } else {
                    Text("未選択")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            
            VStack{
                Text("メモ")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                if (SelectionInfo.memo != "") {
                    Text(SelectionInfo.memo)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                        .padding(.leading)
                        .padding(.trailing)
                } else {
                    Text("記録なし")
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                        .padding(.leading)
                        .padding(.trailing)
                }

            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            
            .navigationTitle("選考情報の詳細")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SelectionInfoEditView(selection: $SelectionInfo, corporateList: $CompanyList)) {
                        Text("編集")
                    }
                }
            }
        }
    }
}

/*
 struct SelectionInfoDetailView_Previews: PreviewProvider {
 static var previews: some View {
 SelectionInfoDetailView()
 }
 }
 */
