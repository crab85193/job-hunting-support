//
//  ListView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/06/22
//
//

import SwiftUI

struct ListView: View {
    
    var testUser = user(name: "dummy", password: "01234", sex: "male", age: 20)
    
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
    
    @State var CompanyList = [corporate_info]()
    
    //削除のアラートの管理するフラグ
    @State var deleteAlert: Bool = false
    
    //削除する項目のindexを保持する変数
    @State private var deleteIndexSet: IndexSet?

    var body: some View {
        NavigationView {
            List {
                //会社のリスト表示
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
                        title: Text("Delete Company"),
                        message: Text("Are you sure you want to delete this company?"),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("Delete"), action: {
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

//データの詳細表示
struct CompanyDetailsView: View {
    //詳細表示する会社を保持する変数
    @Binding var company: corporate_info
    @Binding var industryList : [industry]
    @Binding var occupationList : [occupation]
    
    let dateFormatter = DateFormatter()
    
    init(company: Binding<corporate_info>, industryList: Binding<[industry]>, occupationList: Binding<[occupation]>) {
        _company = company
        _industryList = industryList
        _occupationList = occupationList
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
    }
    
    @State var viewDate: Date = Date()

    var body: some View {
        ScrollView{
            HStack{
                Text("業種")
                    .font(.title2)
                    .padding()
                if let viewindustry = industryList.first(where: {$0.id == company.industry}){
                    Text("業種: \(viewindustry.name)").font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("設定されていません。")
                }
            }
            HStack{
                Text("職種")
                    .font(.title2)
                    .padding()
                if let viewoccupation = occupationList.first(where: {$0.id == company.occupation}){
                    Text("職種: \(viewoccupation.name)").font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("設定されていません。")
                }
            }
            Group{
                VStack{
                    Text("事業内容")
                        .font(.title2)
                        .padding()
                    Text(company.business)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding()
                }
                HStack{
                    Text("設立日")
                        .font(.title2)
                        .padding()
                    Text(dateFormatter.string(from: company.establishment))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("従業員数")
                        .font(.title2)
                        .padding()
                    Text("\(company.employees)人")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("資本金")
                        .font(.title2)
                        .padding()
                    Text("\(company.capital)円")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("売上高")
                        .font(.title2)
                        .padding()
                    Text("\(company.sales)円")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("営業利益")
                        .font(.title2)
                        .padding()
                    Text("\(company.operating_income)円")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("代表者")
                        .font(.title2)
                        .padding()
                    Text(company.representative)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack{
                    Text("所在地")
                        .font(.title2)
                        .padding()
                    Text(company.location)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack{
                    Text("メモ")
                        .font(.title2)
                        .padding()
                    Text(company.memo)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding()
                }
            }
            
            
            NavigationLink(destination: EditCompanyView(company: $company, industryList: $industryList, occupationList: $occupationList)) {
                Text("Edit").font(.largeTitle)
            }
        }
        .navigationTitle("\(company.name)")
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


struct AddCompanyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var userid: UUID = UUID()
    @Binding var companyList: [corporate_info]
    var industryList: [industry]
    var occupationList: [occupation]
    
    @State private var newName = ""
    @State private var selectindustry: UUID = UUID()
    @State private var selectoccupation: UUID = UUID()
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
    
    var body: some View {
        ScrollView{
            HStack{
                Text("企業名")
                    .font(.title)
                    .padding()
                TextField("株式会社タカアシガニ", text:$newName)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
            }
            HStack{
                Text("業種")
                    .font(.title2)
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
                    .font(.title2)
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
                        .font(.title2)
                        .padding()
                    TextField("事業内容を書いてください。", text:$newbusiness)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
                HStack{
                    DatePicker("設立日", selection: $selectionDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .font(.title2)
                        .padding()
                }
                HStack{
                    Text("従業員数")
                        .font(.title2)
                        .padding()
                    TextField("従業員数", value:$newEmployees, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("資本金")
                        .font(.title2)
                        .padding()
                    TextField("資本金", value:$newcapital, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("売上高")
                        .font(.title2)
                        .padding()
                    TextField("売上高", value:$newsales, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("営業利益")
                        .font(.title2)
                        .padding()
                    TextField("営業利益", value:$newincome, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("代表者")
                        .font(.title2)
                        .padding()
                    TextField("山田 太郎", text:$newrepresentative)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("所在地")
                        .font(.title2)
                        .padding()
                    TextField("沖縄県中頭郡西原町字千原1番地", text:$newlocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("メモ")
                        .font(.title2)
                        .padding()
                    TextField("メモ", text:$newmemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
            }
        }
        .navigationTitle("新規作成")
        .navigationBarItems(trailing: Button("作成") {
            
            companyList.append(corporate_info(user: userid, name: newName, Industry: selectindustry, Occupation: selectoccupation, business: newbusiness, establishment: selectionDate, employees: newEmployees, capital: newcapital, sales: newsales, operating_income: newincome, representative: newrepresentative, location: newlocation, registration: currentdate, memo: newmemo))
            
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
            presentationMode.wrappedValue.dismiss()
        })
        
        Spacer()
    }
}

struct EditCompanyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var company: corporate_info
    @Binding var industryList: [industry]
    @Binding var occupationList: [occupation]
    
    @State private var editedCompany: corporate_info
    @State private var editedmemo: String

    init(company: Binding<corporate_info>, industryList: Binding<[industry]>, occupationList: Binding<[occupation]>) {
        _company = company
        _industryList = industryList
        _occupationList = occupationList
        _editedCompany = State(initialValue: company.wrappedValue)
        _editedmemo = State(initialValue: company.wrappedValue.memo)
    }

    var body: some View {
        ScrollView{
            HStack{
                Text("企業名")
                    .font(.title)
                    .padding()
                TextField("企業名", text:$editedCompany.name)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
            }
            HStack{
                Text("業種")
                    .font(.title2)
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
                    .font(.title2)
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
                        .font(.title2)
                        .padding()
                    TextField("事業内容", text:$editedCompany.business)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
                HStack{
                    DatePicker("設立日", selection: $editedCompany.establishment, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .font(.title2)
                        .padding()
                }
                HStack{
                    Text("従業員数")
                        .font(.title2)
                        .padding()
                    TextField("従業員数", value:$editedCompany.employees, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("資本金")
                        .font(.title2)
                        .padding()
                    TextField("資本金", value:$editedCompany.capital, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("売上高")
                        .font(.title2)
                        .padding()
                    TextField("売上高", value:$editedCompany.sales, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("営業利益")
                        .font(.title2)
                        .padding()
                    TextField("営業利益", value:$editedCompany.operating_income, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("代表者")
                        .font(.title2)
                        .padding()
                    TextField("代表者", text:$editedCompany.representative)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("所在地")
                        .font(.title2)
                        .padding()
                    TextField("所在地", text:$editedCompany.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
                HStack{
                    Text("メモ")
                        .font(.title2)
                        .padding()
                    TextField("メモ", text:$editedmemo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }
            }
            
        }
        .navigationTitle("編集")
        .navigationBarItems(trailing: Button("Save") {
            editedCompany.memo = editedmemo
            company = editedCompany // 変更を反映させる
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
