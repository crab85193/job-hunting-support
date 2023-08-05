//
//  EditCompanyView.swift
//  job-hunting-support
//
//  Created by ibu.m ev on 2023/08/03.
//

import SwiftUI

//企業データの編集
struct EditCompanyView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    //編集する企業を保持する変数
    @Binding var company: corporate_info
    
    //職種、業種のリスト
    @Binding var industryList: [industry]
    @Binding var occupationList: [occupation]
    
    //編集前の企業データを保存する変数
    @State private var editedCompany: corporate_info
    @State private var editedmemo: String
    @State private var editedDate: Date = Date()
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    //各種パラメータの初期化
    init(company: Binding<corporate_info>, industryList: Binding<[industry]>, occupationList: Binding<[occupation]>) {
        _company = company
        _industryList = industryList
        _occupationList = occupationList
        _editedCompany = State(initialValue: company.wrappedValue)
        _editedmemo = State(initialValue: company.wrappedValue.memo)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.editedDate = dateFormatter.date(from: editedCompany.establishment) ?? Date()
    }
    
    var body: some View {
        ScrollView{
            HStack{
                Text("企業名")
                    //.font(.title)
                    .padding()
                TextField("企業名", text:$editedCompany.name)
                    //.font(.title)
                    .focused($isActive)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
            }
            HStack{
                Text("業種")
                    //.font(.title2)
                    .padding()
                Section{
                    Picker(selection: $editedCompany.industry, content: {
                        ForEach(industryList) { industry in
                            Text("\(industry.name)").tag(industry.id)
                        }
                    }, label: { Text("業種") }).pickerStyle(MenuPickerStyle())
                }.autocapitalization(.none)
            }
            HStack{
                Text("職種")
                    //.font(.title2)
                    .padding()
                Section{
                    Picker(selection: $editedCompany.occupation, content: {
                        ForEach(occupationList) { occupation in
                            Text("\(occupation.name)").tag(occupation.id)
                        }
                    }, label: { Text("職種") }).pickerStyle(MenuPickerStyle())
                }.autocapitalization(.none)
            }
            Group{
                HStack{
                    Text("事業内容")
                        //.font(.title2)
                        .padding()
                    TextField("事業内容", text:$editedCompany.business)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
                HStack{
                    DatePicker("設立日", selection: $editedDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        //.font(.title2)
                        .padding()
                }
                HStack{
                    Text("従業員数")
                        //.font(.title2)
                        .padding()
                    TextField("従業員数", text: $editedCompany.employees)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("資本金")
                        //.font(.title2)
                        .padding()
                    TextField("資本金", text: $editedCompany.capital)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("売上高")
                        //.font(.title2)
                        .padding()
                    TextField("売上高", text:$editedCompany.sales)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("営業利益")
                        //.font(.title2)
                        .padding()
                    TextField("営業利益", text:$editedCompany.operating_income)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("代表者")
                        //.font(.title2)
                        .padding()
                    TextField("代表者", text:$editedCompany.representative)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("所在地")
                        //.font(.title2)
                        .padding()
                    TextField("所在地", text:$editedCompany.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("メモ")
                        //.font(.title2)
                        .padding()
                    TextField("メモ", text:$editedmemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
            }
            
        }
        .navigationTitle("編集")
        .navigationBarItems(trailing: Button("保存") {
            //編集した部分を保存する
            editedCompany.memo = editedmemo
            editedCompany.establishment = dateFormatter.string(from: editedDate)
            company = editedCompany // 変更を反映させる
            
            //詳細表示画面へ遷移
            presentationMode.wrappedValue.dismiss()
        })
        .toolbar {
            //キーボードを閉じる
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()         // 右寄せにする
                Button("閉じる") {
                    isActive = false  //  フォーカスを外す
                }
            }
        }
    }
}
