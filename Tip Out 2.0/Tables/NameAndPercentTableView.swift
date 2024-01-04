//
//  NameAndPercentTableView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//


import SwiftUI
// MARK: VIEW
struct NameAndPercentTableView: View {
    
    // MARK: PROPERTIES
    
    @ObservedObject var tipOutViewModel: TipOutViewModel
    
    init(tipOutViewModel: TipOutViewModel) {
        self.tipOutViewModel = tipOutViewModel
    }
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            HStack(spacing: 100) {
                VStack(alignment: .leading) {
                    nameHeading
                    departmentNamesTable
                    Spacer()
                }
                .padding()
                VStack(alignment: .leading) {
                    percentHeading
                    percentTable
                    Spacer()
                }
                .padding()
            }//Hstack
        }//scroll
    }//body
}//view


// MARK: PREVIEWS
struct NameAndPercentTableView_Previews: PreviewProvider {
    static var previews: some View {
        NameAndPercentTableView(tipOutViewModel: TipOutViewModel())
            .background(Color.black)
    }
}

// MARK: CONPONENTS

extension NameAndPercentTableView {
    
    //MARK: Headings
    private var nameHeading: some View {
        BasicTextView(myText: "Names", myFont: 25.0)
    }
    private var percentHeading: some View {
        BasicTextView(myText: "Percent", myFont: 25.0)
    }
    
    //MARK: Waiter Tables
    private var departmentNamesTable: some View {
        ForEach(tipOutViewModel.departmentNames, id: \.self) {
            name in
            BasicTextView(myText: name.capitalized, myFont: 20)
        }
    }
    private var percentTable: some View {
        ForEach(tipOutViewModel.percentsForBlankDepartments, id: \.self) {
            percent in
            BasicTextView(myText: String(format:"%.2f", percent), myFont: 20)
        }
    }
    
}
