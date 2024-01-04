//
//  CustomKeyboardView.swift
//  Tip Out 2.0
//
//  Created by Skyy Moore on 10/31/22.
//

import SwiftUI
// MARK: VIEW


struct CustomKeyboardView: View {
    // MARK: PROPERTIES
    
    @ObservedObject var tipOutViewModel: TipOutViewModel
    @State var keyboardUsesDigits: Bool
    @State var digitEnterKey: Int
    @State var letterEnterKey: Int
    @State var doneKey: Int
    
    init(tipOutViewModel: TipOutViewModel, keyboardUsesDigits: Bool, digitEnterKey: Int, letterEnterKey: Int, doneKey: Int) {
        self.tipOutViewModel = tipOutViewModel
        self.keyboardUsesDigits = keyboardUsesDigits
        self.digitEnterKey = digitEnterKey
        self.letterEnterKey = letterEnterKey
        self.doneKey = doneKey
    }
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 1) {

            if keyboardUsesDigits {
                // MARK: DIGIT KEYBOARD
                HStack(spacing: 1) {
                    DigitKeyView(key: "1", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "2", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "3", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                }//row1
                HStack(spacing: 1) {
                    DigitKeyView(key: "4", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "5", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "6", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                }//row2
                HStack(spacing: 1) {
                    DigitKeyView(key: "7", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "8", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "9", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                }//row3
                HStack(spacing: 1) {
                    DecimalKeyView(key: ".", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitKeyView(key: "0", digit: $tipOutViewModel.digit, digitArray: $tipOutViewModel.digitArray)
                    DigitDeleteKeyView(digitArray: $tipOutViewModel.digitArray)
            }//row4
                HStack(spacing: 1){
                    // MARK: DigitEnterKey Switch
                    switch digitEnterKey {
                    case 1:
                        BartenderTipPoolAmountEnterKeyView(digitArray: $tipOutViewModel.digitArray)
                    case 2:
                        BartenderHoursEnterKeyView(digitArray: $tipOutViewModel.digitArray, letterArray: $tipOutViewModel.letterArray, keyboardUsesDigits: $keyboardUsesDigits)
                    case 3:
                        PercentEnterKeyView(digitArray: $tipOutViewModel.digitArray)
                    case 4:
                        BarbackHoursEnterKeyView(digitArray: $tipOutViewModel.digitArray, letterArray: $tipOutViewModel.letterArray, keyboardUsesDigits: $keyboardUsesDigits)
                    case 5:
                        ModifierEnterKeyView(digitArray: $tipOutViewModel.digitArray)
                    case 6:
                        WaiterTipPoolAmountEnterKeyView(digitArray: $tipOutViewModel.digitArray)
                    case 7:
                        DepartmentPercentEnterKeyView(digitArray: $tipOutViewModel.digitArray, letterArray: $tipOutViewModel.letterArray, keyboardUsesDigits: $keyboardUsesDigits)
                    default:
                        EmptyView()
                    }
                }//row5
                
            } else {
                // MARK: LETTER KEYBOARD
                HStack(spacing: 1) {
                    LetterKeyView(key: "q", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "w", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "e", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "r", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "t", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "y", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "u", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "i", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "o", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "p", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                }//row1
                HStack(spacing: 1) {
                    LetterKeyView(key: "-", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "a", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "s", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "d", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "f", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "g", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "h", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "j", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "k", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "l", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                }//row2
                HStack(spacing: 1) {
                    LetterKeyView(key: "z", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "x", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "c", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "v", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "b", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "n", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: "m", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterKeyView(key: ".", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    LetterDeleteKeyView(textArray: $tipOutViewModel.letterArray)
                }//row3
                HStack (spacing: 1) {
                    // MARK: DoneKey Switch
                    switch doneKey {
                    case 1:
                        LetterBartenderDoneKeyView()
                    case 2:
                        LetterBarbackDoneKeyView()
                    case 3:
                        LetterWaiterDoneKeyView()
                    default:
                        EmptyView()
                    }
                    
                    LetterSpaceBarKeyView(key: " ", letter: $tipOutViewModel.letter, letterArray: $tipOutViewModel.letterArray)
                    
                    //MARK: LetterEnterKey Switch
                    switch letterEnterKey {
                    case 1:
                        LetterBartenderNameEnterKeyView(letterArray: $tipOutViewModel.letterArray, keyboardUsesDigits: $keyboardUsesDigits)
                    case 2:
                        LetterBarbackNameEnterKeyView(letterArray: $tipOutViewModel.letterArray, keyboardUsesDigits: $keyboardUsesDigits)
                    case 3:
                        LetterDepartmentNameEnterKeyView(letterArray: $tipOutViewModel.letterArray, keyboardUsesDigits: $keyboardUsesDigits)
                    default:
                        EmptyView()
                    }
                    
                }//row4
            }//conditional
           

            
        }//Vstack
    }//body
}//view


// MARK: PREVIEWS
struct CustomKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomKeyboardView(tipOutViewModel: TipOutViewModel(), keyboardUsesDigits: true, digitEnterKey: 0, letterEnterKey: 1, doneKey: 1)
    }
}

// MARK: CONPONENTS



    extension CustomKeyboardView {
        // MARK: DIGIT KEYS
        
        
        
                //MARK: Numberic Keys
        struct DigitKeyView: View {
            let key: String
            @Binding var digit: String
            @Binding var digitArray: [String]
            
            var body: some View {
                Button {
                    digitArray.append(key)
                } label: {
                    BasicTextView(myText: key, myFont: 30.0)
                        .frame(width: 60, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        struct DecimalKeyView: View {
            let key: String
            @Binding var digit: String
            @Binding var digitArray: [String]
            
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        digitArray.append(key)
                    }
                    
                } label: {
                    BasicTextView(myText: key, myFont: 30.0)
                        .frame(width: 60, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }

                //MARK: Delete Key
        struct DigitDeleteKeyView: View {
         
            @Binding var digitArray: [String]
            
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        digitArray.removeLast()
                    }
                } label: {
                    BasicTextView(myText: "DEL", myFont: 22.0)
                        .frame(width: 60, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
                //MARK: Enter Keys
        
        struct BartenderTipPoolAmountEnterKeyView: View {
            @Binding var digitArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        tipOutViewModel.recordBartenderTipPoolAmount()
                                                digitArray.removeAll()
                                            withAnimation {
                                                tipOutViewModel.state += 1
                                            }
                                               
                    }
                        
                } label: {
                    BasicTextView(myText: "ENTER", myFont: 20)
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        
        struct BartenderHoursEnterKeyView: View {
            @Binding var digitArray: [String]
            @Binding var letterArray: [String]
            @Binding var keyboardUsesDigits: Bool
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        tipOutViewModel.addNameOrHoursToList(isForName: false, isForBartender: true)
                        digitArray.removeAll()
                        letterArray.removeAll()
                        keyboardUsesDigits = false
                    }
                    
                } label: {
                    BasicTextView(myText: "ENTER", myFont: 20)
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }

            }
        }
        
        struct PercentEnterKeyView: View {
            
            @Binding var digitArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        tipOutViewModel.recordPercentAndBothTipPools()
                                                digitArray.removeAll()
                                            withAnimation {
                                                tipOutViewModel.state += 1
                                            }
                    }
                        
                        
                } label: {
                    Text("ENTER")
                        .foregroundColor(.white)
                        .font(.custom("Optima", size: 20))
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        struct BarbackHoursEnterKeyView: View {
            @Binding var digitArray: [String]
            @Binding var letterArray: [String]
            @Binding var keyboardUsesDigits: Bool
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    tipOutViewModel.addNameOrHoursToList(isForName: false, isForBartender: false)
                    digitArray.removeAll()
                    letterArray.removeAll()
                    keyboardUsesDigits = false
                } label: {
                    BasicTextView(myText: "ENTER", myFont: 20)
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }

            }
        }
        
        struct ModifierEnterKeyView: View {
            
            @Binding var digitArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            
            var body: some View {
                Button {
                        tipOutViewModel.recordModifier()
                    if tipOutViewModel.modifier > 0 && tipOutViewModel.modifier < 1 {
                        digitArray.removeAll()
                        withAnimation {
                            tipOutViewModel.state += 1
                        }
                        
                    }
                        
                } label: {
                    Text("ENTER")
                        .foregroundColor(.white)
                        .font(.custom("Optima", size: 20))
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        struct BarbackHoursWithModifierEnterKeyView: View {
            @Binding var digitArray: [String]
            @Binding var letterArray: [String]
            @Binding var keyboardUsesDigits: Bool
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        tipOutViewModel.addNameOrHoursToList(isForName: false, isForBartender: false)
                                            digitArray.removeAll()
                                            letterArray.removeAll()
                                            keyboardUsesDigits = false
                    }
                } label: {
                    BasicTextView(myText: "ENTER", myFont: 20)
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }

            }
        }
        
        struct WaiterTipPoolAmountEnterKeyView: View {
            @Binding var digitArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        tipOutViewModel.recordWaiterTipPoolAmount()
                                                digitArray.removeAll()
                                            withAnimation {
                                                tipOutViewModel.state += 1
                                            }
                                                
                    }
                } label: {
                    BasicTextView(myText: "ENTER", myFont: 20)
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        struct DepartmentPercentEnterKeyView: View {
            @Binding var digitArray: [String]
            @Binding var letterArray: [String]
            @Binding var keyboardUsesDigits: Bool
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    if digitArray.count >= 1 {
                        tipOutViewModel.addDepartmentNameOrPercentToList(isForName: false)
                                            digitArray.removeAll()
                                            letterArray.removeAll()
                                            keyboardUsesDigits = false

                    }
                    
                } label: {
                    BasicTextView(myText: "ENTER", myFont: 20)
                        .frame(width: 178, height: 40)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }

            }
        }
        
        
        
        //MARK: LETTER KEYS
        
        
        
                //MARK: Alphabetic Keys
        
        struct LetterKeyView: View {
            
            let key: String
            @Binding var letter: String
            @Binding var letterArray: [String]

            var body: some View {
                Button {
                    letterArray.append(key)
                } label: {
                    BasicTextView(myText: key.capitalized, myFont: 20)
                        .frame(width: 38, height: 50)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                    }
                }
            }
            
                //MARK: Space Bar
        struct LetterSpaceBarKeyView: View {
            
            let key: String
            @Binding var letter: String
            @Binding var letterArray: [String]
            
            var body: some View {
                Button {
                    letterArray.append(key)
                } label: {
                    BasicTextView(myText: key, myFont: 20.0)
                        .frame(width: 186, height: 50)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
                //MARK: Delete Key
        struct LetterDeleteKeyView: View {
            
            @Binding var textArray: [String]
            
            var body: some View {
                    Button {
                        if textArray.count >= 1 {
                            textArray.removeLast()
                        }
                    } label: {
                        BasicTextView(myText: "DEL", myFont: 20.0)
                            .frame(width: 56, height: 50)
                            .background(Color.black)
                            .cornerRadius(10.0)
                            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                    }
            }
        }
        
                //MARK: Enter Keys
        struct LetterBartenderNameEnterKeyView: View {
            
            @Binding var letterArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            @Binding var keyboardUsesDigits: Bool
            
            var body: some View {
                    Button {
                        if letterArray.count >= 1 {
                            tipOutViewModel.addNameOrHoursToList(isForName: true, isForBartender: true)
                            keyboardUsesDigits = true
                        }
                    } label: {
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.custom("Optima", size: 20))
                            .frame(width: 75, height: 50)
                            .background(Color.black)
                            .cornerRadius(10.0)
                            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                    }
            }
        }
        
        struct LetterBarbackNameEnterKeyView: View {
            
            @Binding var letterArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            @Binding var keyboardUsesDigits: Bool
            
            var body: some View {
                    Button {
                        if letterArray.count >= 1 {
                            tipOutViewModel.addNameOrHoursToList(isForName: true, isForBartender: false)
                            keyboardUsesDigits = true
                        }
                    } label: {
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.custom("Optima", size: 20))
                            .frame(width: 75, height: 50)
                            .background(Color.black)
                            .cornerRadius(10.0)
                            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                    }
            }
        }
        
        struct LetterDepartmentNameEnterKeyView: View {
            
            @Binding var letterArray: [String]
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            @Binding var keyboardUsesDigits: Bool
            
            var body: some View {
                    Button {
                        if letterArray.count >= 1 {
                            tipOutViewModel.addDepartmentNameOrPercentToList(isForName: true)
                            keyboardUsesDigits = true
                        }
                        
                    } label: {
                        Text("ENTER")
                            .foregroundColor(.white)
                            .font(.custom("Optima", size: 20))
                            .frame(width: 75, height: 50)
                            .background(Color.black)
                            .cornerRadius(10.0)
                            .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                    }
            }
        }
        
                    //MARK: Done Key
        struct LetterBartenderDoneKeyView: View {
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    tipOutViewModel.calculateBartenderOrBarbackTipOut(isForBartender: true)
                    withAnimation {
                        tipOutViewModel.state += 1
                    }
                } label: {
                    BasicTextView(myText: "DONE", myFont: 20)
                        .frame(width: 75, height: 50)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        struct LetterBarbackDoneKeyView: View {
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    tipOutViewModel.calculateBartenderOrBarbackTipOut(isForBartender: true)
                    tipOutViewModel.calculateBartenderOrBarbackTipOut(isForBartender: false)
                    withAnimation {
                        tipOutViewModel.state += 1
                    }
                } label: {
                    BasicTextView(myText: "DONE", myFont: 20)
                        .frame(width: 75, height: 50)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
        struct LetterWaiterDoneKeyView: View {
            @EnvironmentObject var tipOutViewModel: TipOutViewModel
            var body: some View {
                Button {
                    tipOutViewModel.calculateDepartmentTipOuts()
                    withAnimation {
                        tipOutViewModel.state += 1
                    }
                } label: {
                    BasicTextView(myText: "DONE", myFont: 20)
                        .frame(width: 75, height: 50)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .shadow(color: .white.opacity(0.25), radius: 10, x: 1, y: 1)
                }
            }
        }
        
    }//extension
