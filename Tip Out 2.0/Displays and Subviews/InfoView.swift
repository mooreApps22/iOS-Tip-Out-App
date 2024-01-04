//
//  InfoView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//

import SwiftUI

struct InfoView: View {
    
    @ObservedObject var tipOutViewModel: TipOutViewModel
    @State var stateIncrement: Int
    @State var goesToInfoPage: Bool

    init(tipOutViewModel: TipOutViewModel, stateIncrement: Int, goesToInfoPage: Bool) {
        self.tipOutViewModel = tipOutViewModel
        self.stateIncrement = stateIncrement
        self.goesToInfoPage = goesToInfoPage
    }
    
    
    var body: some View {
        Button {
            if goesToInfoPage {
                withAnimation {
                    tipOutViewModel.state += stateIncrement
                }
                
            } else {
                withAnimation {
                    tipOutViewModel.state -= stateIncrement
                }
                
            }
            
        } label: {
            if goesToInfoPage {
                Image(systemName: "info.circle")
                    .frame(width: 26, height: 26)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            } else {
                VStack(alignment: .trailing) {
                    Image(systemName: "xmark")
                        .frame(width: 30, height: 30)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    HStack {
                        BasicTextView(myText: "INFO", myFont: 30)
                            .underline()
                        Spacer()
                    }
                }
            }
            
        }

    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(tipOutViewModel: TipOutViewModel(), stateIncrement: 1, goesToInfoPage: true)
            .background(Color.black)
    }
}
