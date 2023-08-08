//
//  ScheduleView.swift
//  job-hunting-support
//
//  Created by 宮平保 on 2023/08/05.
//

import SwiftUI

struct ScheduleView: View {
    
    @State var ScheduleList = [Schedule]()
    
    @State var CompanyList = [Corporate_info]()
    
    @State var InternList = [Internship_info]()
    
    //ログインしているユーザーの情報
    @State var LoginUser: User = (LoadUserData() ?? User(name: "dummy", password: "01234", sex: "male", age: "20", graduate: "2023-03-31"))
    
    @State var deleteAlert: Bool = false
        
    @State var response = ""
    
    @State private var deleteIndexSet: IndexSet?
    
    //カレンダー表示に関する変数
    @State var date = Date()
    private let dateFormatter = DateFormatter()
    init(){
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "YYYY-MM-dd"
    }

    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        if ScheduleList.count != 0 {
                            ForEach(ScheduleList) { schedule in
                                NavigationLink(destination: ScheduleDetailView(scheduleinfo: select(for: schedule), companylist: CompanyList, internlist: InternList)){
                                    Text(schedule.title)
                                }
                            }.onDelete { indexSet in
                                deleteIndexSet = indexSet
                                deleteAlert = true
                            }.alert(isPresented: $deleteAlert){
                                Alert(
                                    title: Text("本当に削除しますか？"),
                                    message: Text("削除すると、そのデータを復元することはできません"),
                                    primaryButton: .cancel(),
                                    secondaryButton: .destructive(Text("削除"), action: {
                                        if let indexSet = deleteIndexSet {
                                            deleteSelectedScheduleInfo(at: indexSet)
                                            deleteIndexSet = nil
                                        }
                                    })
                                )
                            }
                        } else {
                            Text("スケジュールが登録されていません")
                        }
                    }
                    
                    //カレンダーセクション
                    Section(header: Text("カレンダー").font(.title3)){
                        VStack{
                            DatePicker("Calendar", selection: $date)
                                .environment(\.locale, Locale(identifier: "ja_JP"))
                                .labelsHidden()
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .frame(width: 300, height: 400)
                            //Text(dateFormatter.string(from: date))
                            //    .frame(maxWidth: .infinity, alignment: .center)
                            let selectiondate = dateFormatter.string(from: date)
                            Text(selectiondate)
                            let scheduleFilterfromStartdate = ScheduleList.filter {$0.start == selectiondate}
                            
                            let scheduleFilterfromEnddate = ScheduleList.filter {$0.end == selectiondate}
                            if ((scheduleFilterfromStartdate.count != 0) || (scheduleFilterfromEnddate.count != 0)){
                                
                                if (scheduleFilterfromStartdate.count != 0){
                                    ForEach(scheduleFilterfromStartdate) { schedule in
                                        Text("開始: \(schedule.title)")
                                    }
                                }
                                if (scheduleFilterfromEnddate.count != 0){
                                    ForEach(scheduleFilterfromEnddate) { schedule in
                                        Text("終了: \(schedule.title)")
                                    }
                                }
                            } else {
                                Text("この日に予定はありません")
                            }
                        }
                    }
                }
            }
            .navigationTitle("スケジュール")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ScheduleAddView(userid: LoginUser.id, schedulelist: $ScheduleList, companylist: $CompanyList, internlist: $InternList)) {
                        Text("追加")
                    }
                }
            }
            .onAppear(){
                apiCall().getCompanyInfoFromUserID(userID: LoginUser.id) { (corporate_info) in
                    self.CompanyList = corporate_info
                    let firstCompany = Corporate_info(id: "0", user: "", name: "未選択", Industry: "", Occupation: "", business: "", establishment: "", employees: "", capital: "", sales: "", operating_income: "", representative: "", location: "", registration: "", memo: "")
                    CompanyList.insert(firstCompany, at: 0)
                }
                
                print(CompanyList)
                
                apiCall().getInternshipInfoFromUserID(userID: LoginUser.id) { (intern) in
                    self.InternList = intern
                    let firstIntern = Internship_info(id: "0", user: "", company: "0", start: "", end: "", memo: "")
                    InternList.insert(firstIntern, at: 0)
                    print(InternList)
                }
                
                
                
                print(LoginUser)
                apiCall().getScheduleInfoFromUserID(userID: LoginUser.id){ (schedule) in
                    self.ScheduleList = schedule
                }
                print(ScheduleList)
                
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deleteSelectedScheduleInfo(at indexSet: IndexSet) {
        for index in indexSet{
            let item = ScheduleList[index]
            apiCall().deleteScheduleInfoToServer(id: item.id) { response in
                self.response = response
                if response == "OK" {
                    apiCall().getScheduleInfoFromUserID(userID: LoginUser.id) { (schedule) in
                        self.ScheduleList = schedule
                    }
                }
            }
        }
    }
    
    private func select(for schedule: Schedule) -> Binding<Schedule> {
        guard let scheduleIndex = ScheduleList.firstIndex(of: schedule) else {
            fatalError("Infomation not found")
        }
        return $ScheduleList[scheduleIndex]
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
