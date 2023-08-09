//
//  ScheduleEditView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct ScheduleEditView: View {

    enum AlertType {
       case alert1
       case alert2
    }
    
    @State var response = ""
    @State var alertType: AlertType = .alert1
    @State var showAlert = false
    @State var showbar = false
    
    @State var CategoryList = LoadCategoryData()
    
    @Binding var ScheduleInfo: Schedule
    
    @Binding var CompanyList: [Corporate_info]
    @Binding var InternList: [Internship_info]
    
    @State private var editedSchedule: Schedule
    @State private var editedStartDate: Date = Date()
    @State private var editedFinishDate: Date = Date()
    
    private let dateFormatter = DateFormatter()
    
    init(scheduleinfo: Binding<Schedule>, companylist: Binding<[Corporate_info]>, internlist: Binding<[Internship_info]>){
        _ScheduleInfo = scheduleinfo
        _CompanyList = companylist
        _InternList = internlist
        _editedSchedule = State(initialValue: scheduleinfo.wrappedValue)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
        _editedStartDate = State(initialValue: dateFormatter.date(from: scheduleinfo.wrappedValue.start) ?? Date())
        _editedFinishDate = State(initialValue: dateFormatter.date(from: scheduleinfo.wrappedValue.end) ?? Date())

    }
    @State private var selection1 = 1
    @State private var selection2 = 1
    @State private var categorySelection = 1
    //画面遷移
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView{
            VStack {
                Text("スケジュール名")
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                TextField("スケジュール名", text:$editedSchedule.title)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .autocapitalization(.none)
            }

            HStack{
                Text("カテゴリー")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $editedSchedule.schedule_category, content: {
                    ForEach(CategoryList) { category in
                        Text("\(category.name)").tag(category.id)
                    }
                }, label: { Text("カテゴリー") })
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)
            
            HStack{
                Text("インターン情報")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $editedSchedule.internship_info, content: {
                    ForEach(InternList) { intern in
                        if let viewCompany = CompanyList.first(where: {$0.id == intern.corporate_info}) {
                            Text("\(viewCompany.name)").tag(intern.id)
                        }
                        
                    }
                }, label: { Text("インターン情報") })
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)
            
            HStack{
                Text("企業情報")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker(selection: $editedSchedule.corporate_info, content: {
                    ForEach(CompanyList) { company in
                        Text("\(company.name)").tag(company.id)
                    }
                }, label: { Text("企業情報") })
                .frame(width: 200)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 20)
            
            HStack{
                Text("スケジュール開始日")
                    .frame(maxWidth: .infinity, alignment: .leading)
                DatePicker("Calendar", selection: $editedStartDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                    .labelsHidden()
            }
            .padding(.all, 20)
            
            HStack{
                Text("スケジュール終了日")
                    .frame(maxWidth: .infinity, alignment: .leading)
                DatePicker("Calendar", selection: $editedFinishDate, displayedComponents: .date).environment(\.locale, Locale(identifier: "ja_JP"))
                    .labelsHidden()
            }
            .padding(.all, 20)
            
            HStack{
                VStack{
                    Text("メモ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $editedSchedule.memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                        .frame(width: 350, height: 200)
                }.padding()
            }
        }
        .navigationTitle("スケジュールを編集")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("保存") {
            if ((editedSchedule.title != "") && ((editedSchedule.schedule_category != "") && (editedSchedule.schedule_category != "0")) && ((editedSchedule.corporate_info != "") && (editedSchedule.corporate_info != "0")) && ((editedSchedule.internship_info != "") && (editedSchedule.internship_info != "0"))) {
                let StartDateString = dateFormatter.string(from: editedStartDate)
                let EndDateString = dateFormatter.string(from: editedFinishDate)
                apiCall().editScheduleInfoToServer(id: ScheduleInfo.id, title: editedSchedule.title, userID: ScheduleInfo.id, schedule_category: editedSchedule.schedule_category, internship_info: editedSchedule.internship_info, corporate_info: editedSchedule.corporate_info, start_date: StartDateString, end_date: EndDateString, memo: editedSchedule.memo){ response in
                    self.response = response
                    if response == "OK"{
                        ScheduleInfo = editedSchedule
                        DispatchQueue.main.async {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        print("Error in Response")
                        alertType = .alert1
                        showAlert.toggle()
                    }
                }
            }else {
                print("Notfull")
                alertType = .alert2
                showAlert.toggle()
            }
        }.alert(isPresented: $showAlert) {
            switch alertType {
                case .alert1:
                    return Alert(title: Text("エラーが発生しました。もう一度行ってください。"))
                case .alert2:
                    return Alert(title: Text("すべての必須項目\n（スケジュール名、カテゴリー、企業情報、インターン情報）\nを入力または選択してください。"))
            }
        })
    }
}

/*
 struct ScheduleEditView_Previews: PreviewProvider {
 static var previews: some View {
 ScheduleEditView()
 }
 }
 */
