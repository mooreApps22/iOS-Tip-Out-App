//
//  RemoveButton.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//

import SwiftUI

struct RemoveButton: View {
    @ObservedObject var tipOutViewModel: TipOutViewModel
    @State var choice: Int
    
    
    init(tipOutViewModel: TipOutViewModel, choice: Int) {
        self.tipOutViewModel = tipOutViewModel
        self.choice = choice
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                if choice == 1 {
                    tipOutViewModel.remove()
                } else if choice == 2 {
                    tipOutViewModel.removeBarback()
                } else if choice == 3 {
                    tipOutViewModel.removeDepartment()
                } else {
                    tipOutViewModel.removeBarbackWithModifier()
                }
            } label: {
                Image(systemName: "arrowshape.backward.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
        }
        .padding(.horizontal)

    }
}

struct RemoveButton_Previews: PreviewProvider {
    static var previews: some View {
        RemoveButton(tipOutViewModel: TipOutViewModel(), choice: 1)
            .background(.black)
    }
}
