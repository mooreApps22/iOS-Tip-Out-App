//
//  BasicTextView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//

import SwiftUI
// MARK: VIEW



struct BasicTextView: View {
    // MARK: PROPERTIES
    
    @State var myText: String
    @State var myFont: CGFloat

    init(myText: String, myFont: CGFloat) {
        self.myText = myText
        self.myFont = myFont
    }
    
    // MARK: BODY
    var body: some View {
        
        Text(myText)
            .foregroundColor(.white)
            .font(.custom("Optima", size: myFont))
    }
}
// MARK: PREVIEWS
struct BasicTextView_Previews: PreviewProvider {
    static var previews: some View {
        BasicTextView(myText: "Hello", myFont: 30)
            .background(Color.black)
    }
}


