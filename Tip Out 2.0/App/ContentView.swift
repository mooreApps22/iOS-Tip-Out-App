//
//  ContentView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//  Copyright © 2022 Skyy Moore. All rights reserved.

import SwiftUI

// MARK: VIEW MODEL



class TipOutViewModel: ObservableObject {
    // MARK: State
    @Published var state: Int = 0
    
    
    // MARK: CustomKeyboard Inputs
    @Published var keyboardIsPresent: Bool = false
    @Published var keyboardUsesDigits: Bool = false
    @Published var digit: String = ""
    @Published var digitArray: [String] = []
    @Published var letter: String = ""
    @Published var letterArray: [String] = []
    
    // MARK: Bartender Properties
    @Published var bartenderTipPoolAmount: Double = 0.0
    @Published var barbackTipPoolAmount: Double = 0.0
    
    @Published var percentForBarbacks: Double = 0.0
    @Published var modifier: Double = 0.0
    
    @Published var bartenderName: String = ""
    @Published var barbackName: String = ""
    @Published var bartenderNameArray: [String] = []
    @Published var barbackNameArray: [String] = []
    @Published var bartenderHours: Double = 0.0
    @Published var barbackHours: Double = 0.0
    @Published var bartenderHoursArray: [Double] = []
    @Published var barbackHoursArray: [Double] = []
    
    @Published var nameForShow: String = ""
    @Published var namesForshow: [String] = []
    @Published var barbackHoursForShow: Double = 0.0
    @Published var arrayForShow: [Double] = []
    
    @Published var bartenderTotalHours: Double = 0.0
    @Published var barbackTotalHours: Double = 0.0
    @Published var bartenderHourlyRate: Double = 0.0
    @Published var barbackHourlyRate: Double = 0.0
    
    @Published var bartenderTipOutArray: [Double] = []
    @Published var barbackTipOutArray: [Double] = []
    
    // MARK: Waiter Properties
    
    @Published var waiterTipPoolAmount: Double = 0.0
    @Published var departmentName: String = ""
    @Published var departmentNames: [String] = []
    @Published var percentForBlankDepartment: Double = 0.0
    @Published var percentsForBlankDepartments: [Double] = []
    @Published var departmentsTipOut: Double = 0.0
    @Published var departmentTipOutArray: [Double] = []
    @Published var payOut: Double = 0.0
    @Published var waiterTipOut: Double = 0.0
    
    // MARK: Bartender Functions
    
    func recordBartenderTipPoolAmount() {
        let digitVar = digitArray.joined(separator: "")
        bartenderTipPoolAmount = Double(digitVar) ?? 0.0
    }
    
    func addNameOrHoursToList(isForName: Bool, isForBartender: Bool) {
        if isForName && isForBartender {
            let joinedLetterArray = letterArray.joined(separator: "")
            bartenderName = joinedLetterArray
            bartenderNameArray.append(bartenderName)
            bartenderName = ""
        } else if !isForName && isForBartender {
            let joinedDigitArray = digitArray.joined(separator: "")
            bartenderHours = Double(joinedDigitArray) ?? 0.0
            bartenderHoursArray.append(bartenderHours)
            bartenderHours = 0.0
        } else if isForName && !isForBartender {
            let joinedLetterArray = letterArray.joined(separator: "")
            barbackName = joinedLetterArray
            nameForShow = joinedLetterArray
            if modifier > 0 {
                bartenderNameArray.append(barbackName)
                namesForshow.append(nameForShow)
                barbackName = ""
            } else {
                barbackNameArray.append(barbackName)
                barbackName = ""
            }
            
        } else {
            let joinedDigitArray = digitArray.joined(separator: "")
                if modifier > 0 {
                    barbackHours = Double(joinedDigitArray) ?? 0.0
                    barbackHoursForShow = Double(joinedDigitArray) ?? 0.0
                    barbackHours = barbackHours * modifier // fix this
                    arrayForShow.append(barbackHoursForShow)
                    bartenderHoursArray.append(barbackHours)
                    barbackHours = 0.0
                } else {
                    barbackHours = Double(joinedDigitArray) ?? 0.0
                    barbackHoursArray.append(barbackHours)
                    barbackHours = 0.0
                }
            
        }
    }
    
    func calculateBartenderOrBarbackTipOut(isForBartender: Bool) {
        if isForBartender {
            bartenderTotalHours = bartenderHoursArray.reduce(0, +)
            bartenderHourlyRate = bartenderTipPoolAmount / bartenderTotalHours
            bartenderTipOutArray = bartenderHoursArray.map {
                $0 * bartenderHourlyRate
            }
        } else {
            barbackTotalHours = barbackHoursArray.reduce(0, +)
            barbackHourlyRate = barbackTipPoolAmount / barbackTotalHours
            barbackTipOutArray = barbackHoursArray.map {
                $0 * barbackHourlyRate
            }
        }
    }
    
    func recordPercentAndBothTipPools() {
        let joinedDigitArray = digitArray.joined(separator: "")
        let percent = Double(joinedDigitArray) ?? 0.0
        percentForBarbacks = percent / 100.0
        barbackTipPoolAmount = bartenderTipPoolAmount * percentForBarbacks
        bartenderTipPoolAmount = bartenderTipPoolAmount - barbackTipPoolAmount
        
    }
    
    func recordModifier() {
        let joinedDigitArray = digitArray.joined(separator: "")
        modifier = Double(joinedDigitArray) ?? 0.0
    }
    
    //MARK: Waiter Functions
    
    func recordWaiterTipPoolAmount() {
        let joinedDigitArray = digitArray.joined(separator: "")
        waiterTipPoolAmount = Double(joinedDigitArray) ?? 0.0
    }
    
    func addDepartmentNameOrPercentToList(isForName: Bool) {
        
        if isForName {
            let joinedLetterArray = letterArray.joined(separator: "")
            departmentName = joinedLetterArray
            departmentNames.append(departmentName)
            departmentName = ""
        } else {
            let joinedDigitArray = digitArray.joined(separator: "")
            let percent = Double(joinedDigitArray) ?? 0.0
            percentForBlankDepartment = percent / 100.0
            percentsForBlankDepartments.append(percentForBlankDepartment)
            percentForBlankDepartment = 0.0
        }
    }
    
    func calculateDepartmentTipOuts() {
        departmentTipOutArray = percentsForBlankDepartments.map {
            $0 * waiterTipPoolAmount
        }
        payOut = departmentTipOutArray.reduce(0, +)
        waiterTipOut = waiterTipPoolAmount - payOut
    }
    
    
    //MARK: Reset Function
    
   func reset() {
       // bartender
       bartenderTipPoolAmount = 0.0
       barbackTipPoolAmount = 0.0
       bartenderTotalHours = 0.0
       barbackTotalHours = 0.0
       bartenderHourlyRate = 0.0
       barbackHourlyRate = 0.0
       percentForBarbacks = 0.0
       modifier = 0.0
       barbackHoursForShow = 0.0
       bartenderNameArray.removeAll()
       bartenderHoursArray.removeAll()
       barbackNameArray.removeAll()
       barbackHoursArray.removeAll()
       bartenderTipOutArray.removeAll()
       barbackTipOutArray.removeAll()
       arrayForShow.removeAll()
       
       //waiter
       waiterTipPoolAmount = 0.0
       departmentName = ""
       departmentNames.removeAll()
       percentForBlankDepartment = 0.0
       percentsForBlankDepartments.removeAll()
       departmentsTipOut = 0.0
       departmentTipOutArray.removeAll()
       payOut = 0.0
       waiterTipOut = 0.0
       
       
    }
    
    func remove() {
        if bartenderNameArray.count == bartenderHoursArray.count {
            if bartenderNameArray.count >= 1 {
                bartenderNameArray.removeLast()
                bartenderHoursArray.removeLast()
            }
        } 
    }
    
    func removeBarback() {
        if barbackHoursArray.count == barbackNameArray.count  {
            if barbackNameArray.count >= 1 {
                if arrayForShow.count > 0 {
                    arrayForShow.removeLast()

                }
                barbackHoursArray.removeLast()
                barbackNameArray.removeLast()
            }
        }
    }
    
    func removeDepartment() {
        if departmentNames.count == percentsForBlankDepartments.count  {
            if departmentNames.count >= 1 {
                departmentNames.removeLast()
                percentsForBlankDepartments.removeLast()
            }
        }
    }
    
    func removeBarbackWithModifier() {
        if arrayForShow.count == namesForshow.count {
            if arrayForShow.count > 0 {
                       namesForshow.removeLast()
                       arrayForShow.removeLast()
                       bartenderNameArray.removeLast()
                       bartenderHoursArray.removeLast()
                   }
        }
    }
    
    
}


// MARK: VIEW
struct ContentView: View {
    // MARK: PROPERTIES
    
    @StateObject var tipOutViewModel: TipOutViewModel = TipOutViewModel()
    
    let myTransition: AnyTransition = .asymmetric(
        insertion: .scale(scale: 0.0, anchor: .topLeading),
        removal: .scale(scale: 0.0, anchor: .bottomTrailing))
    
    let myBackTransition: AnyTransition = .asymmetric(
        insertion: .scale(scale: 0.0, anchor: .trailing),
        removal: .scale(scale: 0.0, anchor: .leading))
    
    // MARK: BODY
    
    var body: some View {
        ZStack {
        // MARK: Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            //MARK: Content
            
            VStack {
                switch tipOutViewModel.state {
                case 0:
                    //MARK: Title
                    VStack {
                        titleMessage
                        Spacer()
                        Button {
                            withAnimation {
                                tipOutViewModel.state += 1
                            }
                        } label: {
                            startButtonLabel
                        }
                    }//v
                    .transition(myTransition)
                case 1:
                    //MARK: Bartender or Waiter
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                                                .transition(myBackTransition)
                    VStack {
                        
                        bartenderOrWaiterMessage
                        Spacer()
                        HStack {
                            Button {
                                withAnimation(.easeInOut) {
                                    tipOutViewModel.state += 1
                                }
                                
                            } label: {
                                bartenderButtonLabel
                            }
                            .padding()
                            Button {
                                withAnimation(.easeIn) {
                                    tipOutViewModel.state += 30
                                }
                            } label: {
                                waiterButtonLabel
                            }
                            .padding()
                        }
                    }//v
                    .transition(myTransition)
                    
                case 2:
                    //MARK: Barbacks?
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        
                                           didBarbacksWorkMessage
                                           Spacer()
                                           HStack {
                                               Button {
                                                   
                                                   withAnimation {
                                                       tipOutViewModel.state += 9
                                                   }
                                               } label: {
                                                   yesButtonLabel
                                               }
                                               .padding()
                                               Button {
                                                   withAnimation {
                                                       tipOutViewModel.state += 1
                                                   }
                                               } label: {
                                                   noButtonLabel
                                               }
                                               .padding()
                                           }
                    }//v
                    .transition(myTransition)
                    
                case 3:
                    //MARK: No Barbacks
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        
                                            enterTipPoolMessage
                                            Spacer()
                                            tipPoolDisplay
                                            Spacer()
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: true, digitEnterKey: 1, letterEnterKey: 0, doneKey: 0)
                    }//v
                    .transition(myTransition)
                    
                case 4:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        
                                            enterBartenderNameAndHoursMessage
                                            Spacer()
                                            NameAndHoursTableView(tipOutViewModel: tipOutViewModel, isForBartenders: true, isForShow: false)
                                            Spacer()
                        RemoveButton(tipOutViewModel: tipOutViewModel, choice: 1)
                                            NameAndHoursDisplayView(tipOutViewModel: tipOutViewModel, isForHours: true)
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: false, digitEnterKey: 2, letterEnterKey: 1, doneKey: 1)
                    }//v
                    .transition(myTransition)
                    
                case 5:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        
                                            TipOutReportView(tipOutViewModel: tipOutViewModel, isForBartender: true)
                                            Spacer()
                                            Button {
                                                tipOutViewModel.reset()
                                                withAnimation {
                                                    tipOutViewModel.state -= 5
                                                }
                                                
                                            } label: {
                                                recalculateButtonLabel
                                            }
                    }//v
                    .transition(myTransition)
                    
                    
                case 11:
                    //MARK: Method?
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 9)
                        .transition(myBackTransition)
                    VStack {
                                            whatMethodMessage
                                            Spacer()
                                            HStack {
                                                Button {
                                                    withAnimation {
                                                        tipOutViewModel.state += 1
                                                    }
                                                    
                                                } label: {
                                                    percentButtonLabel
                                                }
                                                .padding()
                                                Button {
                                                    withAnimation {
                                                        tipOutViewModel.state += 10
                                                    }
                                                    
                                                } label: {
                                                    modifiedButtonLabel
                                                }
                                                .padding()
                                            }
                                            
                    }//v
                    .transition(myTransition)
                    
                case 12:
                    //MARK: Percent
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterTipPoolMessage
                                            Spacer()
                                            tipPoolDisplay
                                            Spacer()
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: true, digitEnterKey: 1, letterEnterKey: 0, doneKey: 0)
                    }//v
                    .transition(myTransition)
                    
                case 13:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterPercentMessage
                                            Spacer()
                                            percentDisplay
                                            Spacer()
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: true, digitEnterKey: 3, letterEnterKey: 0, doneKey: 0)
                    }//v
                    .transition(myTransition)
                    
                case 14:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterBartenderNameAndHoursMessage
                                            Spacer()
                                            NameAndHoursTableView(tipOutViewModel: tipOutViewModel, isForBartenders: true, isForShow: false)
                                            Spacer()
                        RemoveButton(tipOutViewModel: tipOutViewModel, choice: 1)
                                            NameAndHoursDisplayView(tipOutViewModel: tipOutViewModel, isForHours: true)
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: false, digitEnterKey: 2, letterEnterKey: 1, doneKey: 1)
                    }//v
                    .transition(myTransition)
                    
                case 15:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterBarbackNameAndHoursMessage
                                            Spacer()
                                            NameAndHoursTableView(tipOutViewModel: tipOutViewModel, isForBartenders: false, isForShow: false)
                                            Spacer()
                        RemoveButton(tipOutViewModel: tipOutViewModel, choice: 2)
                                            NameAndHoursDisplayView(tipOutViewModel: tipOutViewModel, isForHours: true)
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: false, digitEnterKey: 4, letterEnterKey: 2, doneKey: 2)

                    }//v
                    .transition(myTransition)
                    
                case 16:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        TipOutReportView(tipOutViewModel: tipOutViewModel, isForBartender: true)
                                            Spacer()
                                            Button {
                                                tipOutViewModel.reset()
                                                withAnimation {
                                                    tipOutViewModel.state -= 16
                                                }
                                                
                                            } label: {
                                                recalculateButtonLabel
                                            }
                    }//v
                    .transition(myTransition)
                    
                    
                case 21:
                    //MARK: Modifier
                            BackButton(tipOutViewModel: tipOutViewModel, amount: 10)
                        .transition(myBackTransition)
                    VStack {
                        
                            enterTipPoolMessage
                            Spacer()
                            tipPoolDisplay
                            Spacer()
                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: true, digitEnterKey: 1, letterEnterKey: 0, doneKey: 0)
                    }//v
                    .transition(myTransition)
                    
                case 22:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterBarbackHourModifierMessage
                                            Spacer()
                                            InputDisplayView(tipOutViewModel: tipOutViewModel, isUsingDigits: true)
                                            Spacer()
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: true, digitEnterKey: 5, letterEnterKey: 0, doneKey: 0)
                    }//v
                    .transition(myTransition)
                    
                case 23:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterBartenderNameAndHoursMessage
                                            Spacer()
                                            NameAndHoursTableView(tipOutViewModel: tipOutViewModel, isForBartenders: true, isForShow: false)
                                            Spacer()
                        RemoveButton(tipOutViewModel: tipOutViewModel, choice: 1)
                                            NameAndHoursDisplayView(tipOutViewModel: tipOutViewModel, isForHours: true)
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: false, digitEnterKey: 2, letterEnterKey: 1, doneKey: 1)
                    }//v
                    .transition(myTransition)
                    
                case 24:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        enterBarbackNameAndHoursMessage
                        Spacer()
                        NameAndHoursTableView(tipOutViewModel: tipOutViewModel, isForBartenders: false, isForShow: true)
                        Spacer()
                        RemoveButton(tipOutViewModel: tipOutViewModel, choice: 4)
                        NameAndHoursDisplayView(tipOutViewModel: tipOutViewModel, isForHours: true)
                        CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: false, digitEnterKey: 4, letterEnterKey: 2, doneKey: 2)
                    }//v
                    .transition(myTransition)
                    
                case 25:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            TipOutReportView(tipOutViewModel: tipOutViewModel, isForBartender: true)
                                            Spacer()
                                            Button {
                                                tipOutViewModel.reset()
                                                withAnimation {
                                                    tipOutViewModel.state -= 25
                                                }
                                                
                                            } label: {
                                                recalculateButtonLabel
                                            }
                    }//v
                    .transition(myTransition)
                    
                    
                case 31:
                    //MARK: Waiter
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 30)
                        .transition(myBackTransition)
                    VStack {
                                            enterWaiterTipPoolMessage
                                            Spacer()
                                            tipPoolDisplay
                                            Spacer()
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: true, digitEnterKey: 6, letterEnterKey: 0, doneKey: 0)
                    }//v
                    .transition(myTransition)
                    
                case 32:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                                            enterDepartmentAndPercentMessage
                                            Spacer()
                                            NameAndPercentTableView(tipOutViewModel: tipOutViewModel)
                                            Spacer()
                        RemoveButton(tipOutViewModel: tipOutViewModel, choice: 3)
                                            NameAndHoursDisplayView(tipOutViewModel: tipOutViewModel, isForHours: false)
                                            CustomKeyboardView(tipOutViewModel: tipOutViewModel, keyboardUsesDigits: false, digitEnterKey: 7, letterEnterKey: 3, doneKey: 3)
                    }//v
                    .transition(myTransition)
                    
                case 33:
                    BackButton(tipOutViewModel: tipOutViewModel, amount: 1)
                        .transition(myBackTransition)
                    VStack {
                        TipOutReportView(tipOutViewModel: tipOutViewModel, isForBartender: false)
                                            Button {
                                                tipOutViewModel.reset()
                                                withAnimation {
                                                    tipOutViewModel.state -= 33
                                                }
                                                
                                            } label: {
                                                recalculateButtonLabel
                                            }
                    }//v
                    .transition(myTransition)
                    
                    
                case 91:
                    //MARK: Info Pages
                    bartenderOrWaiterInfo
                case 92:
                    didBarbacksWorkInfo
                case 93:
                    enterTipPoolInfo
                case 94:
                    enterBartenderNameAndHoursInfo
                case 101:
                    whatMethodInfo
                case 102:
                    enterTipPoolInfo
                case 103:
                    enterPercentInfo
                case 104:
                    enterBartenderNameAndHoursInfo
                case 105:
                    enterBarbackNameAndHoursInfo
                case 111:
                    enterTipPoolInfo
                case 112:
                    enterBarbackHourModifierInfo
                case 113:
                    enterBartenderNameAndHoursInfo
                case 114:
                    enterBarbackNameAndHoursInfo
                case 121:
                    enterWaiterTipPoolInfo
                default:
                    EmptyView()
                }//switch
           
                
            }//Vstack
            .padding()
        }//Zstack
        .environmentObject(tipOutViewModel)
    }//body
}//view
// MARK: PREVIEWS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: CONPONENTS


extension ContentView {
    //MARK: Messages
    private var titleMessage: some View {
        BasicTextView(myText: "TIP OUT", myFont: 90.0)
    }
    private var didBarbacksWorkMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Did any barbacks work this shift?", myFont: 30.0)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    private var whatMethodMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "What tip out method would you like to use?", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    private var enterTipPoolMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter the tip pool amount.", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    private var enterBartenderNameAndHoursMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter the name & hours for each bartender.", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
    private var enterPercentMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter the percent of the tip pool going to the barbacks?", myFont: 30.0)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
    private var enterBarbackNameAndHoursMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter the name & hours for each barback.", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
    private var enterBarbackHourModifierMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter a decimal modifier, between 0 and 1, for barbacks' hours.", myFont: 30 )
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
    private var bartenderOrWaiterMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Were you a bartender or a waiter for this shift?", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
    private var enterWaiterTipPoolMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter your tips for the shift?", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
    private var enterDepartmentAndPercentMessage: some View {
        HStack(alignment: .top) {
            BasicTextView(myText: "Enter each department name and their tip out percent.", myFont: 30)
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: true)
                .transition(myBackTransition)
        }
    }
    
   
    
    // MARK: Button Labels
    
    private var startButtonLabel: some View {
        BasicTextView(myText: "Start", myFont: 35.0)
            .frame(width: 250, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    private var yesButtonLabel: some View {
        BasicTextView(myText: "Yes", myFont: 35.0)
            .frame(width: 148, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    private var noButtonLabel: some View {
        BasicTextView(myText: "No", myFont: 35.0)
            .frame(width: 148, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    private var percentButtonLabel: some View {
        BasicTextView(myText: "Percent", myFont: 20.0)
            .frame(width: 148, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    private var modifiedButtonLabel: some View {
        BasicTextView(myText: "Modified Hours", myFont: 20.0)
            .frame(width: 148, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    
    
    private var bartenderButtonLabel: some View {
        BasicTextView(myText: "Bartender", myFont: 20.0)
            .frame(width: 148, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    
    private var waiterButtonLabel: some View {
        BasicTextView(myText: "Waiter", myFont: 20.0)
            .frame(width: 148, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    
    
    private var recalculateButtonLabel: some View {
        BasicTextView(myText: "Recalculate", myFont: 35.0)
            .frame(width: 250, height: 75)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
    }
    
    //MARK: Modified Displays
    private var tipPoolDisplay: some View {
        HStack(spacing: 0) {
            BasicTextView(myText: "$", myFont: 30)
            InputDisplayView(tipOutViewModel: tipOutViewModel, isUsingDigits: true)
        }
    }
    private var percentDisplay: some View {
        HStack(spacing: 0) {
            InputDisplayView(tipOutViewModel: tipOutViewModel, isUsingDigits: true)
            BasicTextView(myText: "%", myFont: 30)
        }
    }
    
}

// MARK: INFO PAGES

extension ContentView {
    
    private var bartenderOrWaiterInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "Choose the position you worked during this shift.", myFont: 30)
            Spacer()
        }
    }
    
    private var didBarbacksWorkInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "Press yes if you want to tip out barbacks for this shift, or press no, if no barbacks worked.", myFont: 30)
            Spacer()
        }
    }
    
    
    private var whatMethodInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            VStack(alignment: .leading) {
                BasicTextView(myText: "The Percent Method", myFont: 30)
                    .underline()
                BasicTextView(myText: "The app calculates your chosen percentage of the Tip pool for the barbacks to split and the bartenders split the remaining tip pool.", myFont: 30)
                BasicTextView(myText: "The Modified Hour Method", myFont: 30)
                    .underline()
                BasicTextView(myText: "The bartenders and barback split the entire tip pool together, but barback hours are worth less than the bartenders' based your chosen hour modifier, for example 0.5, would be multiplied by the barbacks' hours.", myFont: 30)
            }
            
            Spacer()
        }
    }
    
    private var enterTipPoolInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "The Tip Pool is the collective gratuity earned during this shift. That includes cash tips, credit card tips, and money tipped out to the bar from the wait staff.", myFont: 30)
            Spacer()
        }
    }
    
    private var enterBartenderNameAndHoursInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "Type in the name of each bartender who worked during this shift and press Enter. Then type in the number of hours they worked during this shift and press Enter. Repeat for each bartender and press Done when you have finished.", myFont: 30)
            Spacer()
        }
    }
    
    private var enterPercentInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "Enter a number between 0 and 100. Do not worry about including a decimal. This app will then subtract this amount from the tip pool and divide it for the barbacks.", myFont: 30)
            Spacer()
        }
    }
    
    private var enterBarbackHourModifierInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "This modifier is a decimal number between 0 and 1, such as 0.5. This number will by multiplied by the barbacks' hours so they make less money per hour than the bartenders.", myFont: 30)
            Spacer()
        }
    }
    
    private var enterBarbackNameAndHoursInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "Type in the name of each barback who worked during this shift and press Enter. Then type in the number of hours they worked during this shift and press Enter. Repeat for each barback and press Done when you have finished.", myFont: 30)
            Spacer()
        }
    }
    
    private var enterWaiterTipPoolInfo: some View {
        
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "The Tip Pool is all the gratuity earn during the shift. That includes cash and credit card tips.", myFont: 30)
            Spacer()
        }
    }
    
    private var enterDepartmentAndPercentInfo: some View {
        VStack(alignment: .trailing) {
            InfoView(tipOutViewModel: tipOutViewModel, stateIncrement: 90, goesToInfoPage: false)
            BasicTextView(myText: "Enter the name for the support staff, for example Bar or Bussers. Then enter the percent you tip them out, for example 18% or 5%.", myFont: 30)
            Spacer()
        }
    }
    
}



