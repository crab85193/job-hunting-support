//
//  ListView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/06/22
//
//

import SwiftUI

struct ListView: View {
    
    //テスト動作用のユーザー、業種、職種
    var testUser = user(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31")
    
    @State var testindustry = [
        industry(name:"未選択"),
        industry(name:"プログラマー"),
        industry(name: "WEBエンジニア"),
        industry(name: "インフラエンジニア")
    ]
    
    @State var testoccupation = [
        occupation(name:"未選択"),
        occupation(name: "正社員"),
        occupation(name:"契約社員"),
        occupation(name:"パート")
    ]
    
    //企業リスト
    @State var CompanyList = [corporate_info]()
    
    //削除のアラートの管理するフラグ
    @State var deleteAlert: Bool = false
    
    //削除する項目のindexを保持する変数
    @State private var deleteIndexSet: IndexSet?
    
    var body: some View {
        NavigationView {
            List {
                //企業のリスト表示
                ForEach(CompanyList) { company in
                    NavigationLink(destination: CompanyDetailsView(company: binding(for: company), industryList: $testindustry, occupationList: $testoccupation)) {
                        Text(company.name)
                    }
                }
                //削除ボタン
                .onDelete { indexSet in
                    deleteIndexSet = indexSet
                    deleteAlert = true
                }
                //削除前のアラート
                .alert(isPresented: $deleteAlert) {
                    Alert(
                        title: Text("本当に削除しますか？"),
                        message: Text("削除すると、そのデータを復元することはできません"),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("削除"), action: {
                            if let indexSet = deleteIndexSet {
                                deleteSelectedCompanies(at: indexSet)
                                deleteIndexSet = nil
                            }
                        })
                    )
                }
            }
            .navigationTitle("企業リスト")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddCompanyView(userid:testUser.id, companyList: $CompanyList, industryList: testindustry, occupationList: testoccupation)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    //選択したCompanyの前処理
    private func binding(for company: corporate_info) -> Binding<corporate_info> {
        guard let companyIndex = CompanyList.firstIndex(of: company) else {
            fatalError("Person not found")
        }
        return $CompanyList[companyIndex]
    }
    
    //削除前のアラートを呼び出す
    private func deletecompany(at offsets: IndexSet) {
        deleteAlert = true
    }
    
    //項目の削除を行う
    private func deleteSelectedCompanies(at indexSet: IndexSet) {
        CompanyList.remove(atOffsets: indexSet)
    }
}

//企業データの詳細表示
struct CompanyDetailsView: View {
    //詳細表示する企業を保持する変数
    @Binding var company: corporate_info
    @Binding var industryList : [industry]
    @Binding var occupationList : [occupation]
    
    //日付関連
    let dateFormatter = DateFormatter()
    
    //各パラメータの初期化
    init(company: Binding<corporate_info>, industryList: Binding<[industry]>, occupationList: Binding<[occupation]>) {
        _company = company
        _industryList = industryList
        _occupationList = occupationList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
    }
    
    var body: some View {
        ScrollView{
            HStack{
                Text("業種")
                    //.font(.title2)
                    .padding()
                if let viewindustry = industryList.first(where: {$0.id == company.industry}){
                    Text("\(viewindustry.name)")
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text("未選択")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            HStack{
                Text("職種")
                    //.font(.title2)
                    .padding()
                if let viewoccupation = occupationList.first(where: {$0.id == company.occupation}){
                    Text("\(viewoccupation.name)")
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text("未選択")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            Group{
                VStack{
                    Text("事業内容")
                        //.font(.title2)
                        .padding()
                    Text(company.business)
                        .fixedSize(horizontal: false, vertical: true)
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding()
                }
                HStack{
                    Text("設立日")
                        //.font(.title2)
                        .padding()
                    Text(company.establishment)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("従業員数")
                        //.font(.title2)
                        .padding()
                    Text("\(company.employees)人")
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("資本金")
                        //.font(.title2)
                        .padding()
                    Text("\(company.capital)円")
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("売上高")
                        //.font(.title2)
                        .padding()
                    Text("\(company.sales)円")
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("営業利益")
                        //.font(.title2)
                        .padding()
                    Text("\(company.operating_income)円")
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("代表者")
                        //.font(.title2)
                        .padding()
                    Text(company.representative)
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("所在地")
                        //.font(.title2)
                        .padding()
                    Text(company.location)
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack{
                    Text("メモ")
                        //.font(.title2)
                        .padding()
                    Text(company.memo)
                        .fixedSize(horizontal: false, vertical: true)
                        //.font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding()
                }
            }
        }
        .navigationTitle("\(company.name)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditCompanyView(company: $company, industryList: $industryList, occupationList: $occupationList)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

/*
 
 struct CompanyDetailsView: View {
 //詳細表示する会社を保持する変数
 @Binding var company: corporate_info
 @Binding var industryList : [industry]
 @Binding var occupationList : [occupation]
 
 var body: some View {
 ScrollView{
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 Text("従業員数: \(company.employees)").font(.title3)
 .padding()
 .frame(maxWidth: .infinity, alignment: .leading)
 
 NavigationLink(destination: EditCompanyView(company: $company, industryList: $industryList, occupationList: $occupationList)) {
 Text("Edit")
 }
 }
 .navigationTitle("\(company.name)")
 }
 }
 */

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
        .navigationBarItems(trailing: Button("編集を保存") {
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
