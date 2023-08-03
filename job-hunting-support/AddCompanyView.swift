//
//  AddCompanyView.swift
//  job-hunting-support
//
//  Created by ibu.m ev on 2023/08/03.
//

import SwiftUI

//新規企業データの作成
struct AddCompanyView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    var userid: String //ユーザーID
    @Binding var companyList: [corporate_info] //企業リスト
    var industryList: [industry] //職種リスト
    var occupationList: [occupation] //業種リスト
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //各種パラメータの初期化
    init(userid: String,companyList: Binding<[corporate_info]>, industryList: [industry], occupationList: [occupation]) {
        self.userid = userid
        self.industryList = industryList
        self.occupationList = occupationList
        _companyList = companyList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    //新規作成時の初期値
    @State private var newName = ""
    @State private var selectindustry: String = ""
    @State private var selectoccupation: String = ""
    @State private var newbusiness = ""
    @State private var selectionDate = Date()
    @State private var newEmployees = 0
    @State private var newcapital = 0
    @State private var newsales = 0
    @State private var newincome = 0
    @State private var newrepresentative = ""
    @State private var newlocation = ""
    @State private var newmemo = ""
    @State private var currentdate = Date()
    
    //キーボードの利用検知
    @FocusState  var isActive:Bool
    
    var body: some View {
        ScrollView{
            HStack{
                Text("企業名")
                    //.font(.title)
                    .padding()
                TextField("株式会社タカアシガニ", text:$newName)
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
                    Picker(selection: $selectindustry, content: {
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
                    Picker(selection: $selectoccupation, content: {
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
                    TextField("事業内容を書いてください。", text:$newbusiness)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
                HStack{
                    DatePicker("設立日", selection: $selectionDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        //.font(.title2)
                        .padding()
                }
                HStack{
                    Text("従業員数")
                        //.font(.title2)
                        .padding()
                    TextField("従業員数", value:$newEmployees, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("資本金")
                        //.font(.title2)
                        .padding()
                    TextField("資本金", value:$newcapital, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("売上高")
                        //.font(.title2)
                        .padding()
                    TextField("売上高", value:$newsales, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("営業利益")
                        //.font(.title2)
                        .padding()
                    TextField("営業利益", value:$newincome, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("代表者")
                        //.font(.title2)
                        .padding()
                    TextField("山田 太郎", text:$newrepresentative)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("所在地")
                        //.font(.title2)
                        .padding()
                    TextField("沖縄県中頭郡西原町字千原1番地", text:$newlocation)
                        .focused($isActive)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("メモ")
                        //.font(.title2)
                        .padding()
                    TextField("メモ", text:$newmemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isActive)
                        .padding()
                        .autocapitalization(.none)
                }
            }
        }
        .navigationTitle("新規作成")
        .navigationBarItems(trailing: Button("作成") {
            //新規企業データの作成
            companyList.append(corporate_info(user: userid, name: newName, Industry: selectindustry, Occupation: selectoccupation, business: newbusiness, establishment: dateFormatter.string(from: selectionDate), employees: String(newEmployees), capital: String(newcapital), sales: String(newsales), operating_income: String(newincome), representative: newrepresentative, location: newlocation, registration: dateFormatter.string(from: currentdate), memo: newmemo))
            
            //企業データ入力部分の初期化
            newName = ""
            newbusiness = ""
            selectionDate = Date()
            newEmployees = 0
            newcapital = 0
            newsales = 0
            newincome = 0
            newrepresentative = ""
            newlocation = ""
            newmemo = ""
            currentdate = Date()
            
            //企業リスト画面に戻る
            presentationMode.wrappedValue.dismiss()
        })
        .toolbar {
            //キーボードを閉じるボタン
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()         // 右寄せにする
                Button("閉じる") {
                    isActive = false  //  フォーカスを外す
                }
            }
        }
        Spacer()
    }
}
