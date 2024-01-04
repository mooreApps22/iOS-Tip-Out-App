//
//  TipOutReportView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//

import SwiftUI
// MARK: VIEW


struct TipOutReportView: View {
    // MARK: PROPERTIES
    
    @ObservedObject var tipOutViewModel: TipOutViewModel
    @State var isForBartender: Bool
    
    init(tipOutViewModel: TipOutViewModel, isForBartender: Bool) {
        self.tipOutViewModel = tipOutViewModel
        self.isForBartender = isForBartender
    }
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                reportTitle
                
                // MARK: Bartender
                if isForBartender {
                    if tipOutViewModel.barbackTipPoolAmount > 0.0 {
                        tipPoolRow
                        bartenderTipPoolRow
                        barbackTipPoolRow
                    } else {
                        tipPoolRow
                    }
                    
                    if tipOutViewModel.percentForBarbacks > 0.0 {
                       percentRow
                    }
                    
                    if tipOutViewModel.modifier > 0.0 {
                        modifierRow
                    }
                    
                    if tipOutViewModel.barbackTotalHours > 0.0 {
                        bartenderTotalHoursRow
                        barbackTotalHoursRow
                    } else {
                        totalHoursRow
                    }
                   
                    if tipOutViewModel.barbackHourlyRate > 0.0 {
                        bartenderHourlyRateRow
                        barbackHourlyRateRow
                    } else {
                        hourlyRateRow
                    }
                    
                    tipOutTable
                    barbackTipOutTable
                    
                    
                } else {
                    // MARK: Waiter
                    
                    waiterTipPoolRow
                    waiterTipOutTable
                    waiterTipOutRow
                    
                }
                
                
               
                
                
            }//Vstack
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .padding()
        }//scroll
    }//body
}//view
// MARK: PREVIEWS
struct TipOutReportView_Previews: PreviewProvider {
    static var previews: some View {
        TipOutReportView(tipOutViewModel: TipOutViewModel(), isForBartender: true)
            .background(Color.black)
    }
}
// MARK: CONPONENTS

extension TipOutReportView {
    private var reportTitle: some View {
        BasicTextView(myText: "Tip Out Report", myFont: 50)
    }
    
    // MARK: Bartender
    private var tipPoolRow: some View {
        HStack {
            BasicTextView(myText: "Tip Pool", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format:"%.2f", tipOutViewModel.bartenderTipPoolAmount + tipOutViewModel.barbackTipPoolAmount), myFont: 25)
        }
    }
    
    private var percentRow: some View {
        HStack {
            BasicTextView(myText: "Barback's Percent", myFont: 25)
            Spacer()
            BasicTextView(myText: String(format: "%.0f", tipOutViewModel.percentForBarbacks * 100) + "%", myFont: 25)
        }
    }
    
    private var modifierRow: some View {
        HStack {
            BasicTextView(myText: "Barbacks' Hour Modifier", myFont: 25)
            Spacer()
            BasicTextView(myText: String(format: "%.2f", tipOutViewModel.modifier), myFont: 25)
        }
    }
    
    private var bartenderTipPoolRow: some View {
        HStack {
            BasicTextView(myText: "Bartender's Tip Pool", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format:"%.2f", tipOutViewModel.bartenderTipPoolAmount), myFont: 25)
        }
    }
    
    private var barbackTipPoolRow: some View {
        HStack {
            BasicTextView(myText: "Barback's Tip Pool", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format:"%.2f", tipOutViewModel.barbackTipPoolAmount), myFont: 25)
        }
    }
    
    private var totalHoursRow: some View {
        HStack {
            BasicTextView(myText: "Total Hours", myFont: 25)
            Spacer()
            BasicTextView(myText:String(format:"%.2f", tipOutViewModel.bartenderTotalHours), myFont: 25)
        }
        
    }
    
    private var bartenderTotalHoursRow: some View {
        HStack {
            BasicTextView(myText: "Total Bartenders' Hours", myFont: 25)
            Spacer()
            BasicTextView(myText:String(format:"%.2f", tipOutViewModel.bartenderTotalHours), myFont: 25)
        }
        
    }
    
    private var barbackTotalHoursRow: some View {
        HStack {
            BasicTextView(myText: "Total Barbacks' Hours", myFont: 25)
            Spacer()
            BasicTextView(myText:String(format:"%.2f", tipOutViewModel.barbackTotalHours), myFont: 25)
        }
        
    }
    
    private var hourlyRateRow: some View {
        HStack {
            BasicTextView(myText: "Hourly Rate", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format: "%.2f", tipOutViewModel.bartenderHourlyRate) + "/hr", myFont: 25)
        }
    }
    
    private var bartenderHourlyRateRow: some View {
        HStack {
            BasicTextView(myText: "Bartenders' Hourly Rate", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format: "%.2f", tipOutViewModel.bartenderHourlyRate) + "/hr", myFont: 25)
        }
    }
    
    private var barbackHourlyRateRow: some View {
        HStack {
            BasicTextView(myText: "Barbacks' Hourly Rate", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format: "%.2f", tipOutViewModel.barbackHourlyRate) + "/hr", myFont: 25)
        }
    }
    
    
    
    private var tipOutTable: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(tipOutViewModel.bartenderNameArray, id: \.self) {
                    name in
                    BasicTextView(myText: name.capitalized + "'s Tips", myFont: 25)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 15) {
                ForEach(tipOutViewModel.bartenderTipOutArray, id: \.self) {
                    tipOut in
                    BasicTextView(myText: "$" + String(format:"%.2f", tipOut), myFont: 25)
                }
            }
        }
    }
    // MARK: Barback
    
    private var barbackTipOutTable: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(tipOutViewModel.barbackNameArray, id: \.self) {
                    name in
                    BasicTextView(myText: name.capitalized + "'s Tips", myFont: 25)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 15) {
                ForEach(tipOutViewModel.barbackTipOutArray, id: \.self) {
                    tipOut in
                    BasicTextView(myText: "$" + String(format:"%.2f", tipOut), myFont: 25)
                }
            }
        }
    }
    // MARK: Waiter
    
    private var waiterTipPoolRow: some View {
        HStack {
            BasicTextView(myText: "Waiter's Gross Tips", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format:"%.2f", tipOutViewModel.waiterTipPoolAmount), myFont: 25)
        }
    }
    
    private var waiterTipOutTable: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(tipOutViewModel.departmentNames, id: \.self) {
                    name in
                    BasicTextView(myText: name.capitalized + " Tip Out", myFont: 25)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 15) {
                ForEach(tipOutViewModel.departmentTipOutArray, id: \.self) {
                    tipOut in
                    BasicTextView(myText: "$" + String(format:"%.2f", tipOut), myFont: 25)
                }
            }
        }
    }
    
    private var waiterTipOutRow: some View {
        HStack {
            BasicTextView(myText: "Waiter's Net Tips", myFont: 25)
            Spacer()
            BasicTextView(myText: "$" + String(format:"%.2f", tipOutViewModel.waiterTipOut), myFont: 25)
        }
    }
    
    
}
