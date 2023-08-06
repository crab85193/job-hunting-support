//
//  EditCompanyView.swift
//  job-hunting-support
//
//  Created by ibu.m ev on 2023/08/03.
//

import SwiftUI

//企業データの編集
struct CompanyEditView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    //編集する企業を保持する変数
    @Binding var company: Corporate_info
    
    //職種、業種のリスト
    @Binding var industryList: [Industry]
    @Binding var occupationList: [Occupation]
    
    //編集前の企業データを保存する変数
    @State private var editedCompany: Corporate_info
    @State private var editedmemo: String
    @State private var editedDate: Date = Date()
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    //各種パラメータの初期化
    init(company: Binding<Corporate_info>, industryList: Binding<[Industry]>, occupationList: Binding<[Occupation]>) {
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
                    .padding()
                    .frame(width: 100)
                TextField("企業名", text:$editedCompany.name)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 280)
                    .autocapitalization(.none)
                Spacer()
            }
            HStack{
                Text("業種")
                    .padding()
                    .frame(width: 100)
                Section{
                    Picker(selection: $editedCompany.industry, content: {
                        ForEach(industryList) { industry in
                            Text("\(industry.name)").tag(industry.id)
                        }
                    }, label: { Text("業種") }).pickerStyle(MenuPickerStyle())
                }
                .autocapitalization(.none)
                .frame(width: 250, height:50)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                .padding()
                Spacer()
            }
            HStack{
                Text("職種")
                    .padding()
                    .frame(width: 100)
                Section{
                    Picker(selection: $editedCompany.occupation, content: {
                        ForEach(occupationList) { occupation in
                            Text("\(occupation.name)").tag(occupation.id)
                        }
                    }, label: { Text("職種") }).pickerStyle(MenuPickerStyle())
                }
                .autocapitalization(.none)
                .frame(width: 250, height:50)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                .padding()
                Spacer()
            }
            Group{
                HStack{
                    VStack{
                        Text("事業内容")
                            .frame(width: 350, alignment: .leading)
                        TextEditor(text: $editedCompany.business)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .frame(width: 350, height: 200)
                    }.padding()
                }
                HStack{
                    DatePicker("設立日", selection: $editedDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .padding()
                        .frame(width: 380)
                }
                HStack{
                    Text("従業員数")
                        .padding()
                        .frame(width: 100)
                    TextField("従業員数", text:$editedCompany.employees)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 280)
                        .autocapitalization(.none)
                }
                HStack{
                    Text("資本金")
                        .padding()
                        .frame(width: 100)
                    TextField("資本金", text:$editedCompany.capital)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 280)
                        .autocapitalization(.none)
                }
                HStack{
                    Text("売上高")
                        .padding()
                        .frame(width: 100)
                    TextField("売上高", text:$editedCompany.sales)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 280)
                        .autocapitalization(.none)
                }
                HStack{
                    Text("営業利益")
                        .padding()
                        .frame(width: 100)
                    TextField("営業利益", text:$editedCompany.operating_income)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 280)
                        .autocapitalization(.none)
                }
                HStack{
                    Text("代表者")
                        .padding()
                        .frame(width: 100)
                    TextField("山田 太郎", text:$editedCompany.representative)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 280)
                        .autocapitalization(.none)
                }
                HStack{
                    VStack{
                        Text("所在地")
                            .frame(width: 340, alignment: .leading)
                        TextField("沖縄県中頭郡西原町字千原1番地", text:$editedCompany.location)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 350)
                            .autocapitalization(.none)
                    }.padding()
                }
                HStack{
                    VStack{
                        Text("メモ")
                            .frame(width: 340, alignment: .leading)
                        TextEditor(text: $editedmemo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .frame(width: 350, height: 200)
                    }.padding()
                }
            }
            
        }
        .navigationTitle("企業リスト 編集")
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
