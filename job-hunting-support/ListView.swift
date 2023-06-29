//
//  ListView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct ListView: View {
    
    @State var CompanyList = [Company]()
    
    //削除のアラートの管理するフラグ
    @State var deleteAlert: Bool = false
    
    //削除する項目のindexを保持する変数
    @State private var deleteIndexSet: IndexSet?

    var body: some View {
        NavigationView {
            List {
                //会社のリスト表示
                ForEach(CompanyList) { company in
                    NavigationLink(destination: CompanyDetailsView(company: binding(for: company))) {
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
                    NavigationLink(destination: AddCompanyView(companyList: $CompanyList)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    //選択したCompanyの前処理
    private func binding(for company: Company) -> Binding<Company> {
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
    @Binding var company: Company

    var body: some View {
        VStack {
            Text("企業名: \(company.name)").font(.largeTitle).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("業種: \(company.industry)").font(.title3)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("従業員数: \(company.employees)").font(.title3)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            NavigationLink(destination: EditCompanyView(company: $company)) {
                Text("Edit")
            }
        }
        .navigationTitle("詳細情報")
    }
}

struct AddCompanyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var companyList: [Company]
    
    @State var newCompanyName = ""
    @State var newCompanyIndustry = ""
    @State var newCompanyEmployees = 0
    
    var body: some View {
        Form {
            TextField("Name", text:$newCompanyName)
                .autocapitalization(.none)
            TextField("Industry", text:$newCompanyIndustry)
                .autocapitalization(.none)
            TextField("Employees Number", value:$newCompanyEmployees, format: .number)
                .autocapitalization(.none)
        }
        .navigationTitle("Add Company")
        .navigationBarItems(trailing: Button("Save") {
            
            companyList.append(Company(name: newCompanyName, industry: newCompanyIndustry, employees: newCompanyEmployees))
            
            newCompanyName = ""
            newCompanyIndustry = ""
            newCompanyEmployees = 0
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct EditCompanyView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var company: Company
    @State private var editedCompany: Company

    init(company: Binding<Company>) {
        _company = company
        _editedCompany = State(initialValue: company.wrappedValue)
    }

    var body: some View {
        Form {
            TextField("Name", text: $editedCompany.name)
                .autocapitalization(.none)
            TextField("Occupation", text: $editedCompany.industry)
                .autocapitalization(.none)
            TextField("Employees Number", value:$editedCompany.employees, format: .number)
                .autocapitalization(.none)
        }
        .navigationTitle("Edit Company")
        .navigationBarItems(trailing: Button("Save") {
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
