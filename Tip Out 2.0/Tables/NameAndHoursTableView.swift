//
//  NameAndHoursTableView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//

import SwiftUI
// MARK: VIEW



struct NameAndHoursTableView: View {
    // MARK: PROPERTIES
    
    @ObservedObject var tipOutViewModel: TipOutViewModel
    @State var isForBartenders: Bool
    @State var isForShow: Bool
    
    init(tipOutViewModel: TipOutViewModel, isForBartenders: Bool, isForShow: Bool) {
        self.tipOutViewModel = tipOutViewModel
        self.isForBartenders = isForBartenders
        self.isForShow = isForShow
    }
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            HStack(spacing: 100) {
                
                if isForBartenders && !isForShow {
                    VStack(alignment: .leading) {
                        nameHeading
                        bartenderNamesTable
                        Spacer()
                        
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        hoursHeading
                        bartenderHoursTable
                        Spacer()
                    }
                    .padding()
                } else if !isForBartenders && !isForShow {
                    VStack(alignment: .leading) {
                        nameHeading
                        barbackNamesTable
                        Spacer()
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        hoursHeading
                        barbackHoursTable
                        Spacer()
                    }
                    .padding()
                } else if isForShow {
                    VStack(alignment: .leading) {
                        nameHeading
                        barbackForShowNamesTable
                        Spacer()
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        hoursHeading
                        forShowBarbackHoursTable
                        Spacer()
                    }
                    .padding()
                }
                
            }//hstack
            
        }//scroll
    }//body
}//view
// MARK: PERVIEWS
struct NameAndHoursTableView_Previews: PreviewProvider {
    static var previews: some View {
        NameAndHoursTableView(tipOutViewModel: TipOutViewModel(), isForBartenders: true, isForShow: false)
            .background(Color.black)
    }
}
// MARK: CONPONENTS


extension NameAndHoursTableView {
    
    //MARK: Headings
    private var nameHeading: some View {
        BasicTextView(myText: "Names", myFont: 25.0)
    }
    private var hoursHeading: some View {
        BasicTextView(myText: "Hours", myFont: 25.0)
    }
    
    //MARK: Bartender Tables
    private var bartenderNamesTable: some View {
        ForEach(tipOutViewModel.bartenderNameArray, id: \.self) {
            name in
            BasicTextView(myText: name.capitalized, myFont: 20)
        }
    }
    private var bartenderHoursTable: some View {
        ForEach(tipOutViewModel.bartenderHoursArray, id: \.self) {
            hours in
            BasicTextView(myText: String(format:"%.2f", hours), myFont: 20)
        }
    }
    
    //MARK: Barback Tables
    private var barbackNamesTable: some View {
        ForEach(tipOutViewModel.barbackNameArray, id: \.self) {
            name in
            BasicTextView(myText: name.capitalized, myFont: 20)
        }
    }
    
    private var barbackHoursTable: some View {
        ForEach(tipOutViewModel.barbackHoursArray, id: \.self) {
            hours in
            BasicTextView(myText: String(format:"%.2f", hours), myFont: 20)
        }
    }
    
    private var barbackForShowNamesTable: some View {
        ForEach(tipOutViewModel.namesForshow, id: \.self) {
            name in
            BasicTextView(myText: name.capitalized, myFont: 20)
        }
    }
    
    private var forShowBarbackHoursTable: some View {
        ForEach(tipOutViewModel.arrayForShow, id: \.self) {
            hours in
            BasicTextView(myText: String(format:"%.2f", hours), myFont: 20)
        }
    }
    
}
