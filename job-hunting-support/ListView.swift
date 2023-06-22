//
//  ListView.swift
//  job-hunting-support
//  
//  Created by 宮平保 on 2023/06/22
//  
//

import SwiftUI

struct ListView: View {
    @State var CompanyList: [Company] = [
        Company(name: "A", industry: "X", employees: 1000),
        Company(name: "B", industry: "Y", employees: 2000),
        Company(name: "C", industry: "Z", employees: 4000)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(CompanyList) { company in
                    NavigationLink(destination: CompanyDetailsView(company: binding(for: company))) {
                        Text(company.name)
                    }
                }
                .onDelete(perform: deletecompany)
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
    
    private func binding(for company: Company) -> Binding<Company> {
        guard let companyIndex = CompanyList.firstIndex(of: company) else {
            fatalError("Person not found")
        }
        return $CompanyList[companyIndex]
    }
    
    private func deletecompany(at offsets: IndexSet) {
            CompanyList.remove(atOffsets: offsets)
    }
}

struct CompanyDetailsView: View {
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
            TextField("Industry", text:$newCompanyIndustry)
            TextField("Employees Number", value:$newCompanyEmployees, format: .number)
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
            TextField("Occupation", text: $editedCompany.industry)
            TextField("Employees Number", value:$editedCompany.employees, format: .number)
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
