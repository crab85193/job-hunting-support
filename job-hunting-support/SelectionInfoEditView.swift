//
//  SelectionInfoEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct SelectionInfoEditView: View {
    
    //画面遷移
    @Environment(\.presentationMode) var presentationMode
    
    enum AlertType {
       case alert1
       case alert2
    }
    
    @State var response = ""
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    
    @Binding var selectioninfo: Selection
    
    @Binding var CompanyList : [Corporate_info]
    
    @State private var editedselectioninfo: Selection
    
    init(selection: Binding<Selection>, corporateList: Binding<[Corporate_info]>){
        _selectioninfo = selection
        _CompanyList = corporateList
        _editedselectioninfo = State(initialValue: selection.wrappedValue)
    }

    var body: some View {
        VStack{
            HStack{
                Text("企業情報")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $editedselectioninfo.corporate_info, label: Text("企業情報")) {
                    ForEach(CompanyList) { Company in
                        Text("\(Company.name)").tag(Company.id)
                    }
                }
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)

            HStack{
                Text("合否")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $editedselectioninfo.result, label: Text("合否")) {
                    Text("未選択").tag("0")
                    Text("合格").tag("pass")
                    Text("不合格").tag("fail")
                    Text("保留").tag("none")
                }
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)

            HStack{
                VStack{
                    Text("メモ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $editedselectioninfo.memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .frame(width: 350, height: 200)
                }.padding()
            }
            .navigationTitle("選考情報の編集")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("保存") {
                if (((editedselectioninfo.corporate_info != "") && (editedselectioninfo.corporate_info != "0")) && ((editedselectioninfo.result != "") && (editedselectioninfo.result != "0"))) {
                    apiCall().editSelectionInfoToServer(id: selectioninfo.id, userID: selectioninfo.user_info, corporate_info: editedselectioninfo.corporate_info, result: editedselectioninfo.result, memo: editedselectioninfo.memo){ response in
                        self.response = response
                        if response == "OK" {
                            selectioninfo = editedselectioninfo
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
                        return Alert(title: Text("すべての必須項目\n（企業情報、合否）\nを選択してください。"))
                }
            })
        }
    }
}

/*
 struct SelectionInfoEditView_Previews: PreviewProvider {
 static var previews: some View {
 SelectionInfoEditView()
 }
 }
 */
