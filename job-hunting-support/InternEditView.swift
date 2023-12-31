//
//  InternEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//
import SwiftUI

struct InternEditView: View {

    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    enum AlertType {
       case alert1
       case alert2
    }
    
    @State var response = ""
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    
    @Binding var interninfo: Internship_info
    
    @Binding var CompanyList : [Corporate_info]
    
    @State private var editedinterninfo: Internship_info
    @State private var editedStartDate: Date = Date()
    @State private var editedEndDate: Date = Date()
    
    private let dateFormatter = DateFormatter()
    
    init(interninfo: Binding<Internship_info>, corporatelist: Binding<[Corporate_info]>){
        _interninfo = interninfo
        _CompanyList = corporatelist
        _editedinterninfo = State(initialValue: interninfo.wrappedValue)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        _editedStartDate = State(initialValue: dateFormatter.date(from: interninfo.wrappedValue.start) ?? Date())
        //print(editedStartDate)
        _editedEndDate = State(initialValue: dateFormatter.date(from: interninfo.wrappedValue.end) ?? Date())
        //print(editedEndDate)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("企業名")
                        .padding()
                        .frame(width: 100)
                    Section{
                        Picker(selection: $editedinterninfo.corporate_info, content: {
                            ForEach(CompanyList) { company in
                                Text("\(company.name)").tag(company.id)
                            }
                        }, label: { Text("企業名") }).pickerStyle(MenuPickerStyle())
                    }
                    .autocapitalization(.none)
                    .frame(width: 250, height:50)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                    .padding()
                    Spacer()
                }

                HStack{
                    Text("インターン開始日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $editedStartDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .labelsHidden()
                }.padding()

                HStack{
                    Text("インターン終了日")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Calendar", selection: $editedEndDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                        .labelsHidden()
                }.padding()
                
                VStack{
                    Text("メモ")
                        .frame(width: 340, alignment: .leading)
                    TextEditor(text:$editedinterninfo.memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .frame(width: 350, height: 200)
                }.padding()
                
                .navigationTitle("インターン情報　編集")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("保存") {
                    if ((editedinterninfo.corporate_info != "") && (editedinterninfo.corporate_info != "0")) {
                        let editedStartDateString = dateFormatter.string(from: editedStartDate)
                        editedinterninfo.start = editedStartDateString
                        let editedEndDateString = dateFormatter.string(from: editedEndDate)
                        editedinterninfo.end = editedEndDateString
                        apiCall().editInternshipInfoToServer(id: interninfo.id, userID: interninfo.id, corporate_info: editedinterninfo.corporate_info, start_date: editedinterninfo.start, end_date: editedinterninfo.end, memo: editedinterninfo.memo) { response in
                            self.response = response
                            if response == "OK" {
                                interninfo = editedinterninfo
                                DispatchQueue.main.async {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            } else {
                                //print("Error in Response")
                                alertType = .alert1
                                showAlert.toggle()
                            }
                        }
                    } else {
                        //print("Notfull")
                        alertType = .alert2
                        showAlert.toggle()
                    }
                }.alert(isPresented: $showAlert) {
                    switch alertType {
                        case .alert1:
                            return Alert(title: Text("エラーが発生しました。もう一度行ってください。"))
                        case .alert2:
                            return Alert(title: Text("すべての必須項目\n（企業名、開始日、終了日）\nを入力または選択してください。"))
                    }
                })
            }
        }
    }
}

/*
 struct InternEditView_Previews: PreviewProvider {
 static var previews: some View {
 InternEditView()
 }
 }
 */
